-- ============================================================
-- ACME Insurances — Seed Data
-- ============================================================

-- ------------------------------------------------------------
-- 1. KOSTENPLAATSEN
-- ------------------------------------------------------------
INSERT INTO kostenplaatsen (id, omschrijving, onderdeel, divisie) VALUES
(1001, 'Auto Schadebehandeling',  'Auto',           'Schade'),
(1002, 'Auto Acceptatie',         'Auto',           'Schade'),
(2001, 'Boot Schadebehandeling',  'Boot',           'Schade'),
(2002, 'Boot Acceptatie',         'Boot',           'Schade'),
(3001, 'Huis Schadebehandeling',  'Huis',           'Schade'),
(3002, 'Huis Acceptatie',         'Huis',           'Schade'),
(4001, 'Reis Schadebehandeling',  'Reis',           'Schade'),
(5001, 'Rechtsbijstand',          'Rechtsbijstand', 'Schade'),
(6001, 'IT Infrastructuur',       'IT',             'Bedrijfsvoering'),
(6002, 'IT Development',          'IT',             'Bedrijfsvoering'),
(7001, 'HR & Recruitment',        'HR',             'Bedrijfsvoering'),
(8001, 'Finance & Control',       'Finance',        'Bedrijfsvoering'),
(9001, 'Marketing Wiley',         'Marketing',      'Bedrijfsvoering'),
(9002, 'Marketing RoadRunner',    'Marketing',      'Bedrijfsvoering'),
(9003, 'Claims Verwerking',       'Claims',         'Bedrijfsvoering')
ON CONFLICT (id) DO NOTHING;


-- ------------------------------------------------------------
-- 2. BEDRIJFSKOSTEN 2025 — Volledig jaar, Actual + Budget
-- Helper: maandnamen
-- ------------------------------------------------------------

-- Kostenplaats 1001 — Auto Schadebehandeling (Schade / Auto / Wiley)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(42100, 41000, 'Schade', 'Auto', '202501', 'januari',   'Personeelskosten',     1001, 'Wiley'),
(38500, 41000, 'Schade', 'Auto', '202502', 'februari',  'Personeelskosten',     1001, 'Wiley'),
(43200, 41000, 'Schade', 'Auto', '202503', 'maart',     'Personeelskosten',     1001, 'Wiley'),
(40100, 41000, 'Schade', 'Auto', '202504', 'april',     'Personeelskosten',     1001, 'Wiley'),
(41800, 41000, 'Schade', 'Auto', '202505', 'mei',       'Personeelskosten',     1001, 'Wiley'),
(39600, 41000, 'Schade', 'Auto', '202506', 'juni',      'Personeelskosten',     1001, 'Wiley'),
(40500, 41000, 'Schade', 'Auto', '202507', 'juli',      'Personeelskosten',     1001, 'Wiley'),
(42300, 41000, 'Schade', 'Auto', '202508', 'augustus',  'Personeelskosten',     1001, 'Wiley'),
(41100, 41000, 'Schade', 'Auto', '202509', 'september', 'Personeelskosten',     1001, 'Wiley'),
(39900, 41000, 'Schade', 'Auto', '202510', 'oktober',   'Personeelskosten',     1001, 'Wiley'),
(43500, 41000, 'Schade', 'Auto', '202511', 'november',  'Personeelskosten',     1001, 'Wiley'),
(44200, 41000, 'Schade', 'Auto', '202512', 'december',  'Personeelskosten',     1001, 'Wiley'),
(8200,  8000,  'Schade', 'Auto', '202501', 'januari',   'Externe inhuur',       1001, 'Wiley'),
(7800,  8000,  'Schade', 'Auto', '202502', 'februari',  'Externe inhuur',       1001, 'Wiley'),
(8500,  8000,  'Schade', 'Auto', '202503', 'maart',     'Externe inhuur',       1001, 'Wiley'),
(7900,  8000,  'Schade', 'Auto', '202504', 'april',     'Externe inhuur',       1001, 'Wiley'),
(8100,  8000,  'Schade', 'Auto', '202505', 'mei',       'Externe inhuur',       1001, 'Wiley'),
(7700,  8000,  'Schade', 'Auto', '202506', 'juni',      'Externe inhuur',       1001, 'Wiley'),
(8300,  8000,  'Schade', 'Auto', '202507', 'juli',      'Externe inhuur',       1001, 'Wiley'),
(8600,  8000,  'Schade', 'Auto', '202508', 'augustus',  'Externe inhuur',       1001, 'Wiley'),
(7950,  8000,  'Schade', 'Auto', '202509', 'september', 'Externe inhuur',       1001, 'Wiley'),
(8050,  8000,  'Schade', 'Auto', '202510', 'oktober',   'Externe inhuur',       1001, 'Wiley'),
(8400,  8000,  'Schade', 'Auto', '202511', 'november',  'Externe inhuur',       1001, 'Wiley'),
(8700,  8000,  'Schade', 'Auto', '202512', 'december',  'Externe inhuur',       1001, 'Wiley');

-- Kostenplaats 1002 — Auto Acceptatie (Schade / Auto / Wiley)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(18500, 18000, 'Schade', 'Auto', '202501', 'januari',   'Personeelskosten',     1002, 'Wiley'),
(17800, 18000, 'Schade', 'Auto', '202502', 'februari',  'Personeelskosten',     1002, 'Wiley'),
(19100, 18000, 'Schade', 'Auto', '202503', 'maart',     'Personeelskosten',     1002, 'Wiley'),
(18200, 18000, 'Schade', 'Auto', '202504', 'april',     'Personeelskosten',     1002, 'Wiley'),
(18700, 18000, 'Schade', 'Auto', '202505', 'mei',       'Personeelskosten',     1002, 'Wiley'),
(17600, 18000, 'Schade', 'Auto', '202506', 'juni',      'Personeelskosten',     1002, 'Wiley'),
(18400, 18000, 'Schade', 'Auto', '202507', 'juli',      'Personeelskosten',     1002, 'Wiley'),
(19000, 18000, 'Schade', 'Auto', '202508', 'augustus',  'Personeelskosten',     1002, 'Wiley'),
(18100, 18000, 'Schade', 'Auto', '202509', 'september', 'Personeelskosten',     1002, 'Wiley'),
(17900, 18000, 'Schade', 'Auto', '202510', 'oktober',   'Personeelskosten',     1002, 'Wiley'),
(18600, 18000, 'Schade', 'Auto', '202511', 'november',  'Personeelskosten',     1002, 'Wiley'),
(19200, 18000, 'Schade', 'Auto', '202512', 'december',  'Personeelskosten',     1002, 'Wiley');

