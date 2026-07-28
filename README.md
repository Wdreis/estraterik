# ESTRATERIK — Dashboard de Consultores

Dashboard online de acompanhamento dos consultores da Oikos Family Office.

## Tecnologias
- Frontend: HTML + CSS + JavaScript (páginas estáticas, sem build)
- Banco de dados: Supabase (PostgreSQL)
- Hospedagem: Netlify

## Como configurar o banco de dados
1. Acesse o projeto no Supabase
2. Vá em **SQL Editor**
3. Execute o arquivo `setup_banco.sql`
4. Migrations posteriores ficam documentadas em `migrations/`

## Link do dashboard
`oikosestraterik.netlify.app` — deploy automático a cada push em `main`.

## Páginas principais
- `painel-geral.html` — visão anual/por período e mensal (fundida com o antigo Dashboard), inclui submenu Oikos Brasília / Oikos BH
- `consultor.html` — dashboard individual do consultor
- `clientes.html` — CRM de clientes
- `internacional.html` — movimentação internacional
- `ata.html` — atas de reunião
- `gestao.html` — gestão de consultores
