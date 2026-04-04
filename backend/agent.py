import os
import json
import anthropic
from dotenv import load_dotenv
from database import run_query

load_dotenv()

SYSTEM_PROMPT = """Je bent een financieel assistent voor ACME Insurances. Je helpt controllers van de afdeling
"Control Generieke Diensten" bij het analyseren van bedrijfskosten.

Je hebt toegang tot een PostgreSQL database via het sql_query tool. De database bevat:
- bedrijfskosten: actual (werkelijk bedrag), planversie (budget), divisie, onderdeel, periode (jjjjmm formaat bijv. 202503 = maart 2025), maand, kostensoort, kostenplaats_id, label (Wiley/RoadRunner)
- kostenplaatsen: id, omschrijving, onderdeel, divisie
- facturen: id, nummer (bijv. INV-2025-0892), leverancier, bedrag, datum, kostenplaats_id, kostensoort, omschrijving
- events: id, omschrijving, periode, kostenplaats_id, kostensoort, impact_bedrag

Werkwijze:
1. Analyseer de vraag
2. Voer de benodigde SQL queries uit via het sql_query tool
3. Leg je redenering stap voor stap uit
4. Geef een concreet antwoord met getallen, factuurnummers, leveranciers en events

Regels:
- Antwoord ALTIJD in het Nederlands
- Gebruik concrete getallen en factuurnummers
- Formatteer bedragen als € 18.500 (punt als duizendtalseparator)
- Periode 202503 = maart 2025, 202601 = januari 2026 etc.
- Gebruik GEEN markdown opmaak zoals ** of ##"""

SQL_TOOL = {
    "name": "sql_query",
    "description": "Voer een SQL SELECT query uit op de ACME Insurances database. Gebruik alleen SELECT statements.",
    "input_schema": {
        "type": "object",
        "properties": {
            "query": {
                "type": "string",
                "description": "De SQL SELECT query om uit te voeren"
            },
            "uitleg": {
                "type": "string",
                "description": "Korte uitleg wat je zoekt met deze query"
            }
        },
        "required": ["query"]
    }
}


def execute_tool(tool_name: str, tool_input: dict) -> str:
    if tool_name == "sql_query":
        query = tool_input.get("query", "")
        if not query.strip().upper().startswith("SELECT"):
            return "Fout: alleen SELECT queries zijn toegestaan."
        try:
            results = run_query(query)
            if not results:
                return "Query uitgevoerd — geen resultaten gevonden."
            uitleg = tool_input.get("uitleg", "")
            header = f"Query: {uitleg}\n" if uitleg else ""
            return header + json.dumps(results, ensure_ascii=False, default=str, indent=2)
        except Exception as e:
            return f"SQL fout: {str(e)}"
    return "Onbekend tool."


# Sessie-opslag: session_id → lijst van berichten
_sessions: dict[str, list] = {}


def get_or_create_session(session_id: str) -> list:
    if session_id not in _sessions:
        _sessions[session_id] = []
    return _sessions[session_id]


def clear_session(session_id: str):
    if session_id in _sessions:
        del _sessions[session_id]


def get_history(session_id: str) -> list:
    return _sessions.get(session_id, [])


async def ask_agent(session_id: str, question: str) -> dict:
    client = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))
    history = get_or_create_session(session_id)

    # Voeg gebruikersvraag toe
    history.append({"role": "user", "content": question})

    messages = list(history)

    # Agentic loop: max 8 rondes
    for _ in range(8):
        response = client.messages.create(
            model="claude-sonnet-4-6",
            max_tokens=4096,
            system=SYSTEM_PROMPT,
            tools=[SQL_TOOL],
            messages=messages,
        )

        # Tool gebruik
        if response.stop_reason == "tool_use":
            # Voeg assistant bericht toe
            messages.append({"role": "assistant", "content": response.content})

            # Verwerk alle tool calls
            tool_results = []
            for block in response.content:
                if block.type == "tool_use":
                    result = execute_tool(block.name, block.input)
                    tool_results.append({
                        "type": "tool_result",
                        "tool_use_id": block.id,
                        "content": result
                    })

            messages.append({"role": "user", "content": tool_results})

        elif response.stop_reason == "end_turn":
            # Extraheer het tekstantwoord
            answer = ""
            for block in response.content:
                if hasattr(block, "text"):
                    answer += block.text

            # Sla het volledige gesprek op in sessie
            history.clear()
            history.extend(messages)
            history.append({"role": "assistant", "content": answer})
            _sessions[session_id] = history

            return {
                "answer": answer,
                "session_id": session_id,
                "history_length": len([m for m in history if m["role"] == "user"]),
            }
        else:
            break

    return {
        "answer": "Kon geen antwoord genereren. Probeer de vraag anders te formuleren.",
        "session_id": session_id,
        "history_length": 0,
    }