-- Kostenplaats 2001 — Boot Schadebehandeling (Schade / Boot / RoadRunner)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(22100, 22000, 'Schade', 'Boot', '202501', 'januari',   'Personeelskosten',     2001, 'RoadRunner'),
(21500, 22000, 'Schade', 'Boot', '202502', 'februari',  'Personeelskosten',     2001, 'RoadRunner'),
(22800, 22000, 'Schade', 'Boot', '202503', 'maart',     'Personeelskosten',     2001, 'RoadRunner'),
(21900, 22000, 'Schade', 'Boot', '202504', 'april',     'Personeelskosten',     2001, 'RoadRunner'),
(22300, 22000, 'Schade', 'Boot', '202505', 'mei',       'Personeelskosten',     2001, 'RoadRunner'),
(21700, 22000, 'Schade', 'Boot', '202506', 'juni',      'Personeelskosten',     2001, 'RoadRunner'),
(22500, 22000, 'Schade', 'Boot', '202507', 'juli',      'Personeelskosten',     2001, 'RoadRunner'),
(22900, 22000, 'Schade', 'Boot', '202508', 'augustus',  'Personeelskosten',     2001, 'RoadRunner'),
(21800, 22000, 'Schade', 'Boot', '202509', 'september', 'Personeelskosten',     2001, 'RoadRunner'),
(22200, 22000, 'Schade', 'Boot', '202510', 'oktober',   'Personeelskosten',     2001, 'RoadRunner'),
(22600, 22000, 'Schade', 'Boot', '202511', 'november',  'Personeelskosten',     2001, 'RoadRunner'),
(23100, 22000, 'Schade', 'Boot', '202512', 'december',  'Personeelskosten',     2001, 'RoadRunner');

-- Kostenplaats 2002 — Boot Acceptatie (Schade / Boot / RoadRunner)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(11200, 11000, 'Schade', 'Boot', '202501', 'januari',   'Personeelskosten',     2002, 'RoadRunner'),
(10800, 11000, 'Schade', 'Boot', '202502', 'februari',  'Personeelskosten',     2002, 'RoadRunner'),
(11500, 11000, 'Schade', 'Boot', '202503', 'maart',     'Personeelskosten',     2002, 'RoadRunner'),
(10900, 11000, 'Schade', 'Boot', '202504', 'april',     'Personeelskosten',     2002, 'RoadRunner'),
(11300, 11000, 'Schade', 'Boot', '202505', 'mei',       'Personeelskosten',     2002, 'RoadRunner'),
(10700, 11000, 'Schade', 'Boot', '202506', 'juni',      'Personeelskosten',     2002, 'RoadRunner'),
(11100, 11000, 'Schade', 'Boot', '202507', 'juli',      'Personeelskosten',     2002, 'RoadRunner'),
(11400, 11000, 'Schade', 'Boot', '202508', 'augustus',  'Personeelskosten',     2002, 'RoadRunner'),
(11000, 11000, 'Schade', 'Boot', '202509', 'september', 'Personeelskosten',     2002, 'RoadRunner'),
(10950, 11000, 'Schade', 'Boot', '202510', 'oktober',   'Personeelskosten',     2002, 'RoadRunner'),
(11200, 11000, 'Schade', 'Boot', '202511', 'november',  'Personeelskosten',     2002, 'RoadRunner'),
(11600, 11000, 'Schade', 'Boot', '202512', 'december',  'Personeelskosten',     2002, 'RoadRunner');

-- Kostenplaats 3001 — Huis Schadebehandeling (Schade / Huis / Wiley)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(31200, 30000, 'Schade', 'Huis', '202501', 'januari',   'Personeelskosten',     3001, 'Wiley'),
(29800, 30000, 'Schade', 'Huis', '202502', 'februari',  'Personeelskosten',     3001, 'Wiley'),
(32100, 30000, 'Schade', 'Huis', '202503', 'maart',     'Personeelskosten',     3001, 'Wiley'),
(30500, 30000, 'Schade', 'Huis', '202504', 'april',     'Personeelskosten',     3001, 'Wiley'),
(30900, 30000, 'Schade', 'Huis', '202505', 'mei',       'Personeelskosten',     3001, 'Wiley'),
(29600, 30000, 'Schade', 'Huis', '202506', 'juni',      'Personeelskosten',     3001, 'Wiley'),
(30700, 30000, 'Schade', 'Huis', '202507', 'juli',      'Personeelskosten',     3001, 'Wiley'),
(31500, 30000, 'Schade', 'Huis', '202508', 'augustus',  'Personeelskosten',     3001, 'Wiley'),
(30200, 30000, 'Schade', 'Huis', '202509', 'september', 'Personeelskosten',     3001, 'Wiley'),
(29900, 30000, 'Schade', 'Huis', '202510', 'oktober',   'Personeelskosten',     3001, 'Wiley'),
(31800, 30000, 'Schade', 'Huis', '202511', 'november',  'Personeelskosten',     3001, 'Wiley'),
(32500, 30000, 'Schade', 'Huis', '202512', 'december',  'Personeelskosten',     3001, 'Wiley');

