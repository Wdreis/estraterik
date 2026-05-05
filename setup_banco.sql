-- ============================================================
-- ESTRATERIK — Setup do Banco de Dados no Supabase
-- Execute este arquivo no SQL Editor do Supabase
-- ============================================================

-- ============================================================
-- 1. TABELA: consultores
-- ============================================================
CREATE TABLE IF NOT EXISTS consultores (
  id            SERIAL PRIMARY KEY,
  nome          TEXT NOT NULL,
  cor           TEXT DEFAULT '#3B82F6',
  meta_nnm_mensal    NUMERIC DEFAULT 0,
  meta_nnm_anual     NUMERIC DEFAULT 0,
  meta_produtos_mensal NUMERIC DEFAULT 0,
  meta_reunioes_mensal INTEGER DEFAULT 10,
  ativo         BOOLEAN DEFAULT true,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE consultores DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- 2. TABELA: captacao_mensal
-- ============================================================
CREATE TABLE IF NOT EXISTS captacao_mensal (
  id             SERIAL PRIMARY KEY,
  consultor_id   INTEGER REFERENCES consultores(id) ON DELETE CASCADE,
  ano            INTEGER NOT NULL,
  mes            INTEGER NOT NULL,
  pl             NUMERIC DEFAULT 0,
  captado        NUMERIC DEFAULT 0,
  saida          NUMERIC DEFAULT 0,
  nnm            NUMERIC DEFAULT 0,
  meta_nnm       NUMERIC DEFAULT 0,
  UNIQUE(consultor_id, ano, mes)
);

ALTER TABLE captacao_mensal DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- 3. TABELA: produtos_mensal
-- ============================================================
CREATE TABLE IF NOT EXISTS produtos_mensal (
  id             SERIAL PRIMARY KEY,
  consultor_id   INTEGER REFERENCES consultores(id) ON DELETE CASCADE,
  ano            INTEGER NOT NULL,
  mes            INTEGER NOT NULL,
  estudos        NUMERIC DEFAULT 0,
  cambio         NUMERIC DEFAULT 0,
  juridico       NUMERIC DEFAULT 0,
  previdencia    NUMERIC DEFAULT 0,
  seguros        NUMERIC DEFAULT 0,
  precatorios    NUMERIC DEFAULT 0,
  consorcio      NUMERIC DEFAULT 0,
  private_equity NUMERIC DEFAULT 0,
  outros         NUMERIC DEFAULT 0,
  meta_produtos  NUMERIC DEFAULT 0,
  UNIQUE(consultor_id, ano, mes)
);

ALTER TABLE produtos_mensal DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- 4. TABELA: leads_mensal
-- ============================================================
CREATE TABLE IF NOT EXISTS leads_mensal (
  id             SERIAL PRIMARY KEY,
  consultor_id   INTEGER REFERENCES consultores(id) ON DELETE CASCADE,
  ano            INTEGER NOT NULL,
  mes            INTEGER NOT NULL,
  reunioes       INTEGER DEFAULT 0,
  meta_reunioes  INTEGER DEFAULT 10,
  targets        INTEGER DEFAULT 0,
  UNIQUE(consultor_id, ano, mes)
);

ALTER TABLE leads_mensal DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- 5. TABELA: oikos_geral_mensal (visão consolidada)
-- ============================================================
CREATE TABLE IF NOT EXISTS oikos_geral_mensal (
  id             SERIAL PRIMARY KEY,
  ano            INTEGER NOT NULL,
  mes            INTEGER NOT NULL,
  pl_total       NUMERIC DEFAULT 0,
  captacao_btg   NUMERIC DEFAULT 0,
  captacao_xp    NUMERIC DEFAULT 0,
  captacao_outros NUMERIC DEFAULT 0,
  captacao_int   NUMERIC DEFAULT 0,
  saida_btg      NUMERIC DEFAULT 0,
  saida_xp       NUMERIC DEFAULT 0,
  nnm_total      NUMERIC DEFAULT 0,
  meta_nnm       NUMERIC DEFAULT 25000000,
  UNIQUE(ano, mes)
);

ALTER TABLE oikos_geral_mensal DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- 6. DADOS: Consultores (8 consultores ativos 2026)
-- ============================================================
INSERT INTO consultores (nome, cor, meta_nnm_mensal, meta_nnm_anual, meta_produtos_mensal, meta_reunioes_mensal) VALUES
  ('Rodolfo',   '#3B82F6', 5000000,  65000000, 15000, 10),
  ('Bárbara',   '#EC4899', 5000000,  65000000, 15000, 10),
  ('Isa',       '#8B5CF6', 3000000,  39000000, 15000, 10),
  ('Bruno',     '#F59E0B', 2500000,  32500000, 15000, 10),
  ('Guilherme', '#10B981', 2500000,  32500000, 15000, 10),
  ('Pedro',     '#06B6D4', 3000000,  39000000, 15000, 10),
  ('Nunes',     '#F97316', 2000000,  26000000, 15000, 10),
  ('Lúcio',     '#94A3B8', 2000000,  26000000, 15000, 10);

-- ============================================================
-- 7. DADOS: Captação Mensal 2026 (Jan–Abr)
-- IDs dos consultores: Rodolfo=1, Bárbara=2, Isa=3,
-- Bruno=4, Guilherme=5, Pedro=6, Nunes=7, Lúcio=8
-- ============================================================

-- JANEIRO 2026
INSERT INTO captacao_mensal (consultor_id, ano, mes, pl, captado, saida, nnm, meta_nnm) VALUES
  (1, 2026, 1, 237610000,  11848156,  20561000,  -8712844, 5000000),
  (2, 2026, 1, 121810000,  20354530,   7337037,  13017493, 5000000),
  (3, 2026, 1,  83440000,   2300518,   3280765,   -980247, 3000000),
  (4, 2026, 1,  42388000,   3873558,   1103249,   2770309, 2500000),
  (5, 2026, 1,  12210000,    301418,     48273,    253145, 2500000),
  (6, 2026, 1,  15460000,    267664,     28261,    239403, 3000000),
  (7, 2026, 1,  10180000,     87426,    985118,   -897692, 2000000),
  (8, 2026, 1,   5030000,     99807,       426,     99381, 2000000);

-- FEVEREIRO 2026
INSERT INTO captacao_mensal (consultor_id, ano, mes, pl, captado, saida, nnm, meta_nnm) VALUES
  (1, 2026, 2, 225040000,   7797628,   4808898,   2988730, 5000000),
  (2, 2026, 2, 122510000,   1605231,   1937460,   -332229, 5000000),
  (3, 2026, 2,  86050000,   1495610,    637145,    858465, 3000000),
  (4, 2026, 2,  47321000,   4678000,    250000,   4428000, 2500000),
  (5, 2026, 2,  12590000,   5297908,    145820,   5152088, 2500000),
  (6, 2026, 2,  17340000,   1621598,    164849,   1456749, 3000000),
  (7, 2026, 2,  10220000,     50265,     69345,    -19080, 2000000),
  (8, 2026, 2,   5111000,   2015861,       466,   2015395, 2000000);

-- MARÇO 2026
INSERT INTO captacao_mensal (consultor_id, ano, mes, pl, captado, saida, nnm, meta_nnm) VALUES
  (1, 2026, 3, 228690000,  12175731,   5867049,   6308682, 5000000),
  (2, 2026, 3, 109870000,  36875333,  17746034,  19129299, 5000000),
  (3, 2026, 3,  87250000,   4591593,   1461340,   3130253, 3000000),
  (4, 2026, 3,  49292000,   2950000,    735000,   2215000, 2500000),
  (5, 2026, 3,  19300000,   1996542,   2694566,   -698024, 2500000),
  (6, 2026, 3,  17230000,   1745113,    198640,   1546473, 3000000),
  (7, 2026, 3,  10100000,     74318,    209405,   -135087, 2000000),
  (8, 2026, 3,   5100000,    340681,     30497,    310184, 2000000);

-- ABRIL 2026
INSERT INTO captacao_mensal (consultor_id, ano, mes, pl, captado, saida, nnm, meta_nnm) VALUES
  (1, 2026, 4, 230750000,   2990119,   2853885,    136234, 5000000),
  (2, 2026, 4, 103020000,    487153,   5226523,  -4739370, 5000000),
  (3, 2026, 4,  92000000,   1965785,    528311,   1437474, 3000000),
  (4, 2026, 4,  47775000,    884057,    544412,    339645, 2500000),
  (5, 2026, 4,  17780000,    188664,     52017,    136647, 2500000),
  (6, 2026, 4,  17680000,    314251,     27119,    287132, 3000000),
  (7, 2026, 4,  10290000,    187026,     72533,    114493, 2000000),
  (8, 2026, 4,   5530000,       156,      8500,     -8344, 2000000);

-- ============================================================
-- 8. DADOS: Produtos Mensal 2026 (apenas valores não-zero)
-- ============================================================

-- JANEIRO 2026
INSERT INTO produtos_mensal (consultor_id, ano, mes, estudos, cambio, juridico, meta_produtos) VALUES
  (1, 2026, 1, 12000,    185,     0, 15000),
  (2, 2026, 1,     0,      0,     0, 15000),
  (3, 2026, 1,     0,   1411,     0, 15000),
  (4, 2026, 1,     0,   2991,     0, 15000),
  (5, 2026, 1,  7000,      0,     0, 15000),
  (6, 2026, 1,     0,      0,     0, 15000),
  (7, 2026, 1,     0,      0,     0, 15000),
  (8, 2026, 1,     0,      0, 15000, 15000);

-- FEVEREIRO 2026
INSERT INTO produtos_mensal (consultor_id, ano, mes, estudos, cambio, juridico, meta_produtos) VALUES
  (1, 2026, 2, 3000,  87.37,     0, 15000),
  (2, 2026, 2,    0,      0,     0, 15000),
  (3, 2026, 2, 7000,    778,     0, 15000),
  (4, 2026, 2,    0,    665,     0, 15000),
  (5, 2026, 2,    0,      0,     0, 15000),
  (6, 2026, 2,    0,      0,     0, 15000),
  (7, 2026, 2,    0,      0,     0, 15000),
  (8, 2026, 2,    0,      0,     0, 15000);

-- MARÇO 2026
INSERT INTO produtos_mensal (consultor_id, ano, mes, estudos, cambio, juridico, consorcio, meta_produtos) VALUES
  (1, 2026, 3, 10000,      0,      0,     0, 15000),
  (2, 2026, 3,     0,  26687,      0,     0, 15000),
  (3, 2026, 3,     0,  34260,      0,     0, 15000),
  (4, 2026, 3,     0,   2940,      0,  1200, 15000),
  (5, 2026, 3,     0,     10,  52000,     0, 15000),
  (6, 2026, 3,     0,     10,      0, 11220, 15000),
  (7, 2026, 3,     0,     10,      0,     0, 15000),
  (8, 2026, 3,     0,     10,      0,     0, 15000);

-- ABRIL 2026
INSERT INTO produtos_mensal (consultor_id, ano, mes, estudos, juridico, meta_produtos) VALUES
  (1, 2026, 4, 3000,     0, 15000),
  (2, 2026, 4,    0,     0, 15000),
  (3, 2026, 4,    0, 40000, 15000),
  (4, 2026, 4,    0,     0, 15000),
  (5, 2026, 4,    0,     0, 15000),
  (6, 2026, 4,    0,     0, 15000),
  (7, 2026, 4,    0,     0, 15000),
  (8, 2026, 4,    0,     0, 15000);

-- ============================================================
-- 9. DADOS: Leads / Reuniões 2026
-- ============================================================
INSERT INTO leads_mensal (consultor_id, ano, mes, reunioes, meta_reunioes, targets) VALUES
  (1, 2026, 3, 17, 10, 17), (2, 2026, 3,  0, 10,  0),
  (3, 2026, 3, 12, 10, 12), (4, 2026, 3, 30, 10, 30),
  (5, 2026, 3, 25, 10, 25), (6, 2026, 3, 11, 10, 11),
  (7, 2026, 3, 21, 10, 21), (8, 2026, 3,  3, 10,  3);

INSERT INTO leads_mensal (consultor_id, ano, mes, reunioes, meta_reunioes, targets) VALUES
  (1, 2026, 4, 17, 10, 17), (2, 2026, 4,  0, 10,  0),
  (3, 2026, 4, 12, 10, 12), (4, 2026, 4, 30, 10, 30),
  (5, 2026, 4, 25, 10, 25), (6, 2026, 4, 11, 10, 11),
  (7, 2026, 4, 21, 10, 21), (8, 2026, 4,  3, 10,  3);

-- ============================================================
-- 10. DADOS: Oikos Geral Mensal (consolidado empresa)
-- ============================================================
INSERT INTO oikos_geral_mensal (ano, mes, pl_total, captacao_btg, captacao_xp, captacao_outros, captacao_int, saida_btg, saida_xp, nnm_total, meta_nnm) VALUES
  (2026, 1, 528128000, 25581584, 12173493,       0, 1378000, 25057005,  8287124,  5788948, 25000000),
  (2026, 2, 526182000, 16770766,  4048335, 3700000, 1421000,  4147549,  3866434, 17926118, 25000000),
  (2026, 3, 526832000, 15683759,  7021552,       0,39465000, 22191342,  6751189, 33227780, 25000000),
  (2026, 4, 524825000,  4269173,  2748038,       0,       0,  3833966,  5479334, -2296089, 25000000);
