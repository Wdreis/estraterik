-- Fase 1 da reforma Painel Geral (2026-07-28)
-- Adiciona campo de região aos consultores, para separar Oikos Brasília / Oikos BH.
-- Executado diretamente no Supabase em 2026-07-28.

ALTER TABLE consultores ADD COLUMN IF NOT EXISTS regiao TEXT NOT NULL DEFAULT 'brasilia';

-- BH: Bárbara, Anna, Daniela. Todo o resto fica no default 'brasilia'.
UPDATE consultores SET regiao = 'bh' WHERE id IN (2, 9, 10); -- Bárbara, Anna, Daniela