-- Kostenplaats 3002 — Huis Acceptatie (Schade / Huis / Wiley)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(14200, 14000, 'Schade', 'Huis', '202501', 'januari',   'Acceptatiekosten',     3002, 'Wiley'),
(13800, 14000, 'Schade', 'Huis', '202502', 'februari',  'Acceptatiekosten',     3002, 'Wiley'),
(14500, 14000, 'Schade', 'Huis', '202503', 'maart',     'Acceptatiekosten',     3002, 'Wiley'),
(13900, 14000, 'Schade', 'Huis', '202504', 'april',     'Acceptatiekosten',     3002, 'Wiley'),
(14300, 14000, 'Schade', 'Huis', '202505', 'mei',       'Acceptatiekosten',     3002, 'Wiley'),
(13700, 14000, 'Schade', 'Huis', '202506', 'juni',      'Acceptatiekosten',     3002, 'Wiley'),
(14100, 14000, 'Schade', 'Huis', '202507', 'juli',      'Acceptatiekosten',     3002, 'Wiley'),
(14400, 14000, 'Schade', 'Huis', '202508', 'augustus',  'Acceptatiekosten',     3002, 'Wiley'),
(14000, 14000, 'Schade', 'Huis', '202509', 'september', 'Acceptatiekosten',     3002, 'Wiley'),
(13950, 14000, 'Schade', 'Huis', '202510', 'oktober',   'Acceptatiekosten',     3002, 'Wiley'),
(14200, 14000, 'Schade', 'Huis', '202511', 'november',  'Acceptatiekosten',     3002, 'Wiley'),
(14700, 14000, 'Schade', 'Huis', '202512', 'december',  'Acceptatiekosten',     3002, 'Wiley');

-- Kostenplaats 4001 — Reis Schadebehandeling (Schade / Reis / RoadRunner)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(16100, 16000, 'Schade', 'Reis', '202501', 'januari',   'Personeelskosten',     4001, 'RoadRunner'),
(15700, 16000, 'Schade', 'Reis', '202502', 'februari',  'Personeelskosten',     4001, 'RoadRunner'),
(16400, 16000, 'Schade', 'Reis', '202503', 'maart',     'Personeelskosten',     4001, 'RoadRunner'),
(15900, 16000, 'Schade', 'Reis', '202504', 'april',     'Personeelskosten',     4001, 'RoadRunner'),
(16200, 16000, 'Schade', 'Reis', '202505', 'mei',       'Personeelskosten',     4001, 'RoadRunner'),
(15800, 16000, 'Schade', 'Reis', '202506', 'juni',      'Personeelskosten',     4001, 'RoadRunner'),
(16300, 16000, 'Schade', 'Reis', '202507', 'juli',      'Personeelskosten',     4001, 'RoadRunner'),
(16500, 16000, 'Schade', 'Reis', '202508', 'augustus',  'Personeelskosten',     4001, 'RoadRunner'),
(16050, 16000, 'Schade', 'Reis', '202509', 'september', 'Personeelskosten',     4001, 'RoadRunner'),
(15950, 16000, 'Schade', 'Reis', '202510', 'oktober',   'Personeelskosten',     4001, 'RoadRunner'),
(16200, 16000, 'Schade', 'Reis', '202511', 'november',  'Personeelskosten',     4001, 'RoadRunner'),
(16700, 16000, 'Schade', 'Reis', '202512', 'december',  'Personeelskosten',     4001, 'RoadRunner');

-- Kostenplaats 5001 — Rechtsbijstand (Schade / Rechtsbijstand / Wiley)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(19500, 19000, 'Schade', 'Rechtsbijstand', '202501', 'januari',   'Juridische kosten',    5001, 'Wiley'),
(18800, 19000, 'Schade', 'Rechtsbijstand', '202502', 'februari',  'Juridische kosten',    5001, 'Wiley'),
(20100, 19000, 'Schade', 'Rechtsbijstand', '202503', 'maart',     'Juridische kosten',    5001, 'Wiley'),
(19200, 19000, 'Schade', 'Rechtsbijstand', '202504', 'april',     'Juridische kosten',    5001, 'Wiley'),
(19700, 19000, 'Schade', 'Rechtsbijstand', '202505', 'mei',       'Juridische kosten',    5001, 'Wiley'),
(18600, 19000, 'Schade', 'Rechtsbijstand', '202506', 'juni',      'Juridische kosten',    5001, 'Wiley'),
(19400, 19000, 'Schade', 'Rechtsbijstand', '202507', 'juli',      'Juridische kosten',    5001, 'Wiley'),
(19900, 19000, 'Schade', 'Rechtsbijstand', '202508', 'augustus',  'Juridische kosten',    5001, 'Wiley'),
(19100, 19000, 'Schade', 'Rechtsbijstand', '202509', 'september', 'Juridische kosten',    5001, 'Wiley'),
(18900, 19000, 'Schade', 'Rechtsbijstand', '202510', 'oktober',   'Juridische kosten',    5001, 'Wiley'),
(19600, 19000, 'Schade', 'Rechtsbijstand', '202511', 'november',  'Juridische kosten',    5001, 'Wiley'),
(20300, 19000, 'Schade', 'Rechtsbijstand', '202512', 'december',  'Juridische kosten',    5001, 'Wiley');

