-- Novo card "PL Internacional Novo" pedido pelo Erik (2026-09-14)
-- O card "Transferências Internacionais" (criado em 2026-08-06) misturava duas coisas
-- diferentes: (1) dinheiro que saiu do book NACIONAL da Oikos (BTG/XP/Outros) e foi pra
-- base internacional da Oikos — já existia (transf_nac_para_int) — e (2) dinheiro que o
-- cliente já tinha em OUTRA corretora internacional, fora da Oikos, e trouxe pra base
-- internacional da Oikos. Erik apontou que o card único dava a entender que o consultor
-- tinha "perdido" aquele dinheiro, quando na verdade parte dele é ganho novo pra Oikos.
--
-- transf_ext_para_int é o caso (2): campo único (sem separar por corretora), puramente
-- informativo — não entra em captado_int/saida_int/nnm, só aparece no card à parte em
-- internacional.html.

ALTER TABLE captacao_mensal ADD COLUMN IF NOT EXISTS transf_ext_para_int NUMERIC DEFAULT 0;
