-- ============================================================
-- ESTRATERIK — Tabela de Clientes / CRM
-- Execute este arquivo no SQL Editor do Supabase
-- ============================================================

CREATE TABLE IF NOT EXISTS clientes (
  id                          SERIAL PRIMARY KEY,

  -- IDENTIFICAÇÃO
  nome                        TEXT NOT NULL,
  consultor_id                INTEGER REFERENCES consultores(id) ON DELETE SET NULL,
  status                      TEXT DEFAULT 'Prospect',
  pais_estado                 TEXT,
  observacoes                 TEXT,

  -- ORIGEM
  origem_indicacao            TEXT,   -- ex: Cliente, Evento, Site, Indicação
  indicado_por                TEXT,
  data_indicacao              DATE,

  -- PRODUTOS DE INTERESSE (flags)
  tem_estudo                  BOOLEAN DEFAULT false,
  tem_investimento            BOOLEAN DEFAULT false,
  tem_previdencia             BOOLEAN DEFAULT false,
  tem_seguro                  BOOLEAN DEFAULT false,
  tem_precatorio              BOOLEAN DEFAULT false,
  tem_pe                      BOOLEAN DEFAULT false,
  tem_bigdeal                 BOOLEAN DEFAULT false,
  tem_valuation               BOOLEAN DEFAULT false,
  tem_consorcio               BOOLEAN DEFAULT false,
  tem_juridico                BOOLEAN DEFAULT false,
  tem_outros                  BOOLEAN DEFAULT false,

  -- TIMELINE DO ESTUDO
  data_apresentacao           DATE,
  data_1a_reuniao             DATE,
  data_2a_reuniao             DATE,
  data_entrega_estudo         DATE,
  contrato_assinado           BOOLEAN DEFAULT false,
  valor_estudo                NUMERIC DEFAULT 0,
  data_pgto_estudo            DATE,
  andamento_estudo            TEXT,   -- ex: Em andamento, Finalizado, Declinado

  -- FECHAMENTO — INVESTIMENTO
  data_fechamento_investimento DATE,

  -- FECHAMENTO — PREVIDÊNCIA
  data_fechamento_previdencia  DATE,
  valor_mensal_previdencia     NUMERIC DEFAULT 0,

  -- FECHAMENTO — SEGURO
  data_fechamento_seguro       DATE,
  premio_mensal_seguro         NUMERIC DEFAULT 0,

  -- FECHAMENTO — PRECATÓRIO
  data_fechamento_precatorio   DATE,
  valor_precatorio             NUMERIC DEFAULT 0,

  -- FECHAMENTO — PRIVATE EQUITY
  data_fechamento_pe           DATE,
  valor_pe                     NUMERIC DEFAULT 0,

  -- FECHAMENTO — CONSÓRCIO
  data_consorcio               DATE,
  valor_consorcio              NUMERIC DEFAULT 0,

  -- FECHAMENTO — JURÍDICO
  data_juridico                DATE,
  valor_juridico               NUMERIC DEFAULT 0,

  -- METADADOS
  created_at                  TIMESTAMPTZ DEFAULT NOW(),
  updated_at                  TIMESTAMPTZ DEFAULT NOW()
);

-- Acesso público (sem autenticação por enquanto)
ALTER TABLE clientes DISABLE ROW LEVEL SECURITY;

-- Atualiza updated_at automaticamente
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER clientes_updated_at
  BEFORE UPDATE ON clientes
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ============================================================
-- DADOS INICIAIS — clientes já existentes na planilha
-- ============================================================
INSERT INTO clientes (nome, consultor_id, status, pais_estado, tem_estudo, tem_investimento, data_indicacao, data_apresentacao, data_1a_reuniao, data_2a_reuniao, data_entrega_estudo, contrato_assinado, valor_estudo, data_pgto_estudo, andamento_estudo) VALUES
  ('Rafaela Antunes', 3, 'Finalizado', 'Brasília', true, true, '2026-01-11', '2026-01-13', '2026-01-19', '2026-02-04', '2026-03-03', true, 7000, '2026-02-16', 'Finalizado'),
  ('Suzana Braga de Moura', 1, 'Finalizado', 'Brasília', true, false, '2026-01-02', NULL, NULL, NULL, NULL, true, 9000, '2026-01-20', 'Finalizado'),
  ('Gabriella Neves', 5, 'Finalizado', 'Brasília', true, true, '2026-01-02', NULL, NULL, NULL, NULL, true, 7000, '2026-01-04', 'Finalizado'),
  ('Antônio Duarte', 1, 'Finalizado', 'Brasília', true, true, '2026-01-02', '2026-03-21', '2026-03-29', '2026-04-03', '2026-04-08', true, 7000, '2026-04-08', 'Finalizado'),
  ('Maria Helisa', 1, 'Finalizado', 'Brasília', true, true, '2026-03-21', '2026-03-21', '2026-04-10', '2026-03-27', NULL, true, 7000, NULL, 'Finalizado');