-- *** Kostenplaats 6001 — IT Infrastructuur (Bedrijfsvoering / IT) ***
-- PIEK in maart 2025 op kostensoort "Software licenties"
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
-- Software licenties: normaal ~3200, piek maart = 21700 (3200 regulier + 18500 Microsoft)
(3100, 3200, 'Bedrijfsvoering', 'IT', '202501', 'januari',   'Software licenties',   6001, 'Wiley'),
(3200, 3200, 'Bedrijfsvoering', 'IT', '202502', 'februari',  'Software licenties',   6001, 'Wiley'),
(21700,3200, 'Bedrijfsvoering', 'IT', '202503', 'maart',     'Software licenties',   6001, 'Wiley'),  -- PIEK
(3300, 3200, 'Bedrijfsvoering', 'IT', '202504', 'april',     'Software licenties',   6001, 'Wiley'),
(3150, 3200, 'Bedrijfsvoering', 'IT', '202505', 'mei',       'Software licenties',   6001, 'Wiley'),
(3250, 3200, 'Bedrijfsvoering', 'IT', '202506', 'juni',      'Software licenties',   6001, 'Wiley'),
(3100, 3200, 'Bedrijfsvoering', 'IT', '202507', 'juli',      'Software licenties',   6001, 'Wiley'),
(3200, 3200, 'Bedrijfsvoering', 'IT', '202508', 'augustus',  'Software licenties',   6001, 'Wiley'),
(3300, 3200, 'Bedrijfsvoering', 'IT', '202509', 'september', 'Software licenties',   6001, 'Wiley'),
(3150, 3200, 'Bedrijfsvoering', 'IT', '202510', 'oktober',   'Software licenties',   6001, 'Wiley'),
(3200, 3200, 'Bedrijfsvoering', 'IT', '202511', 'november',  'Software licenties',   6001, 'Wiley'),
(3250, 3200, 'Bedrijfsvoering', 'IT', '202512', 'december',  'Software licenties',   6001, 'Wiley'),
-- Hosting & infrastructuur
(12500,12000,'Bedrijfsvoering', 'IT', '202501', 'januari',   'Hosting & infrastructuur', 6001, 'Wiley'),
(12200,12000,'Bedrijfsvoering', 'IT', '202502', 'februari',  'Hosting & infrastructuur', 6001, 'Wiley'),
(12800,12000,'Bedrijfsvoering', 'IT', '202503', 'maart',     'Hosting & infrastructuur', 6001, 'Wiley'),
(12100,12000,'Bedrijfsvoering', 'IT', '202504', 'april',     'Hosting & infrastructuur', 6001, 'Wiley'),
(12400,12000,'Bedrijfsvoering', 'IT', '202505', 'mei',       'Hosting & infrastructuur', 6001, 'Wiley'),
(11900,12000,'Bedrijfsvoering', 'IT', '202506', 'juni',      'Hosting & infrastructuur', 6001, 'Wiley'),
(12300,12000,'Bedrijfsvoering', 'IT', '202507', 'juli',      'Hosting & infrastructuur', 6001, 'Wiley'),
(12600,12000,'Bedrijfsvoering', 'IT', '202508', 'augustus',  'Hosting & infrastructuur', 6001, 'Wiley'),
(12000,12000,'Bedrijfsvoering', 'IT', '202509', 'september', 'Hosting & infrastructuur', 6001, 'Wiley'),
(11950,12000,'Bedrijfsvoering', 'IT', '202510', 'oktober',   'Hosting & infrastructuur', 6001, 'Wiley'),
(12200,12000,'Bedrijfsvoering', 'IT', '202511', 'november',  'Hosting & infrastructuur', 6001, 'Wiley'),
(12500,12000,'Bedrijfsvoering', 'IT', '202512', 'december',  'Hosting & infrastructuur', 6001, 'Wiley');

-- Kostenplaats 6002 — IT Development (Bedrijfsvoering / IT)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(28100, 28000, 'Bedrijfsvoering', 'IT', '202501', 'januari',   'Personeelskosten',     6002, 'RoadRunner'),
(27500, 28000, 'Bedrijfsvoering', 'IT', '202502', 'februari',  'Personeelskosten',     6002, 'RoadRunner'),
(28800, 28000, 'Bedrijfsvoering', 'IT', '202503', 'maart',     'Personeelskosten',     6002, 'RoadRunner'),
(27900, 28000, 'Bedrijfsvoering', 'IT', '202504', 'april',     'Personeelskosten',     6002, 'RoadRunner'),
(28300, 28000, 'Bedrijfsvoering', 'IT', '202505', 'mei',       'Personeelskosten',     6002, 'RoadRunner'),
(27700, 28000, 'Bedrijfsvoering', 'IT', '202506', 'juni',      'Personeelskosten',     6002, 'RoadRunner'),
(28500, 28000, 'Bedrijfsvoering', 'IT', '202507', 'juli',      'Personeelskosten',     6002, 'RoadRunner'),
(28900, 28000, 'Bedrijfsvoering', 'IT', '202508', 'augustus',  'Personeelskosten',     6002, 'RoadRunner'),
(28200, 28000, 'Bedrijfsvoering', 'IT', '202509', 'september', 'Personeelskosten',     6002, 'RoadRunner'),
(27800, 28000, 'Bedrijfsvoering', 'IT', '202510', 'oktober',   'Personeelskosten',     6002, 'RoadRunner'),
(28600, 28000, 'Bedrijfsvoering', 'IT', '202511', 'november',  'Personeelskosten',     6002, 'RoadRunner'),
(29100, 28000, 'Bedrijfsvoering', 'IT', '202512', 'december',  'Personeelskosten',     6002, 'RoadRunner');

