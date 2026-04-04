import os
import uuid
from typing import Optional
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from dotenv import load_dotenv
import anthropic

from database import run_query
from agent import ask_agent, get_history, clear_session

load_dotenv()

app = FastAPI(title="ACME Insurances — Bedrijfskosten API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        os.getenv("FRONTEND_URL", "http://localhost:5173"),
        "http://localhost:5173",
        "http://localhost:3000",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ─── Pydantic modellen ───────────────────────────────────────────────────────

class ChatRequest(BaseModel):
    session_id: Optional[str] = None
    question: str


class FindingsRequest(BaseModel):
    divisie: Optional[str] = None
    onderdeel: Optional[str] = None
    kostenplaats_id: Optional[int] = None
    kostensoort: Optional[str] = None
    periode_van: Optional[str] = None
    periode_tot: Optional[str] = None
    label: Optional[str] = None
    jaar: Optional[str] = "2026"


# ─── Hulpfunctie filters ─────────────────────────────────────────────────────

def build_filter_conditions(
    divisie=None, onderdeel=None, kostenplaats_id=None,
    kostensoort=None, periode_van=None, periode_tot=None,
    label=None, jaar=None
) -> tuple[str, dict]:
    conditions = []
    params = {}

    if divisie:
        conditions.append("b.divisie = :divisie")
        params["divisie"] = divisie
    if onderdeel:
        conditions.append("b.onderdeel = :onderdeel")
        params["onderdeel"] = onderdeel
    if kostenplaats_id:
        conditions.append("b.kostenplaats_id = :kostenplaats_id")
        params["kostenplaats_id"] = kostenplaats_id
    if kostensoort:
        conditions.append("b.kostensoort = :kostensoort")
        params["kostensoort"] = kostensoort
    if periode_van:
        conditions.append("b.periode >= :periode_van")
        params["periode_van"] = periode_van
    if periode_tot:
        conditions.append("b.periode <= :periode_tot")
        params["periode_tot"] = periode_tot
    if label:
        conditions.append("b.label = :label")
        params["label"] = label
    if jaar:
        conditions.append("b.periode LIKE :jaar")
        params["jaar"] = f"{jaar}%"

    where = "WHERE " + " AND ".join(conditions) if conditions else ""
    return where, params


# ─── Endpoints ───────────────────────────────────────────────────────────────

@app.get("/health")
def health():
    return {"status": "ok", "service": "ACME Insurances API"}


@app.get("/api/filters")
def get_filter_options():
    """Geef alle beschikbare filterwaarden terug voor de dropdowns."""
    divisies = run_query("SELECT DISTINCT divisie FROM bedrijfskosten ORDER BY divisie")
    onderdelen = run_query("SELECT DISTINCT onderdeel FROM bedrijfskosten ORDER BY onderdeel")
    kostenplaatsen = run_query(
        "SELECT id, omschrijving, onderdeel, divisie FROM kostenplaatsen ORDER BY id"
    )
    kostensoorten = run_query(
        "SELECT DISTINCT kostensoort FROM bedrijfskosten ORDER BY kostensoort"
    )
    periodes = run_query(
        "SELECT DISTINCT periode FROM bedrijfskosten ORDER BY periode"
    )
    labels = run_query("SELECT DISTINCT label FROM bedrijfskosten WHERE label IS NOT NULL ORDER BY label")

    return {
        "divisies": [r["divisie"] for r in divisies],
        "onderdelen": [r["onderdeel"] for r in onderdelen],
        "kostenplaatsen": kostenplaatsen,
        "kostensoorten": [r["kostensoort"] for r in kostensoorten],
        "periodes": [r["periode"] for r in periodes],
        "labels": [r["label"] for r in labels],
    }


@app.get("/api/kpi")
def get_kpi(
    divisie: Optional[str] = None,
    onderdeel: Optional[str] = None,
    kostenplaats_id: Optional[int] = None,
    kostensoort: Optional[str] = None,
    label: Optional[str] = None,
    jaar: Optional[str] = "2026",
):
    """KPI tegels: Actual YTD, Budget YTD, Afwijking, Actual FY LY, Budget FY."""
    where, params = build_filter_conditions(
        divisie=divisie, onderdeel=onderdeel, kostenplaats_id=kostenplaats_id,
        kostensoort=kostensoort, label=label, jaar=jaar
    )

    # Actual YTD (huidig jaar, alleen waar actual niet null is)
    ytd_sql = f"""
        SELECT
            COALESCE(SUM(actual), 0)     AS actual_ytd,
            COALESCE(SUM(planversie), 0) AS budget_ytd
        FROM bedrijfskosten b
        {where}
        {"AND" if where else "WHERE"} actual IS NOT NULL
    """
    ytd = run_query(ytd_sql, params)

    # Budget FY (volledig jaar huidig jaar)
    fy_sql = f"""
        SELECT COALESCE(SUM(planversie), 0) AS budget_fy
        FROM bedrijfskosten b
        {where}
    """
    fy = run_query(fy_sql, params)

    # Actual FY LY (volledig vorig jaar)
    ly_year = str(int(jaar) - 1)
    ly_params = {**{k: v for k, v in params.items() if k != "jaar"}, "jaar": f"{ly_year}%"}
    ly_where, _ = build_filter_conditions(
        divisie=divisie, onderdeel=onderdeel, kostenplaats_id=kostenplaats_id,
        kostensoort=kostensoort, label=label
    )
    ly_sql = f"""
        SELECT COALESCE(SUM(actual), 0) AS actual_fy_ly
        FROM bedrijfskosten b
        {ly_where}
        {"AND" if ly_where else "WHERE"} b.periode LIKE :jaar
    """
    ly = run_query(ly_sql, ly_params)

    actual_ytd = float(ytd[0]["actual_ytd"]) if ytd else 0
    budget_ytd = float(ytd[0]["budget_ytd"]) if ytd else 0
    budget_fy = float(fy[0]["budget_fy"]) if fy else 0
    actual_fy_ly = float(ly[0]["actual_fy_ly"]) if ly else 0

    afwijking_bedrag = actual_ytd - budget_ytd
    afwijking_pct = (afwijking_bedrag / budget_ytd * 100) if budget_ytd else 0

    return {
        "actual_ytd": actual_ytd,
        "budget_ytd": budget_ytd,
        "afwijking_bedrag": afwijking_bedrag,
        "afwijking_pct": round(afwijking_pct, 1),
        "actual_fy_ly": actual_fy_ly,
        "budget_fy": budget_fy,
    }


@app.get("/api/chart")
def get_chart_data(
    divisie: Optional[str] = None,
    onderdeel: Optional[str] = None,
    kostenplaats_id: Optional[int] = None,
    kostensoort: Optional[str] = None,
    label: Optional[str] = None,
    jaar: Optional[str] = "2026",
):
    """Staaf-lijn diagram data: Actual, Budget, Actual LY per maand."""
    # Huidig jaar
    where, params = build_filter_conditions(
        divisie=divisie, onderdeel=onderdeel, kostenplaats_id=kostenplaats_id,
        kostensoort=kostensoort, label=label, jaar=jaar
    )

    current_sql = f"""
        SELECT
            periode,
            maand,
            COALESCE(SUM(actual), 0)     AS actual,
            COALESCE(SUM(planversie), 0) AS budget
        FROM bedrijfskosten b
        {where}
        GROUP BY periode, maand
        ORDER BY periode
    """
    current = run_query(current_sql, params)

    # Vorig jaar actual
    ly_year = str(int(jaar) - 1)
    ly_params = {**{k: v for k, v in params.items() if k != "jaar"}, "jaar_ly": f"{ly_year}%"}
    ly_where_base, _ = build_filter_conditions(
        divisie=divisie, onderdeel=onderdeel, kostenplaats_id=kostenplaats_id,
        kostensoort=kostensoort, label=label
    )
    ly_sql = f"""
        SELECT
            SUBSTRING(periode, 5, 2) AS maandnr,
            COALESCE(SUM(actual), 0) AS actual_ly
        FROM bedrijfskosten b
        {ly_where_base}
        {"AND" if ly_where_base else "WHERE"} b.periode LIKE :jaar_ly
        GROUP BY SUBSTRING(periode, 5, 2)
        ORDER BY maandnr
    """
    ly_data = run_query(ly_sql, ly_params)
    ly_map = {r["maandnr"]: float(r["actual_ly"]) for r in ly_data}

    # Detecteer piek: maand met hoogste actual
    result = []
    max_actual = max((float(r["actual"]) for r in current), default=0)

    for row in current:
        maandnr = row["periode"][4:6]
        actual_val = float(row["actual"])
        result.append({
            "periode": row["periode"],
            "maand": row["maand"],
            "actual": actual_val,
            "budget": float(row["budget"]),
            "actual_ly": ly_map.get(maandnr, 0),
            "is_piek": actual_val == max_actual and actual_val > 0,
        })

    return {"data": result, "jaar": jaar, "ly_jaar": ly_year}


@app.post("/api/findings")
def get_findings(req: FindingsRequest):
    """Genereer automatisch een beschrijvend verslag op basis van gefilterde data."""
    where, params = build_filter_conditions(
        divisie=req.divisie, onderdeel=req.onderdeel,
        kostenplaats_id=req.kostenplaats_id, kostensoort=req.kostensoort,
        label=req.label, jaar=req.jaar
    )

    # Haal samenvatting op
    sql = f"""
        SELECT
            b.periode,
            b.maand,
            COALESCE(SUM(b.actual), 0)     AS actual,
            COALESCE(SUM(b.planversie), 0) AS budget
        FROM bedrijfskosten b
        {where}
        GROUP BY b.periode, b.maand
        ORDER BY b.periode
    """
    data = run_query(sql, params)

    if not data:
        return {"findings": "Geen data beschikbaar voor de geselecteerde filters."}

    # Bouw data-samenvatting voor Claude
    totaal_actual = sum(float(r["actual"]) for r in data if r["actual"])
    totaal_budget = sum(float(r["budget"]) for r in data)
    max_row = max(data, key=lambda r: float(r["actual"]))
    min_row = min((r for r in data if float(r["actual"]) > 0), key=lambda r: float(r["actual"]), default=None)

    data_tekst = "\n".join(
        [f"- {r['maand']} {req.jaar}: Actual €{float(r['actual']):,.0f} | Budget €{float(r['budget']):,.0f}"
         for r in data]
    )

    filter_context = []
    if req.divisie:
        filter_context.append(f"Divisie: {req.divisie}")
    if req.onderdeel:
        filter_context.append(f"Onderdeel: {req.onderdeel}")
    if req.kostenplaats_id:
        filter_context.append(f"Kostenplaats ID: {req.kostenplaats_id}")
    if req.kostensoort:
        filter_context.append(f"Kostensoort: {req.kostensoort}")
    if req.label:
        filter_context.append(f"Label: {req.label}")

    prompt = f"""Je bent een financieel analist bij ACME Insurances. Schrijf een KORTE, puur beschrijvende toelichting
(max 4-5 zinnen) op de onderstaande kostendata. Beschrijf alleen WAT je ziet — geen oorzaakanalyse.
Noem: totalen, trends, uitschieters. Schrijf in het Nederlands, professioneel en beknopt.
Gebruik GEEN markdown opmaak zoals **, ## of andere symbolen. Schrijf gewone lopende tekst.

Filters: {', '.join(filter_context) if filter_context else 'Geen (totaaloverzicht)'}
Jaar: {req.jaar}

Data per maand:
{data_tekst}

Totaal actual: €{totaal_actual:,.0f}
Totaal budget: €{totaal_budget:,.0f}
Hoogste maand: {max_row['maand']} (€{float(max_row['actual']):,.0f})
"""

    client = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))
    message = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=512,
        messages=[{"role": "user", "content": prompt}],
    )

    return {"findings": message.content[0].text}


@app.post("/api/chat")
async def chat(req: ChatRequest):
    """AI assistent — stel een vraag in natuurlijke taal."""
    session_id = req.session_id or str(uuid.uuid4())

    if not req.question.strip():
        raise HTTPException(status_code=400, detail="Vraag mag niet leeg zijn.")

    result = await ask_agent(session_id, req.question)
    return result


@app.get("/api/chat/history/{session_id}")
def get_chat_history(session_id: str):
    return {"history": get_history(session_id)}


@app.delete("/api/chat/session/{session_id}")
def delete_session(session_id: str):
    clear_session(session_id)
    return {"message": "Sessie gewist."}
