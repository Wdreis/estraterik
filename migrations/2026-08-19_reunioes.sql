-- Painel de Acompanhamento de Reuniões (Agenda) — pedido pelo Erik em 2026-08-19
-- Erik mandou print de um painel "Agenda" de outra ferramenta e pediu algo parecido
-- pro ESTRATERIK. Hoje o sistema só tem um contador mensal de reuniões por consultor
-- (leads_mensal.reunioes) — não existe registro de cada reunião individual (data,
-- tipo, categoria, desfecho). Esta tabela nova guarda cada reunião como uma linha,
-- cadastrada manualmente em agenda.html (sem integração com calendário/CRM externo).

CREATE TABLE IF NOT EXISTS reunioes (
  id BIGSERIAL PRIMARY KEY,
  consultor_id INTEGER NOT NULL REFERENCES consultores(id),
  data DATE NOT NULL,
  tipo TEXT,                 -- 'Revisão de Carteira','Apresentação de Estratégia','Revisão de Acompanhamento',
                              -- 'Apresentação','Alinhamento Interno','1ª Reunião','Reunião de Entrevista','Outros'
                              -- NULL = sem tipo definido
  categoria TEXT NOT NULL DEFAULT 'cliente' CHECK (categoria IN ('prospect','cliente','parceiro','interna')),
  status TEXT NOT NULL DEFAULT 'realizada' CHECK (status IN ('agendada','realizada')),
  titulo TEXT,                -- identificador livre (nome do cliente/prospect/assunto), opcional
  respondida BOOLEAN NOT NULL DEFAULT false,
  com_fechamento BOOLEAN NOT NULL DEFAULT false,
  relacionamento BOOLEAN NOT NULL DEFAULT false,
  indicacoes INTEGER NOT NULL DEFAULT 0,
  observacoes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_reunioes_consultor_data ON reunioes(consultor_id, data);
CREATE INDEX IF NOT EXISTS idx_reunioes_data ON reunioes(data);