-- Kostenplaats 7001 — HR & Recruitment (Bedrijfsvoering / HR)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(24200, 24000, 'Bedrijfsvoering', 'HR', '202501', 'januari',   'Personeelskosten',     7001, 'Wiley'),
(23800, 24000, 'Bedrijfsvoering', 'HR', '202502', 'februari',  'Personeelskosten',     7001, 'Wiley'),
(24500, 24000, 'Bedrijfsvoering', 'HR', '202503', 'maart',     'Personeelskosten',     7001, 'Wiley'),
(23900, 24000, 'Bedrijfsvoering', 'HR', '202504', 'april',     'Personeelskosten',     7001, 'Wiley'),
(24300, 24000, 'Bedrijfsvoering', 'HR', '202505', 'mei',       'Personeelskosten',     7001, 'Wiley'),
(23700, 24000, 'Bedrijfsvoering', 'HR', '202506', 'juni',      'Personeelskosten',     7001, 'Wiley'),
(24100, 24000, 'Bedrijfsvoering', 'HR', '202507', 'juli',      'Personeelskosten',     7001, 'Wiley'),
(24400, 24000, 'Bedrijfsvoering', 'HR', '202508', 'augustus',  'Personeelskosten',     7001, 'Wiley'),
(24000, 24000, 'Bedrijfsvoering', 'HR', '202509', 'september', 'Personeelskosten',     7001, 'Wiley'),
(23950, 24000, 'Bedrijfsvoering', 'HR', '202510', 'oktober',   'Personeelskosten',     7001, 'Wiley'),
(24200, 24000, 'Bedrijfsvoering', 'HR', '202511', 'november',  'Personeelskosten',     7001, 'Wiley'),
(24700, 24000, 'Bedrijfsvoering', 'HR', '202512', 'december',  'Personeelskosten',     7001, 'Wiley'),
(5200,  5000,  'Bedrijfsvoering', 'HR', '202501', 'januari',   'Wervingskosten',       7001, 'Wiley'),
(5800,  5000,  'Bedrijfsvoering', 'HR', '202502', 'februari',  'Wervingskosten',       7001, 'Wiley'),
(4900,  5000,  'Bedrijfsvoering', 'HR', '202503', 'maart',     'Wervingskosten',       7001, 'Wiley'),
(5100,  5000,  'Bedrijfsvoering', 'HR', '202504', 'april',     'Wervingskosten',       7001, 'Wiley'),
(5300,  5000,  'Bedrijfsvoering', 'HR', '202505', 'mei',       'Wervingskosten',       7001, 'Wiley'),
(4800,  5000,  'Bedrijfsvoering', 'HR', '202506', 'juni',      'Wervingskosten',       7001, 'Wiley'),
(5000,  5000,  'Bedrijfsvoering', 'HR', '202507', 'juli',      'Wervingskosten',       7001, 'Wiley'),
(5400,  5000,  'Bedrijfsvoering', 'HR', '202508', 'augustus',  'Wervingskosten',       7001, 'Wiley'),
(4950,  5000,  'Bedrijfsvoering', 'HR', '202509', 'september', 'Wervingskosten',       7001, 'Wiley'),
(5050,  5000,  'Bedrijfsvoering', 'HR', '202510', 'oktober',   'Wervingskosten',       7001, 'Wiley'),
(5200,  5000,  'Bedrijfsvoering', 'HR', '202511', 'november',  'Wervingskosten',       7001, 'Wiley'),
(5700,  5000,  'Bedrijfsvoering', 'HR', '202512', 'december',  'Wervingskosten',       7001, 'Wiley');

-- Kostenplaats 8001 — Finance & Control (Bedrijfsvoering / Finance)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(17200, 17000, 'Bedrijfsvoering', 'Finance', '202501', 'januari',   'Personeelskosten',     8001, 'Wiley'),
(16800, 17000, 'Bedrijfsvoering', 'Finance', '202502', 'februari',  'Personeelskosten',     8001, 'Wiley'),
(17500, 17000, 'Bedrijfsvoering', 'Finance', '202503', 'maart',     'Personeelskosten',     8001, 'Wiley'),
(16900, 17000, 'Bedrijfsvoering', 'Finance', '202504', 'april',     'Personeelskosten',     8001, 'Wiley'),
(17300, 17000, 'Bedrijfsvoering', 'Finance', '202505', 'mei',       'Personeelskosten',     8001, 'Wiley'),
(16700, 17000, 'Bedrijfsvoering', 'Finance', '202506', 'juni',      'Personeelskosten',     8001, 'Wiley'),
(17100, 17000, 'Bedrijfsvoering', 'Finance', '202507', 'juli',      'Personeelskosten',     8001, 'Wiley'),
(17400, 17000, 'Bedrijfsvoering', 'Finance', '202508', 'augustus',  'Personeelskosten',     8001, 'Wiley'),
(17000, 17000, 'Bedrijfsvoering', 'Finance', '202509', 'september', 'Personeelskosten',     8001, 'Wiley'),
(16950, 17000, 'Bedrijfsvoering', 'Finance', '202510', 'oktober',   'Personeelskosten',     8001, 'Wiley'),
(17200, 17000, 'Bedrijfsvoering', 'Finance', '202511', 'november',  'Personeelskosten',     8001, 'Wiley'),
(17700, 17000, 'Bedrijfsvoering', 'Finance', '202512', 'december',  'Personeelskosten',     8001, 'Wiley');

-- *** Kostenplaats 9001 — Marketing Wiley (Bedrijfsvoering / Marketing / Wiley) ***
-- Wiley heeft iets hogere kosten dan RoadRunner in Q1 2025
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(22500, 20000, 'Bedrijfsvoering', 'Marketing', '202501', 'januari',   'Campagnekosten',       9001, 'Wiley'),  -- Q1 hoger
(23100, 20000, 'Bedrijfsvoering', 'Marketing', '202502', 'februari',  'Campagnekosten',       9001, 'Wiley'),  -- Q1 hoger
(21800, 20000, 'Bedrijfsvoering', 'Marketing', '202503', 'maart',     'Campagnekosten',       9001, 'Wiley'),  -- Q1 hoger
(20200, 20000, 'Bedrijfsvoering', 'Marketing', '202504', 'april',     'Campagnekosten',       9001, 'Wiley'),
(19800, 20000, 'Bedrijfsvoering', 'Marketing', '202505', 'mei',       'Campagnekosten',       9001, 'Wiley'),
(20500, 20000, 'Bedrijfsvoering', 'Marketing', '202506', 'juni',      'Campagnekosten',       9001, 'Wiley'),
(19900, 20000, 'Bedrijfsvoering', 'Marketing', '202507', 'juli',      'Campagnekosten',       9001, 'Wiley'),
(20300, 20000, 'Bedrijfsvoering', 'Marketing', '202508', 'augustus',  'Campagnekosten',       9001, 'Wiley'),
(19700, 20000, 'Bedrijfsvoering', 'Marketing', '202509', 'september', 'Campagnekosten',       9001, 'Wiley'),
(20100, 20000, 'Bedrijfsvoering', 'Marketing', '202510', 'oktober',   'Campagnekosten',       9001, 'Wiley'),
(20400, 20000, 'Bedrijfsvoering', 'Marketing', '202511', 'november',  'Campagnekosten',       9001, 'Wiley'),
(20800, 20000, 'Bedrijfsvoering', 'Marketing', '202512', 'december',  'Campagnekosten',       9001, 'Wiley');

