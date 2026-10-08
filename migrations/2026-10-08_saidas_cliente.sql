-- Saídas por cliente (2026-10-08) — Erik pediu saber de qual cliente saiu cada saída do mês.
-- Cada linha = uma saída identificada (cliente + valor + corretora de origem), por consultor/mês.
-- O total de saída continua em captacao_mensal.saida*; esta tabela só detalha de onde veio.

CREATE TABLE IF NOT EXISTS saidas_cliente (
  id BIGSERIAL PRIMARY KEY,
  consultor_id INTEGER NOT NULL REFERENCES consultores(id),
  ano INTEGER NOT NULL,
  mes INTEGER NOT NULL,
  nome_cliente TEXT NOT NULL,
  valor NUMERIC NOT NULL DEFAULT 0,
  corretora TEXT,            -- 'BTG','XP','Outros','Internacional'
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_saidas_cliente_periodo ON saidas_cliente(ano, mes, consultor_id);
