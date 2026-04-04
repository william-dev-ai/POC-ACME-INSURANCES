-- ============================================================
-- ACME Insurances — Bedrijfskosten POC
-- Schema aanmaken in Supabase
-- ============================================================

-- Dimensietabel: kostenplaatsen
CREATE TABLE IF NOT EXISTS kostenplaatsen (
    id          INTEGER PRIMARY KEY,
    omschrijving VARCHAR(100) NOT NULL,
    onderdeel   VARCHAR(50)  NOT NULL,
    divisie     VARCHAR(50)  NOT NULL
);

-- Hoofdtabel: bedrijfskosten
CREATE TABLE IF NOT EXISTS bedrijfskosten (
    id              SERIAL PRIMARY KEY,
    actual          NUMERIC(12, 2),
    planversie      NUMERIC(12, 2),
    divisie         VARCHAR(50)  NOT NULL,
    onderdeel       VARCHAR(50)  NOT NULL,
    periode         CHAR(6)      NOT NULL,   -- bijv. 202603
    maand           VARCHAR(20)  NOT NULL,   -- bijv. "maart"
    kostensoort     VARCHAR(100) NOT NULL,
    kostenplaats_id INTEGER      NOT NULL REFERENCES kostenplaatsen(id),
    label           VARCHAR(20)  CHECK (label IN ('Wiley', 'RoadRunner'))
);

-- Dimensietabel: events
CREATE TABLE IF NOT EXISTS events (
    id              SERIAL PRIMARY KEY,
    omschrijving    VARCHAR(255) NOT NULL,
    periode         CHAR(6)      NOT NULL,
    kostenplaats_id INTEGER      REFERENCES kostenplaatsen(id),
    kostensoort     VARCHAR(100),
    impact_bedrag   NUMERIC(12, 2)
);

-- Dimensietabel: facturen
CREATE TABLE IF NOT EXISTS facturen (
    id              SERIAL PRIMARY KEY,
    nummer          VARCHAR(30)  NOT NULL,   -- bijv. INV-2025-0892
    leverancier     VARCHAR(100) NOT NULL,
    bedrag          NUMERIC(12, 2) NOT NULL,
    datum           DATE         NOT NULL,
    kostenplaats_id INTEGER      REFERENCES kostenplaatsen(id),
    kostensoort     VARCHAR(100),
    omschrijving    VARCHAR(255)
);

-- Indexen voor performance
CREATE INDEX IF NOT EXISTS idx_bedrijfskosten_periode       ON bedrijfskosten(periode);
CREATE INDEX IF NOT EXISTS idx_bedrijfskosten_kostenplaats  ON bedrijfskosten(kostenplaats_id);
CREATE INDEX IF NOT EXISTS idx_bedrijfskosten_divisie       ON bedrijfskosten(divisie);
CREATE INDEX IF NOT EXISTS idx_bedrijfskosten_onderdeel     ON bedrijfskosten(onderdeel);
CREATE INDEX IF NOT EXISTS idx_bedrijfskosten_label         ON bedrijfskosten(label);
CREATE INDEX IF NOT EXISTS idx_facturen_kostenplaats        ON facturen(kostenplaats_id);
CREATE INDEX IF NOT EXISTS idx_events_periode               ON events(periode);