-- Kostenplaats 9002 — Marketing RoadRunner (Bedrijfsvoering / Marketing / RoadRunner)
-- RoadRunner iets lager in Q1 2025
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(17800, 18000, 'Bedrijfsvoering', 'Marketing', '202501', 'januari',   'Campagnekosten',       9002, 'RoadRunner'),
(18200, 18000, 'Bedrijfsvoering', 'Marketing', '202502', 'februari',  'Campagnekosten',       9002, 'RoadRunner'),
(17500, 18000, 'Bedrijfsvoering', 'Marketing', '202503', 'maart',     'Campagnekosten',       9002, 'RoadRunner'),
(18100, 18000, 'Bedrijfsvoering', 'Marketing', '202504', 'april',     'Campagnekosten',       9002, 'RoadRunner'),
(17900, 18000, 'Bedrijfsvoering', 'Marketing', '202505', 'mei',       'Campagnekosten',       9002, 'RoadRunner'),
(18300, 18000, 'Bedrijfsvoering', 'Marketing', '202506', 'juni',      'Campagnekosten',       9002, 'RoadRunner'),
(18000, 18000, 'Bedrijfsvoering', 'Marketing', '202507', 'juli',      'Campagnekosten',       9002, 'RoadRunner'),
(18200, 18000, 'Bedrijfsvoering', 'Marketing', '202508', 'augustus',  'Campagnekosten',       9002, 'RoadRunner'),
(17700, 18000, 'Bedrijfsvoering', 'Marketing', '202509', 'september', 'Campagnekosten',       9002, 'RoadRunner'),
(18100, 18000, 'Bedrijfsvoering', 'Marketing', '202510', 'oktober',   'Campagnekosten',       9002, 'RoadRunner'),
(18400, 18000, 'Bedrijfsvoering', 'Marketing', '202511', 'november',  'Campagnekosten',       9002, 'RoadRunner'),
(18700, 18000, 'Bedrijfsvoering', 'Marketing', '202512', 'december',  'Campagnekosten',       9002, 'RoadRunner');

-- Kostenplaats 9003 — Claims Verwerking (Bedrijfsvoering / Claims)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(33200, 33000, 'Bedrijfsvoering', 'Claims', '202501', 'januari',   'Verwerkingskosten',    9003, 'RoadRunner'),
(32800, 33000, 'Bedrijfsvoering', 'Claims', '202502', 'februari',  'Verwerkingskosten',    9003, 'RoadRunner'),
(33500, 33000, 'Bedrijfsvoering', 'Claims', '202503', 'maart',     'Verwerkingskosten',    9003, 'RoadRunner'),
(32900, 33000, 'Bedrijfsvoering', 'Claims', '202504', 'april',     'Verwerkingskosten',    9003, 'RoadRunner'),
(33300, 33000, 'Bedrijfsvoering', 'Claims', '202505', 'mei',       'Verwerkingskosten',    9003, 'RoadRunner'),
(32700, 33000, 'Bedrijfsvoering', 'Claims', '202506', 'juni',      'Verwerkingskosten',    9003, 'RoadRunner'),
(33100, 33000, 'Bedrijfsvoering', 'Claims', '202507', 'juli',      'Verwerkingskosten',    9003, 'RoadRunner'),
(33400, 33000, 'Bedrijfsvoering', 'Claims', '202508', 'augustus',  'Verwerkingskosten',    9003, 'RoadRunner'),
(33000, 33000, 'Bedrijfsvoering', 'Claims', '202509', 'september', 'Verwerkingskosten',    9003, 'RoadRunner'),
(32950, 33000, 'Bedrijfsvoering', 'Claims', '202510', 'oktober',   'Verwerkingskosten',    9003, 'RoadRunner'),
(33200, 33000, 'Bedrijfsvoering', 'Claims', '202511', 'november',  'Verwerkingskosten',    9003, 'RoadRunner'),
(33700, 33000, 'Bedrijfsvoering', 'Claims', '202512', 'december',  'Verwerkingskosten',    9003, 'RoadRunner');


-- ------------------------------------------------------------
-- 3. BEDRIJFSKOSTEN 2026 — Budget alle 12 maanden, Actual t/m april
-- ------------------------------------------------------------

-- Kostenplaats 6001 — IT Infrastructuur 2026
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(3200,  3500, 'Bedrijfsvoering', 'IT', '202601', 'januari',   'Software licenties',       6001, 'Wiley'),
(3400,  3500, 'Bedrijfsvoering', 'IT', '202602', 'februari',  'Software licenties',       6001, 'Wiley'),
(3300,  3500, 'Bedrijfsvoering', 'IT', '202603', 'maart',     'Software licenties',       6001, 'Wiley'),
(3500,  3500, 'Bedrijfsvoering', 'IT', '202604', 'april',     'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202605', 'mei',       'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202606', 'juni',      'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202607', 'juli',      'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202608', 'augustus',  'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202609', 'september', 'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202610', 'oktober',   'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202611', 'november',  'Software licenties',       6001, 'Wiley'),
(NULL,  3500, 'Bedrijfsvoering', 'IT', '202612', 'december',  'Software licenties',       6001, 'Wiley'),
(12500,13000, 'Bedrijfsvoering', 'IT', '202601', 'januari',   'Hosting & infrastructuur', 6001, 'Wiley'),
(12800,13000, 'Bedrijfsvoering', 'IT', '202602', 'februari',  'Hosting & infrastructuur', 6001, 'Wiley'),
(12600,13000, 'Bedrijfsvoering', 'IT', '202603', 'maart',     'Hosting & infrastructuur', 6001, 'Wiley'),
(13100,13000, 'Bedrijfsvoering', 'IT', '202604', 'april',     'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202605', 'mei',       'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202606', 'juni',      'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202607', 'juli',      'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202608', 'augustus',  'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202609', 'september', 'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202610', 'oktober',   'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202611', 'november',  'Hosting & infrastructuur', 6001, 'Wiley'),
(NULL, 13000, 'Bedrijfsvoering', 'IT', '202612', 'december',  'Hosting & infrastructuur', 6001, 'Wiley');

