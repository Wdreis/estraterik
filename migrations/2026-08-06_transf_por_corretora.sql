-- Destrincha a Transferência Nacional → Internacional por corretora (2026-08-06)
-- Erik pediu para conseguir mostrar, separadamente, quanto da saída de cada
-- corretora nacional (BTG/XP/Outros) foi na verdade transferência p/ Internacional
-- (não é perda real de capital) — hoje só existia um valor único agregado.
-- transf_nac_para_int continua existindo e passa a ser gravado como a SOMA das três
-- abaixo, para não quebrar nenhuma fórmula já existente em painel-geral.html,
-- internacional.html e apresentacao.html.

ALTER TABLE captacao_mensal ADD COLUMN IF NOT EXISTS transf_btg_int    NUMERIC DEFAULT 0;
ALTER TABLE captacao_mensal ADD COLUMN IF NOT EXISTS transf_xp_int     NUMERIC DEFAULT 0;
ALTER TABLE captacao_mensal ADD COLUMN IF NOT EXISTS transf_outros_int NUMERIC DEFAULT 0;

-- Migra os dados já existentes: se algum mês já tinha transf_nac_para_int preenchido
-- sem quebrar por corretora, joga tudo em transf_btg_int como aproximação inicial
-- (pode ser ajustado manualmente depois via Editar Mês).
UPDATE captacao_mensal
SET transf_btg_int = transf_nac_para_int
WHERE transf_nac_para_int > 0 AND transf_btg_int = 0 AND transf_xp_int = 0 AND transf_outros_int = 0;