-- *** Kostenplaats 9001 — Marketing Wiley 2026 ***
-- PIEK februari 2026: Campagnekosten (Lancering nieuwe campagne merk Wiley Q1 2026)
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(21000, 21000, 'Bedrijfsvoering', 'Marketing', '202601', 'januari',   'Campagnekosten',   9001, 'Wiley'),
(38500, 21000, 'Bedrijfsvoering', 'Marketing', '202602', 'februari',  'Campagnekosten',   9001, 'Wiley'),  -- PIEK campagne
(22000, 21000, 'Bedrijfsvoering', 'Marketing', '202603', 'maart',     'Campagnekosten',   9001, 'Wiley'),
(20800, 21000, 'Bedrijfsvoering', 'Marketing', '202604', 'april',     'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202605', 'mei',       'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202606', 'juni',      'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202607', 'juli',      'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202608', 'augustus',  'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202609', 'september', 'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202610', 'oktober',   'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202611', 'november',  'Campagnekosten',   9001, 'Wiley'),
(NULL,  21000, 'Bedrijfsvoering', 'Marketing', '202612', 'december',  'Campagnekosten',   9001, 'Wiley');

-- Kostenplaats 9002 — Marketing RoadRunner 2026
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(18500, 19000, 'Bedrijfsvoering', 'Marketing', '202601', 'januari',   'Campagnekosten',   9002, 'RoadRunner'),
(18800, 19000, 'Bedrijfsvoering', 'Marketing', '202602', 'februari',  'Campagnekosten',   9002, 'RoadRunner'),
(19100, 19000, 'Bedrijfsvoering', 'Marketing', '202603', 'maart',     'Campagnekosten',   9002, 'RoadRunner'),
(18700, 19000, 'Bedrijfsvoering', 'Marketing', '202604', 'april',     'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202605', 'mei',       'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202606', 'juni',      'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202607', 'juli',      'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202608', 'augustus',  'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202609', 'september', 'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202610', 'oktober',   'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202611', 'november',  'Campagnekosten',   9002, 'RoadRunner'),
(NULL,  19000, 'Bedrijfsvoering', 'Marketing', '202612', 'december',  'Campagnekosten',   9002, 'RoadRunner');

-- Overige kostenplaatsen 2026 — Budget + Actual t/m april
-- 1001 Auto Schadebehandeling
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(43000, 43000, 'Schade', 'Auto', '202601', 'januari',   'Personeelskosten', 1001, 'Wiley'),
(42500, 43000, 'Schade', 'Auto', '202602', 'februari',  'Personeelskosten', 1001, 'Wiley'),
(44000, 43000, 'Schade', 'Auto', '202603', 'maart',     'Personeelskosten', 1001, 'Wiley'),
(43200, 43000, 'Schade', 'Auto', '202604', 'april',     'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202605', 'mei',       'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202606', 'juni',      'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202607', 'juli',      'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202608', 'augustus',  'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202609', 'september', 'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202610', 'oktober',   'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202611', 'november',  'Personeelskosten', 1001, 'Wiley'),
(NULL,  43000, 'Schade', 'Auto', '202612', 'december',  'Personeelskosten', 1001, 'Wiley');

-- 7001 HR & Recruitment 2026
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(24800, 25000, 'Bedrijfsvoering', 'HR', '202601', 'januari',   'Personeelskosten', 7001, 'Wiley'),
(24500, 25000, 'Bedrijfsvoering', 'HR', '202602', 'februari',  'Personeelskosten', 7001, 'Wiley'),
(25200, 25000, 'Bedrijfsvoering', 'HR', '202603', 'maart',     'Personeelskosten', 7001, 'Wiley'),
(24900, 25000, 'Bedrijfsvoering', 'HR', '202604', 'april',     'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202605', 'mei',       'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202606', 'juni',      'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202607', 'juli',      'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202608', 'augustus',  'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202609', 'september', 'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202610', 'oktober',   'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202611', 'november',  'Personeelskosten', 7001, 'Wiley'),
(NULL,  25000, 'Bedrijfsvoering', 'HR', '202612', 'december',  'Personeelskosten', 7001, 'Wiley');

-- 8001 Finance & Control 2026
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(17500, 17500, 'Bedrijfsvoering', 'Finance', '202601', 'januari',   'Personeelskosten', 8001, 'Wiley'),
(17200, 17500, 'Bedrijfsvoering', 'Finance', '202602', 'februari',  'Personeelskosten', 8001, 'Wiley'),
(17800, 17500, 'Bedrijfsvoering', 'Finance', '202603', 'maart',     'Personeelskosten', 8001, 'Wiley'),
(17400, 17500, 'Bedrijfsvoering', 'Finance', '202604', 'april',     'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202605', 'mei',       'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202606', 'juni',      'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202607', 'juli',      'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202608', 'augustus',  'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202609', 'september', 'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202610', 'oktober',   'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202611', 'november',  'Personeelskosten', 8001, 'Wiley'),
(NULL,  17500, 'Bedrijfsvoering', 'Finance', '202612', 'december',  'Personeelskosten', 8001, 'Wiley');

-- 9003 Claims Verwerking 2026
INSERT INTO bedrijfskosten (actual, planversie, divisie, onderdeel, periode, maand, kostensoort, kostenplaats_id, label) VALUES
(33800, 34000, 'Bedrijfsvoering', 'Claims', '202601', 'januari',   'Verwerkingskosten', 9003, 'RoadRunner'),
(33500, 34000, 'Bedrijfsvoering', 'Claims', '202602', 'februari',  'Verwerkingskosten', 9003, 'RoadRunner'),
(34200, 34000, 'Bedrijfsvoering', 'Claims', '202603', 'maart',     'Verwerkingskosten', 9003, 'RoadRunner'),
(33900, 34000, 'Bedrijfsvoering', 'Claims', '202604', 'april',     'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202605', 'mei',       'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202606', 'juni',      'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202607', 'juli',      'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202608', 'augustus',  'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202609', 'september', 'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202610', 'oktober',   'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202611', 'november',  'Verwerkingskosten', 9003, 'RoadRunner'),
(NULL,  34000, 'Bedrijfsvoering', 'Claims', '202612', 'december',  'Verwerkingskosten', 9003, 'RoadRunner');


-- ------------------------------------------------------------
-- 4. FACTUREN
-- ------------------------------------------------------------
INSERT INTO facturen (nummer, leverancier, bedrag, datum, kostenplaats_id, kostensoort, omschrijving) VALUES
-- Normale Microsoft facturen (gemiddeld ~3200)
('INV-2025-0101', 'Microsoft NL',    3150.00, '2025-01-15', 6001, 'Software licenties', 'Microsoft 365 maandlicenties januari 2025'),
('INV-2025-0202', 'Microsoft NL',    3200.00, '2025-02-12', 6001, 'Software licenties', 'Microsoft 365 maandlicenties februari 2025'),
-- *** PIEK factuur maart 2025 ***
('INV-2025-0892', 'Microsoft NL',   18500.00, '2025-03-03', 6001, 'Software licenties', 'Microsoft Enterprise Agreement verlenging 2025 — jaarlicentie alle gebruikers'),
('INV-2025-0315', 'Microsoft NL',    3200.00, '2025-03-28', 6001, 'Software licenties', 'Microsoft 365 maandlicenties maart 2025'),
('INV-2025-0401', 'Microsoft NL',    3300.00, '2025-04-14', 6001, 'Software licenties', 'Microsoft 365 maandlicenties april 2025'),
('INV-2025-0501', 'Microsoft NL',    3150.00, '2025-05-13', 6001, 'Software licenties', 'Microsoft 365 maandlicenties mei 2025'),
('INV-2025-0601', 'Microsoft NL',    3250.00, '2025-06-11', 6001, 'Software licenties', 'Microsoft 365 maandlicenties juni 2025'),
-- Hosting facturen
('INV-2025-0102', 'AWS Nederland',  12500.00, '2025-01-31', 6001, 'Hosting & infrastructuur', 'AWS cloud hosting januari 2025'),
('INV-2025-0203', 'AWS Nederland',  12200.00, '2025-02-28', 6001, 'Hosting & infrastructuur', 'AWS cloud hosting februari 2025'),
('INV-2025-0316', 'AWS Nederland',  12800.00, '2025-03-31', 6001, 'Hosting & infrastructuur', 'AWS cloud hosting maart 2025'),
-- HR facturen
('INV-2025-0103', 'Randstad NL',     5200.00, '2025-01-20', 7001, 'Wervingskosten', 'Werving & selectie consultancy Q1 2025'),
('INV-2025-0204', 'LinkedIn Jobs',   4800.00, '2025-02-18', 7001, 'Wervingskosten', 'LinkedIn vacatureplaatsingen februari 2025'),
-- Marketing Wiley Q1 2025 (hogere campagnekosten)
('INV-2025-0104', 'MediaMonks',     12000.00, '2025-01-25', 9001, 'Campagnekosten', 'Digitale campagne merk Wiley januari 2025'),
('INV-2025-0205', 'MediaMonks',     12500.00, '2025-02-22', 9001, 'Campagnekosten', 'Digitale campagne merk Wiley februari 2025'),
('INV-2025-0317', 'Publicis NL',     9500.00, '2025-03-10', 9001, 'Campagnekosten', 'TV campagne merk Wiley Q1 2025'),
-- Marketing Wiley 2026 — campagne piek
('INV-2026-0101', 'MediaMonks',     11000.00, '2026-01-20', 9001, 'Campagnekosten', 'Digitale campagne merk Wiley januari 2026'),
('INV-2026-0201', 'Publicis NL',    20000.00, '2026-02-03', 9001, 'Campagnekosten', 'Lancering TV campagne Wiley Q1 2026 — kickoff'),
('INV-2026-0202', 'MediaMonks',     12000.00, '2026-02-10', 9001, 'Campagnekosten', 'Digitale activatie lancering Wiley campagne februari 2026'),
('INV-2026-0203', 'Dentsu NL',       6500.00, '2026-02-18', 9001, 'Campagnekosten', 'Out-of-home advertising Wiley campagne februari 2026'),
('INV-2026-0301', 'MediaMonks',     11500.00, '2026-03-05', 9001, 'Campagnekosten', 'Digitale campagne merk Wiley maart 2026'),
-- Juridische kosten Rechtsbijstand
('INV-2025-0105', 'De Brauw NL',     9500.00, '2025-01-28', 5001, 'Juridische kosten', 'Juridisch advies schadedossiers januari 2025'),
('INV-2025-0206', 'De Brauw NL',     9300.00, '2025-02-25', 5001, 'Juridische kosten', 'Juridisch advies schadedossiers februari 2025');


-- ------------------------------------------------------------
-- 5. EVENTS
-- ------------------------------------------------------------
INSERT INTO events (omschrijving, periode, kostenplaats_id, kostensoort, impact_bedrag) VALUES
('Onverwachte Microsoft Enterprise licentie verlenging', '202503', 6001, 'Software licenties', 18500.00),
('Lancering nieuwe campagne merk Wiley Q1 2026',         '202602', 9001, 'Campagnekosten',      17500.00);
