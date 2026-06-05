# LEX.OS Control

Plataforma premium **LEX.OS Control** para gestão e inteligência operacional de escritórios de advocacia, atualmente preparada para piloto controlado.

## Release Candidate — QA reproduzível do piloto controlado

A rodada de QA do Release Candidate preserva a identidade navy premium aprovada e adiciona uma suíte local segura para repetir as validações essenciais do piloto sem depender do ambiente conectado:

- Smoke test de navegação em Visão Geral, Clientes, Processos, Tarefas, Agenda, Financeiro, Central LEX.OS, Painel dos Sócios, Relatórios, Configurações, Implantação e Primeiros passos.
- Validação responsiva em notebook (`1366x768`) e monitor grande (`1920x1080`), incluindo detecção de overflow horizontal global.
- Cobertura demonstrativa de volume inicial, busca, filtros, estado vazio, cadastro com nome longo e persistência local após reload.
- Verificação explícita do isolamento da demonstração: nenhuma requisição externa automática durante a navegação.
- Conferência das mensagens de piloto seguro, revisão humana obrigatória e ausência de envio externo automático.

Para executar localmente, use `npm run test:e2e:demo`. O Playwright inicia o servidor Next.js automaticamente quando necessário.



## Hotfix 4B.2 — Sidebar, labels e hover premium

Ajuste fino sobre a Etapa 4B.2, preservando a densidade compacta aprovada:

- Sidebar refinada para melhor aproveitamento vertical, com presença visual mais encorpada, menu próximo do rodapé e sem sobreposição.
- Labels técnicas de indicadores passam por humanização de exibição, evitando camelCase visível em painéis executivos e relatórios.
- Cards informativos e blocos de diagnóstico receberam hover premium sutil, com feedback visual discreto em Configurações, Segurança, Implantação, Relatórios e Painel dos Sócios.
- Sem alteração de schema, autenticação, permissões, CRUDs, migrações ou integrações externas.

## Etapa 4B.2 — Usabilidade diária premium

Rodada fina de usabilidade para rotina diária do escritório, preservando a base aprovada e sem alterar dados, schema ou integrações:

- Interface menos cansativa, com heroes, cards, tabelas, filtros, modais e empty states mais compactos para reduzir rolagem e acelerar leitura.
- Densidade operacional premium aplicada aos módulos de uso diário, mantendo ações principais visíveis e listas mais objetivas.
- Navegação mais rápida com sidebar sóbria, preenchida e estável, preservando o nome do escritório, o modo demonstração separado e a identidade navy/gold/silver/off-white.
- Central LEX.OS, Relatórios, Painel dos Sócios, Configurações, Segurança, Implantação e Onboarding seguem com linguagem executiva, revisão humana e foco em operação do escritório.
- Não altera Supabase, autenticação, permissões, CRUDs, activity logs, schema, tabelas, migrações ou APIs externas.

## Experimento 4B.1 — Densidade visual compacta premium

Variação experimental para comparação com a Etapa 4B aprovada, focada em densidade premium operacional sem alterar schema ou dados:

- Reduz rolagem vertical em páginas executivas, operacionais e de implantação com shell, cards, tabelas, filtros e empty states mais compactos.
- Ajusta tipografia, espaçamentos e cards para leitura diária mais rápida, preservando a identidade navy/gold/silver/off-white e a legibilidade dos temas disponíveis.
- Mantém Dashboard, Painel dos Sócios, Central LEX.OS, Relatórios, Configurações, Segurança, Release, Onboarding e módulos operacionais com aparência premium, porém mais objetivos para navegação recorrente.
- Não altera Supabase, autenticação, permissões, RLS, queries, CRUDs, activity logs, schema, tabelas ou integrações externas.

## Etapa 4B — Refinamento premium visual e comercial

Rodada transversal aplicada para elevar a percepção comercial do piloto controlado sem alterar schema, criar integrações externas ou mudar regras de autenticação:

- Dashboard, Painel dos Sócios, Central LEX.OS, Relatórios, Configurações, Segurança, Implantação e módulos operacionais receberam ajustes de copy para linguagem mais executiva, humana e orientada à operação do escritório.
- Empty states foram refinados para orientar o próximo passo com tom premium, especialmente Clientes, Processos, Tarefas, Agenda, Financeiro, Relatórios, Central LEX.OS e Prompts.
- Cards, badges e superfícies compartilhadas foram padronizados para melhorar hierarquia visual, contraste e leitura nos temas Navy premium, Claro institucional, Alto contraste e Minimalista executivo.
- A interface comum ficou menos técnica: referências internas sensíveis permanecem protegidas/recolhidas, com foco em “escritório”, “operação”, “controle interno”, “implantação” e “revisão humana”.
- A etapa não cria tabelas, não adiciona chaves, não usa service role, não altera o schema e preserva o piloto controlado, o modo demonstração e o ambiente conectado do escritório.

## Etapa 4A.2 — Refinamento executivo para piloto

A interface foi refinada para apresentação ao escritório piloto com foco em linguagem comercial, executiva e segura:

- IDs técnicos e códigos internos foram ocultados da interface comum, especialmente Dashboard, Topbar, Sidebar, Configurações, Segurança, Implantação e Onboarding.
- Detalhes técnicos foram preservados em áreas avançadas/recolhidas dentro de Configurações, Segurança e Implantação, evitando exposição no fluxo principal do usuário.
- Linguagem visível ao cliente foi ajustada: “workspace” passou a ser tratado como “escritório”, “Supabase” como “ambiente conectado”, “RLS” como “controle de acesso por usuário” e “activity logs” como “auditoria operacional”.
- O menu lateral foi refinado para uma experiência mais premium, usando “Implantação” no lugar de “Release Piloto” e “Primeiros passos” no lugar de “Onboarding piloto”.
- Empty states e mensagens operacionais foram reescritos para orientar o usuário com clareza, sem aparência de teste/MVP ou jargão técnico.
- O visual navy/gold/silver/off-white foi preservado para manter a percepção institucional e premium.

## Status da Implantação — Auditoria Final do LEX.OS Control

Status: **Pronto para piloto controlado**. O sistema deve ser apresentado e utilizado como validação assistida em escritório real, não como produto público final.

### Módulos implementados no piloto

- Configurações, escritório, perfil, usuários e permissões.
- Clientes, Processos, Parcerias, Tarefas, Agenda/Prazos e Financeiro.
- Dashboard, Painel dos Sócios, Relatórios, Central LEX.OS, Dossiê Rápido, Agentes, Fluxos e Playbooks.
- Biblioteca/Gerenciador de Prompts, Auditoria operacional, Primeiros passos de implantação e Segurança/LGPD.
- Página `/configuracoes/release` apresentada como Implantação, com status, checklist de entrega, checklist de teste, manual rápido copiável, limitações conhecidas e próximos passos.

### Configuração Supabase

Variáveis públicas esperadas no ambiente de execução:

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_LEXOS_DATA_SOURCE=supabase
```

Regras de segurança para o piloto:

- Não criar ou commitar `.env.local`.
- Não usar chaves administrativas ou credenciais privilegiadas no frontend.
- Não relaxar RLS, não criar policy pública aberta e não misturar dados demo com registros reais.
- Usar somente a sessão autenticada do usuário e policies por `workspace_id`/membro ativo.

### Migrações aplicadas/necessárias

As tabelas reais usadas pelo piloto estão descritas em `supabase/migrations` e `supabase/schema.sql`:

- `clients` para Clientes.
- `processes` para Processos.
- `process_partnerships` para Parcerias.
- `tasks` para Tarefas.
- `agenda_events` para Agenda/Prazos.
- `financial_records` para Financeiro.
- `reports` para Relatórios.
- `central_executions` para Central LEX.OS.
- `prompt_templates` e `prompt_template_versions` para Prompts.
- `profiles`, `workspaces`, `workspace_members` e `activity_logs` para identidade, permissões e auditoria.

### Separação demo/real

- Sessão Supabase real deve exibir somente dados do workspace real e respeitar RLS/membership.
- Modo demonstração deve usar somente dados locais/fictícios e não consultar dados reais do Supabase.
- Estados vazios em Supabase devem permanecer vazios/seguros, sem seed ou mock demonstrativo.
- Dados reais nunca devem aparecer no modo demo; dados demo nunca devem aparecer em sessão Supabase.

### Permissões mínimas revisadas

Papéis reconhecidos: `owner`, `admin`, `socio`, `advogado`, `estagiario`, `financeiro`, `operacional` e `leitura`.

- Painel dos Sócios fica restrito a papéis autorizados.
- Financeiro fica restrito quando aplicável.
- Usuários/permissões e configurações avançadas ficam restritas a owner/admin quando aplicável.
- Segurança/LGPD e Release são áreas de apoio operacional e exibem avisos de uso controlado.

### Limitações conhecidas do piloto

- Piloto controlado; não é produto público final.
- Sem IA real/API externa, OpenAI/Claude/Gemini, WhatsApp, e-mail real ou Google Calendar.
- Sem portal do cliente, marketplace, billing real, gateway, boleto, PIX ou contabilidade oficial integrada.
- Sem backup automático avançado, importação em massa, contrato/termos públicos definitivos, SSO/MFA customizado.
- Relatórios, prompts e saídas da Central exigem revisão humana antes de uso externo.
- Financeiro é controle interno, não gateway/contabilidade.
- Checklist LGPD é apoio operacional, não parecer jurídico completo.

### Roteiro de teste ponta a ponta

1. Entrar no ambiente conectado, confirmar dados do escritório ativos e sair.
2. Entrar na demonstração e confirmar isolamento demo/local.
3. Abrir rotas principais: `/dashboard`, `/clientes`, `/processos`, `/processos/parcerias`, `/tarefas`, `/agenda`, `/financeiro`, `/relatorios`, `/central-lexos`, `/central-lexos/prompts`, `/socios`, `/configuracoes`, `/configuracoes/seguranca`, `/configuracoes/release` e `/onboarding`.
4. Criar/editar item em pelo menos cinco módulos principais e recarregar com F5 para confirmar persistência.
5. Gerar relatório, executar Central LEX.OS, cadastrar/versionar prompt e revisar auditoria operacional.
6. Testar tema Navy premium e Claro institucional para legibilidade.
7. Validar comandos técnicos: `npm run typecheck`, `npm run build`, `npm run lint`, `git diff --check`, ausência de `.env.local` e ausência de chaves administrativas.

### Roteiro de entrega ao escritório piloto

1. Configurar Supabase e aplicar migrações necessárias.
2. Criar usuários reais no Supabase Auth e vincular em `workspace_members`.
3. Revisar escritório, papel de cada membro e áreas sensíveis.
4. Remover/arquivar dados de teste manualmente quando necessário.
5. Abrir `/configuracoes/release` (Implantação), copiar o manual rápido e o checklist de teste.
6. Apresentar o sistema como piloto controlado, com revisão humana obrigatória para saídas externas.
7. Coletar feedback semanal, registrar bugs e priorizar hotfixes antes de novas integrações.

### Próximos passos pós-piloto

- Consolidar feedback de UX, permissões e estabilidade.
- Formalizar documentos públicos, rotinas de backup e governança de dados.
- Planejar integrações externas somente depois da validação operacional.
- Evoluir permissões granulares, auditoria e observabilidade antes do uso ampliado.

## Etapa 3N — Onboarding de Escritório Real / Cliente Piloto

Status: `/onboarding` prepara o workspace para entrega controlada a um escritório real, mantendo Supabase real, demonstração local e dados de teste claramente separados.

### O que foi implementado

- Tela premium de onboarding com mensagem central: “Prepare seu escritório para usar o LEX.OS Control com dados reais.”
- Painel de status “Em preparação”, “Quase pronto” ou “Pronto para piloto”, calculado de forma determinística a partir do checklist de implantação.
- Identidade inicial do escritório com edição segura de nome e status do workspace real usando a mesma camada de Configurações. Campos comerciais/visuais continuam demonstrativos quando não há schema seguro próprio.
- Checklist de implantação com itens para workspace, administrador ativo, clientes, processos, tarefas, agenda, financeiro, prompts, relatórios, Central LEX.OS, activity logs, separação demo/real e permissões.
- Resumo operacional do workspace piloto com usuário atual, papel atual, membros, clientes, processos, tarefas, eventos, registros financeiros, prompts, relatórios, Central LEX.OS e últimas atividades.
- Detecção não destrutiva de dados de teste em `clients`, `processes`, `process_partnerships`, `tasks`, `agenda_events`, `financial_records`, `reports`, `central_executions` e `prompt_templates`. A tela apenas orienta revisão manual, com botões “Ver registros”, “Ir para o módulo” e “Marcar como revisar depois”.
- Separação explícita entre modo demonstração, modo Supabase real e dados reais de teste criados durante validação.
- Cards de ação rápida para cadastrar os primeiros clientes, processos, tarefas, prazos, cobranças, prompts, relatórios, execuções da Central LEX.OS e revisão de usuários/permissões.
- Guia de primeiro uso por Dia 1, Dia 2, Dia 3 e primeira semana.
- Checklist de entrega ao cliente piloto sem contrato, billing, convite real por e-mail ou integrações externas.
- Bloco copiável “Como começar no LEX.OS Control” com toast visual e tentativa segura de activity log.
- Atalho discreto em Configurações e item lateral “Primeiros passos”.

### Permissões e segurança

- `owner`, `admin` e `socio` acessam checklist, status e preparação do piloto; edição do workspace real segue restrita a owner/admin pela matriz existente.
- `advogado` e `operacional` recebem acesso guiado aos primeiros passos e ao manual rápido.
- `estagiario`, `leitura` e papéis sem permissão veem a tela premium “Acesso restrito neste workspace.”
- Nenhum dado real é apagado automaticamente e não há exclusão/arquivamento em massa nesta etapa.
- Não há chave administrativa no frontend, policy pública aberta, `.env.local`, chaves reais ou conexão com APIs externas.
- Logs tentados: `onboarding_viewed`, `onboarding_workspace_updated`, `onboarding_checklist_reviewed`, `onboarding_guide_copied` e `onboarding_pilot_marked_ready`. Falha de auditoria não bloqueia o fluxo.

### Limitações atuais

- Sem billing real, contrato automático, assinatura digital, convite real por e-mail, portal do cliente, WhatsApp/e-mail real, Google Calendar real, migração/importação em massa ou IA real.
- A detecção de teste é heurística por textos/nomes contendo marcadores como `TESTE`, `DEMO`, `3C`, `3D`, `3E`, `3F`, `3K`, `FINANCEIRO REAL TESTE`, `PROCESSO REAL TESTE`, `TAREFA REAL TESTE`, `AGENDA REAL TESTE` e `PROMPT REAL TESTE`.
- A tela não mistura dados demo em sessão Supabase; se o usuário entrar pela demonstração, o onboarding não consulta dados reais.

### Próximos passos

- Segurança/LGPD/produção: revisar retenção, minimização de dados, papéis, RLS e trilhas de auditoria antes de uso ampliado.
- Auditoria final: validar queries, logs, permissões e ausência de chaves sensíveis no repositório.
- Release piloto: congelar escopo, revisar manual rápido, agendar feedback inicial e preparar checklist operacional para o escritório escolhido.

## Hotfix 3N — Identidade operacional e preferência visual editáveis

- Os campos “Identidade operacional” e “Preferência visual básica” agora ficam clicáveis/editáveis em `/onboarding` e `/configuracoes` para papéis autorizados.
- Em Supabase, os valores são preservados em `profiles.metadata.lexos_workspace_settings`, reaproveitando metadata existente sem criar nova tabela, sem chave administrativa e sem misturar modo demonstração com workspace real.
- Em demonstração, os mesmos campos continuam persistindo apenas localmente no navegador.

## Hotfix 3N.2 — Preferência visual aplicada como tema

- A “Preferência visual básica” agora aplica variação visual real no shell global do app, alterando fundo, cards, bordas, realces/accent, contraste textual e aparência do sidebar/header conforme o valor escolhido.
- `Navy premium` permanece como padrão/fallback; `Claro institucional`, `Alto contraste` e `Minimalista executivo` são aplicados por `data-lexos-theme` e variáveis CSS sem refazer o design global.
- O valor continua salvo nas configurações existentes e o modo demonstração segue separado do workspace Supabase real.

## Hotfix 3N.3 — Contraste do Claro institucional

- O tema `Claro institucional` foi revisado para legibilidade: textos principais/secundários, labels, inputs, selects, cards, botões, badges e superfícies com gradientes fixos agora usam contraste escuro sobre fundos claros.
- Os demais temas foram preservados, com `Navy premium` continuando como padrão/fallback.

## Hotfix 3N.4 — Claro institucional por tokens globais

- O tema `Claro institucional` foi revisado com tokens semânticos globais (`--lex-bg`, `--lex-surface`, `--lex-text`, `--lex-border`, `--lex-input-*`, `--lex-sidebar-*`, `--lex-button-*`) para evitar mistura de fundo claro com elementos hardcoded escuros.
- Foram neutralizadas cores dark fixas em shell, sidebar/topbar, cards, ações do dashboard, inputs/selects, botões, badges, tabelas, modais e páginas principais sem remover os demais temas.
- `Navy premium` permanece como tema padrão/fallback.

## Etapa 3K — Gerenciador de Prompts real por workspace

Status: `/central-lexos/prompts` agora funciona como Biblioteca/Gerenciador de Prompts real quando há sessão Supabase ativa, mantendo o modo demonstração separado.

### Migração necessária

Antes do teste final em Supabase, execute manualmente no SQL Editor o arquivo:

```bash
supabase/migrations/202605152230_create_prompt_library.sql
```

A migração cria `public.prompt_templates` e `public.prompt_template_versions`, com `workspace_id`, `created_by`, título, categoria, área jurídica, tipo, status, visibilidade, versão atual, corpo do prompt, variáveis, tags, metadados, arquivamento e timestamps. Também habilita RLS por membro ativo em `workspace_members`, sem policy pública aberta.

### Comportamento em sessão Supabase

- Prompts reais são sempre filtrados por `workspace_id` e membership ativo.
- A tela mostra empty state quando não há prompts reais: “Nenhum prompt real cadastrado neste workspace.”
- O formulário permite cadastrar título, descrição, categoria, área jurídica, tipo, público/uso, tags, variáveis esperadas, corpo, status, visibilidade e resumo da versão.
- Ao cadastrar, cria uma linha em `prompt_templates` e registra a versão 1 em `prompt_template_versions`.
- Ao editar, incrementa `current_version` e preserva a versão anterior com nova linha em `prompt_template_versions`.
- Arquivamento é não destrutivo: `status = archived` e `archived_at` preenchido.
- A execução de prompt usa o `prompt_body` real, variáveis preenchidas manualmente e seleção opcional de cliente/processo/tarefa/financeiro/parceria.
- A saída é determinística, sem IA real, e é salva em `public.central_executions` com metadados do prompt (`prompt_template_id`, título e versão).
- Busca global em sessão Supabase inclui prompts reais por workspace e abre `/central-lexos/prompts?promptId=ID`.
- Dashboard e Central LEX.OS passam a considerar a contagem de prompts reais quando simples e seguro.

### Comportamento em demonstração

- Entrar por **Entrar na demonstração** mantém a biblioteca demo/local separada.
- Prompts reais do Supabase não aparecem na demonstração.
- Dados demo/local não são usados para preencher a sessão Supabase real.

### Limites desta etapa

- Não há IA real, OpenAI API, Claude API, Gemini API, marketplace externo, aprovação formal por sócio, importação/exportação em massa nem integração com Word/PDF.
- Prompts globais/marketplace ficam documentados como etapa futura; usuários comuns não podem inserir ou alterar prompts globais pela política criada.
- Toda saída de prompt exibe aviso de revisão humana obrigatória antes de uso externo.

## Etapa 3I — Relatórios reais com Supabase

Status: `/relatorios` agora funciona como módulo real/controlado quando há sessão Supabase ativa, mantendo o modo demonstração separado.

### Migração necessária

Antes do teste final em Supabase, execute manualmente no SQL Editor o arquivo:

```bash
supabase/migrations/202605152030_create_reports.sql
```

A migração cria `public.reports` com histórico de relatórios, `metrics`, `sections`, `filters`, `metadata`, `copied_at`, `archived_at`, timestamps e vínculos opcionais com `clients` e `processes`. A tabela usa RLS por membership ativo em `workspace_members`, sem policy pública aberta.

### Comportamento em sessão Supabase

- Relatórios usam exclusivamente dados reais do workspace em `clients`, `processes`, `process_partnerships`, `tasks`, `agenda_events`, `financial_records` e `reports`.
- A geração é determinística, em português brasileiro, sem IA real, sem OpenAI API e sem inventar dados ausentes.
- O histórico real é salvo em `public.reports` e pode ser aberto, copiado, baixado como `.md` simples e arquivado sem exclusão destrutiva.
- O botão de copiar atualiza `copied_at`/`status` quando permitido pela sessão e exibe toast visual.
- O arquivamento atualiza `status = archived` e `archived_at`, removendo o item da lista principal e preservando acesso no filtro de arquivados.
- Se não houver histórico, a tela mostra: “Nenhum relatório real gerado neste workspace.”
- Busca global em sessão Supabase inclui relatórios reais por `workspace_id` com rota `/relatorios?reportId=ID`.

### Comportamento em demonstração

- Entrar por **Entrar na demonstração** mantém os relatórios demo/local no navegador.
- Relatórios reais do Supabase não aparecem na demonstração.
- Dados demo/local não são usados para preencher relatório real em sessão Supabase.

### Limites desta etapa

- Não há IA real, OpenAI API, LLM, Gmail, WhatsApp, Google Calendar, tribunais, bancos, PIX, boleto, n8n ou integrações externas.
- Não há PDF/Word avançado; o download simples `.md` permanece disponível.
- Todo relatório contém aviso de revisão humana: “Relatório gerado com dados do workspace. Revisão humana recomendada antes de uso externo.”

## Etapa 3H — Auditoria de Consistência Supabase Real

Status: auditoria transversal aplicada para estabilizar a separação entre sessão Supabase real e modo demonstração/local antes de Relatórios reais, Central LEX.OS com dados reais e Prompts reais por workspace.

### Módulos reais integrados ao Supabase

Em sessão autenticada Supabase, a aplicação deve ler e persistir somente registros do workspace real nas tabelas já existentes:

- `workspaces`, `profiles` e `workspace_members` para Configurações, workspace e perfil.
- `clients` para Clientes.
- `processes` para Processos.
- `process_partnerships` para Parcerias processuais.
- `tasks` para Tarefas.
- `agenda_events` para Agenda/Prazos.
- `financial_records` para Financeiro.
- `activity_logs` quando disponível, além de derivações determinísticas por `created_at`/`updated_at` para Dashboard e Painel dos Sócios.

### Separação Supabase x demo/local

- Login Supabase real exibe **Modo de dados: Supabase** em `/configuracoes` e não deve carregar mocks, seeds ou `localStorage` da demonstração.
- **Entrar na demonstração** exibe **Modo de dados: demo local** em `/configuracoes` e usa somente dados locais/fictícios.
- Dados demo não devem aparecer em sessão real; dados reais não devem aparecer na demonstração.
- Busca global em sessão Supabase usa clientes, processos, parcerias, tarefas, agenda e financeiro reais do workspace, com rotas específicas por item quando disponíveis.
- Busca, notificações e estados vazios foram ajustados para não expor conteúdo demonstrativo antigo em sessão real.

### Correções e limites conhecidos da auditoria

- Clientes inativos/arquivados permanecem fora da visão principal e aparecem no filtro próprio, sem exclusão destrutiva.
- Processos, parcerias, tarefas, agenda e financeiro mantêm arquivamento/cancelamento/conclusão como atualização de status/campos de controle, preservando histórico.
- Vínculos entre módulos usam os campos reais já existentes (`client_id`, `process_id`, `task_id`) e metadados compatíveis quando o schema de origem ainda não possui todos os campos de UI.
- Relatórios reais, Central LEX.OS real e Prompts reais por workspace continuam como próximos passos; em sessão Supabase, blocos sem tabela real permanecem zerados/empty state.
- Sem novas tabelas nesta etapa; sem IA real, OpenAI API, Gmail, WhatsApp, Google Calendar, tribunais, bancos, PIX, boleto, n8n ou integrações externas.

### Segurança operacional

- Não commitar `.env.local`, chaves reais, chaves administrativas, segredos Supabase ou tokens.
- O frontend deve usar somente chaves públicas do Supabase e a sessão autenticada do usuário.
- RLS não deve ser relaxada com policy pública aberta; dados reais precisam permanecer filtrados por `workspace_id` e vínculo ativo em `workspace_members`.

### Próximos passos sugeridos

- Relatórios reais com Supabase.
- Central LEX.OS com dados reais.
- Prompts reais por workspace.
- Permissões mais refinadas por perfil/papel.
- `activity_logs` mais completos para auditoria operacional.


## Etapa 3G — Dashboard e Painel dos Sócios com Supabase real

- `/dashboard` e `/socios` agora respeitam a fonte de dados da sessão ativa: em login Supabase real consolidam exclusivamente registros do workspace real; em **Entrar na demonstração** continuam usando o comportamento local/demo separado.
- As consolidações reais usam as tabelas já existentes: `clients`, `processes`, `process_partnerships`, `tasks`, `agenda_events` e `financial_records`.
- Em sessão Supabase, tabelas vazias retornam indicadores zerados e estados vazios premium, sem seed, mock ou `localStorage` misturado.
- O Dashboard calcula cards, Hoje no escritório, alertas determinísticos, Agenda da semana, Financeiro rápido, Parcerias em atenção e atividades derivadas de `created_at`/`updated_at` dos registros reais.
- O Painel dos Sócios calcula indicadores estratégicos, saúde operacional (`Estável`, `Atenção`, `Crítica`), gargalos e recomendações determinísticas com base nos mesmos dados reais.
- Relatórios gerados e Uso da Central LEX.OS aparecem como zero/empty state em sessão Supabase quando não houver tabela/histórico real disponível.
- Esta etapa **não** adiciona IA real, automações reais, notificações reais, envio de e-mail/WhatsApp, Google Calendar, banco/gateway ou integrações externas.

## Escopo desta entrega

- Next.js + TypeScript + Tailwind CSS.
- Layout dark premium com sidebar fixa, topbar, busca global visual, notificações e perfil.
- Dados fictícios/mockados em arquivos locais.
- Componentes reutilizáveis para cards, tabelas, badges, kanban, calendário, formulários e estados vazios.
- Rotas principais do produto criadas para navegação do protótipo.
- Telas completas iniciais:
  - `/dashboard` — Visão Geral operacional.
  - `/central-lexos` — Central LEX.OS com módulos simulados.

## Segunda rodada de refinamento do MVP v1A

Nesta rodada, as telas secundárias deixaram de usar placeholders genéricos e passaram a apresentar módulos demonstrativos com linguagem jurídica executiva e dados integralmente fictícios:

- `/clientes` — carteira com cards de clientes, tipo, status, responsável, último contato, pendência principal, processo vinculado e ação sugerida.
- `/processos` — carteira processual com número do processo, cliente, área jurídica, fase, responsável, prazo interno, prazo fatal, risco e próxima ação.
- `/financeiro` — visão de receita prevista, valores a receber, valores vencidos, clientes inadimplentes, parcelas próximas, cobranças pendentes e tabela financeira por contrato/processo.
- `/socios` — painel estratégico restrito com gargalos da semana, prazos urgentes, tarefas atrasadas, clientes sem retorno, financeiro vencido, carga da equipe, uso da Central LEX.OS e recomendações executivas simuladas.
- `/relatorios` — biblioteca de relatórios simulados com finalidade, público, status e botão “Gerar simulação”.
- `/configuracoes` — workspace demonstrativo com plano Intelligence, usuários mockados, perfis, permissões, assinatura padrão e co-branding.
- `/central-lexos` — botões de módulos mantidos com navegação para prompts, dossiê rápido, agentes, fluxos e playbooks.

A arquitetura atual, o visual dark premium, a identidade LEX.OS Control e o aviso discreto de protótipo demonstrativo foram preservados. Não há banco real, IA real, autenticação avançada ou integrações externas.

## Nova rodada de refinamento do MVP v1A

Esta rodada concentrou a evolução da Central LEX.OS, Tarefas, Agenda e interações simuladas para tornar o protótipo mais convincente, clicável e demonstrável, mantendo dados fictícios e sem banco, IA real ou integrações externas:

- `/relatorios` — botões “Gerar simulação” agora abrem modal com conteúdo específico por modelo: relatório financeiro da semana, relatório para cliente, relatório operacional, prazos, sócios e uso da Central LEX.OS.
- `/central-lexos` — o card de “Relatórios inteligentes” aponta para `/relatorios` com chamada clara para abrir a biblioteca de relatórios.
- `/central-lexos/prompts` — biblioteca demonstrativa refinada com busca, filtros, favoritos estratégicos, últimos acessos simulados, cards com nível e tempo economizado, prévia de prompt, exemplo de saída simulada e botão “Copiar modelo”, mantendo revisão humana obrigatória.
- `/central-lexos/dossie-rapido` — formulário visual mockado com cliente, área, fase, objetivo, urgência, resumo, documentos e saída desejada; o botão revela dossiê simulado com resumo, riscos, documentos faltantes, estratégia, próximos passos e versão humanizada.
- `/central-lexos/agentes` — cards de agentes demonstrativos com função, entrada necessária, saída simulada, momento de uso, status e modal de atuação simulada, reforçando que não substituem o advogado.
- `/central-lexos/fluxos` — fluxos guiados com etapas visuais, responsável sugerido, tempo estimado, ponto de atenção e modal de roteiro passo a passo.
- `/central-lexos/playbooks` — playbooks internos com objetivo, checklist, responsável sugerido, padrão de mensagem e checklist detalhado em modal.
- `/tarefas` — Kanban operacional com colunas “A fazer”, “Em andamento”, “Aguardando cliente”, “Revisão” e “Concluídas”, incluindo cards com cliente/processo, responsável, prioridade, prazo, status e checklist curto.
- `/agenda` — visão semanal mockada com compromissos por dia, prazos jurídicos, reuniões, follow-ups, audiências e alertas dos próximos 7 dias.

Todos os botões visíveis de simulação, prévia, roteiro e checklist usam interações locais mockadas. Nenhum dado é persistido e nenhuma integração real foi adicionada.

## Regras do protótipo

Este MVP não usa banco real, autenticação real avançada, IA real ou integrações externas. Todas as respostas, métricas e entidades são demonstrativas.

## Scripts

```bash
npm install
npm run dev
npm run typecheck
npm run build
```

## Rodada de refinamento funcional simulado

Esta rodada transformou elementos antes majoritariamente decorativos em interações demonstrativas locais, preservando a arquitetura atual, a identidade premium dark navy/gold/silver/off-white, os dados mockados e a ausência de banco, autenticação real, IA real ou integrações externas:

- `/dashboard` — a Visão Geral passou a funcionar como central de comando clicável, com cards de indicadores acionáveis para processos ativos, prazos urgentes, tarefas pendentes, tarefas atrasadas, valores a receber, valores vencidos, clientes sem retorno e uso da Central LEX.OS.
- Cards de indicadores — cada card abre modal premium com explicação operacional, itens mockados relacionados, risco/prioridade, próxima ação sugerida e botão para navegar ao módulo correspondente.
- Hoje no Escritório — cada compromisso abre detalhes simulados com horário, tipo, cliente/processo vinculado, responsável, prioridade, próxima ação, botão “Ver Agenda” e botão “Ver Processo” quando aplicável.
- Alertas Inteligentes — cada alerta passou a abrir painel com categoria, explicação do risco, ação recomendada, mensagens humanizadas para cliente/financeiro, botão “Copiar sugestão” e navegação para o módulo relacionado.
- Agenda da Semana — cada dia recebeu conteúdo diferente, destaque operacional, tipo principal e modal com audiências, reuniões, prazos internos, prazos fatais, follow-ups, financeiro e revisão de peça, além de ação “Abrir Agenda”.
- Busca global — a topbar agora aceita digitação, pesquisa uma base demonstrativa centralizada de clientes, processos, tarefas, agenda, financeiro, prompts, dossiê rápido, agentes, fluxos, playbooks, relatórios e módulos da Central LEX.OS, agrupando resultados por tipo e exibindo empty state elegante.
- Notificações — o contador reflete notificações não lidas em estado local e abre painel funcional com prazo urgente, cliente sem retorno, honorários vencidos, dossiê sugerido e tarefa atrasada, incluindo prioridade visual, tempo simulado, ação de navegação e marcação como lida.
- Menu de perfil — o nome da usuária abre menu com Perfil, Workspace, Assinatura padrão, Preferências e Sair da demonstração; os painéis exibem dados mockados editáveis apenas em estado local.
- Botões internos — a Central LEX.OS ganhou prévias simuladas, botões de geração, cópia de output mockado, loading curto, toast e navegação para Biblioteca de Prompts, Dossiê Rápido, Agentes LEX.OS, Fluxos Guiados, Playbooks e Relatórios.
- Relatórios — cada card “Gerar simulação” agora exibe loading visual e abre uma prévia específica com título, finalidade, público, resumo executivo, principais alertas, próximos passos sugeridos, botão “Copiar relatório” e botão “Fechar”.
- Feedbacks — foram adicionados toasts locais para “copiado”, “simulação gerada”, “notificação marcada como lida” e “perfil atualizado na demonstração”.
- Previews/outputs mockados — todos os outputs continuam fictícios, locais e revisáveis, reforçando o caráter demonstrativo do MVP v1A.


## Hotfix UX — Login com mostrar/ocultar senha

- A tela `/login` recebeu um controle integrado ao campo de senha para alternar entre senha oculta e visível antes do envio.
- O ajuste é apenas de experiência de uso: a autenticação Supabase, o modo demonstração, variáveis de ambiente e schema Supabase permanecem inalterados.

## Hotfix pré-Etapa 2B — Configurações demonstrativas

A tela `/configuracoes` foi lapidada para funcionar como área demonstrativa de personalização do sistema LEX.OS Control antes da entrada em login/workspace real:

- Workspace e Acessos agora são áreas clicáveis com seção ativa evidente, conteúdo interno útil e feedback visual premium.
- Workspace permite edição local/mockada de nome do escritório, plano atual, co-branding, assinatura padrão, identidade operacional e preferências visuais básicas.
- Acessos apresenta usuários fictícios com cargo, perfil, descrição de acesso, status, expansão de detalhes e alteração simulada de perfil em estado local.
- Os botões “Salvar alterações demonstrativas” e “Salvar permissões demonstrativas” exibem toasts locais, sem persistência real.
- Permanece sem autenticação real, sem CRUD real, sem conexão Supabase real e sem persistência em banco.
- A fundação Supabase da Etapa 2A foi preservada e a tela fica preparada para validações de UX/permissões antes da Etapa 2B.

## Etapa 2A — Fundação Supabase controlada

Status: fundação técnica criada para preparar dados reais/controlados em Supabase sem substituir o MVP visual premium salvo na release `v1.0.0-mvp-premium`.

O projeto permanece em **Next.js App Router** (`src/app`) e os dados demonstrativos continuam preservados em `src/data/mock.ts`. As telas existentes, rotas, identidade dark navy/gold/silver/off-white, Dashboard, Busca, Notificações, Perfil, Modais e Central LEX.OS não foram redesenhados nesta etapa.

### Auditoria técnica da Etapa 2A

- Roteamento: o projeto usa Next.js App Router em `src/app`, sem pasta `pages`.
- Mocks atuais: a base demonstrativa permanece centralizada em `src/data/mock.ts`, com alguns mocks locais preservados diretamente em páginas como Agenda e Tarefas.
- Componentes/páginas candidatos a dados reais nas próximas etapas: Dashboard, Clientes, Processos, Tarefas, Financeiro, Agenda, Topbar/busca, Notificações, Perfil/Workspace e Central LEX.OS.
- Limite desta etapa: nenhuma tela foi convertida integralmente para CRUD real; a prioridade foi criar fundação segura, schema, clients e camada de dados com fallback.

### O que foi adicionado

- Dependências oficiais planejadas para Supabase com Next.js/App Router:
  - `@supabase/supabase-js`
  - `@supabase/ssr`
- Clientes Supabase separados para browser e server em `src/lib/supabase`.
- Tipos iniciais do banco em `src/lib/supabase/types.ts`.
- Schema inicial em `supabase/schema.sql` com tabelas mínimas:
  - `workspaces`
  - `profiles`
  - `clients`
  - `processes`
  - `tasks`
  - `financial_records`
  - `calendar_events`
  - `activity_logs`
- RLS habilitado em todas as tabelas e políticas iniciais por workspace/perfil autenticado.
- Camada inicial de data access em `src/lib/data` para alternar futuramente entre mocks e Supabase real, mantendo fallback mockado.

### Configuração Supabase local

1. Crie um projeto no Supabase.
2. No SQL Editor do Supabase, execute o arquivo:

```bash
supabase/schema.sql
```

3. Copie o exemplo de variáveis:

```bash
cp .env.example .env.local
```

4. Preencha apenas chaves públicas no `.env.local`:

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
```

> Nunca commite `.env.local`, chaves reais ou `chave administrativa do Supabase`. A chave `chave administrativa do Supabase` não deve ser usada no frontend.

### Variáveis

Obrigatórias para conexão real com Supabase:

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
```

Opcional para testes controlados de data access no servidor:

```bash
LEXOS_DATA_SOURCE=supabase
NEXT_PUBLIC_LEXOS_DATA_SOURCE=supabase
```

`NEXT_PUBLIC_LEXOS_DATA_SOURCE` é uma indicação pública e segura para o client-side; configure na Vercel com valor `supabase` quando quiser que o navegador também leia a preferência de data source. Sem sessão Supabase real com workspace resolvido, ou sem variáveis Supabase válidas, a camada de dados retorna os mocks existentes.

### Comandos

```bash
npm install
npm run typecheck
npm run build
npm run lint
git diff --check
```

### Avisos de segurança

- `.env.local` não deve ser commitado.
- Não usar `chave administrativa do Supabase` no frontend.
- As políticas RLS desta etapa exigem usuário autenticado e associação a workspace.
- A escrita ainda será refinada na Etapa 2B por papéis operacionais (`sócio`, `advogado`, `financeiro`, `atendimento`).
- Nenhuma IA real, n8n, tribunal, Gmail, Google Calendar ou integração externa foi conectada nesta etapa.

### Próximos passos — Etapa 2B

- Definir fluxo de autenticação/onboarding e criação de perfil inicial.
- Refinar permissões por papel e revisar políticas de escrita.
- Migrar gradualmente páginas selecionadas para usar a camada de data access.
- Adicionar seeds controlados para ambiente de demonstração.
- Criar CRUD real em módulos prioritários mantendo mocks como fallback seguro.

## Etapa 2B — Login, Workspace e Perfil inicial em modo funcional controlado

Status: porta de entrada funcional criada para a LEX.OS Control, mantendo o MVP premium e os mocks preservados. A etapa adiciona sessão demonstrativa local, workspace inicial e permissões estruturadas sem exigir banco real, IA real ou integrações externas.

### Rota de entrada

A rota pública de acesso é:

```bash
/login
```

A tela mantém a identidade dark navy/gold/silver/off-white, apresenta o contexto jurídico-operacional do ambiente demonstrativo e oferece duas ações:

- **Entrar**: fluxo preparado para Supabase Auth real, sem quebrar quando as variáveis públicas não estão configuradas.
- **Entrar na demonstração**: inicia uma sessão local mockada e redireciona para `/dashboard`.

### Modo demonstração

O botão **Entrar na demonstração** cria uma sessão local no navegador com:

- Usuária: `Dra. Helena Moraes`
- E-mail: `helena.demo@lexos.local`
- Cargo: `Sócia/Gestora`
- Escritório: `Moraes, Brito & Associados`
- Perfil: `socio`
- Workspace mockado: `workspace-demo-moraes-brito`
- Plano: `Intelligence`
- Status: `demo`
- Co-branding: `LEX.OS Control + Workspace do Escritório`

A sessão é demonstrativa, fictícia e armazenada apenas em `localStorage` para fins de MVP. Ela pode ser encerrada no menu de perfil em **Sair da demonstração**, que limpa a sessão local e retorna para `/login`.

### Proteção demonstrativa das rotas internas

As rotas internas principais reconhecem a sessão demo/local de forma client-side para não quebrar build estático ou deploy sem Supabase real:

- `/dashboard`
- `/clientes`
- `/processos`
- `/tarefas`
- `/agenda`
- `/financeiro`
- `/relatorios`
- `/central-lexos`
- `/configuracoes`
- `/socios`
- `/minha-semana`

Sem sessão local, o acesso é redirecionado para `/login`. Esta proteção ainda não substitui autenticação real, RLS ou middleware definitivo.

### Permissões demonstrativas

A camada `src/lib/auth` estrutura os perfis iniciais para as próximas etapas:

- `socio`: dashboard, clientes, processos, tarefas, agenda, financeiro, relatorios, central_lexos, configuracoes, painel_socios.
- `advogado`: dashboard, clientes, processos, tarefas, agenda, central_lexos.
- `financeiro`: dashboard, financeiro, relatorios, clientes.
- `atendimento`: dashboard, clientes, tarefas, agenda, central_lexos.

A tela `/configuracoes` continua local/mockada e agora exibe permissões por perfil como preparação para regras reais na Etapa 2C/2D.

### Supabase Auth preparado, mas opcional

O login por e-mail/senha verifica se existem:

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
```

Sem essas variáveis, o fluxo informa que Supabase Auth ainda não está configurado e mantém a demonstração local disponível. Nenhuma chave real foi adicionada, `.env.local` não deve ser commitado e `chave administrativa do Supabase` nunca deve ser usado no frontend.

### Próximos passos sugeridos

- Transformar a proteção demonstrativa em estratégia real com Supabase Auth e middleware/controladores adequados.
- Associar perfis reais aos registros em `profiles` e validar permissões contra RLS.
- Criar onboarding real de workspace sem remover mocks.
- Definir seeds controlados para demonstração e testes.
- Migrar módulos prioritários para CRUD real mantendo fallback mockado seguro.

## Etapa 2C — Clientes funcional/controlado em modo demo

Status: o módulo `/clientes` agora possui CRUD demonstrativo completo para operação controlada do MVP, preservando o visual premium dark navy/gold/silver/off-white, os mocks existentes e a preparação para Supabase futuro.

### O que mudou em Clientes

- Listagem funcional da carteira por workspace demonstrativo.
- Busca por nome, documento, responsável, segmento ou pendência principal.
- Filtros por status: `ativo`, `atenção`, `prospect` e `inativo`.
- Cadastro via painel premium com validação mínima de Nome/Razão social, documento, responsável e pendência principal.
- Edição de dados cadastrais e operacionais do cliente.
- Detalhes com dados principais, responsável, status, pendência, próxima ação, último contato e observações.
- Vínculos demonstrativos com processos e tarefas mockados quando o nome do cliente coincide com os mocks atuais.
- Arquivamento não destrutivo: o botão **Arquivar cliente** muda o status para `inativo` em vez de excluir definitivamente o registro.
- Feedback visual de carregamento/salvamento e toasts locais para cadastro, atualização e arquivamento.

### Persistência local demonstrativa

Os clientes criados ou alterados são salvos no `localStorage` do navegador com chave por `workspace_id` da sessão demo atual. Isso permite demonstrar continuidade local durante o MVP, mas não representa segurança, sincronização, backup, multiusuário ou persistência real de produção.

Sem sessão disponível, o módulo usa o fallback seguro do workspace demonstrativo `workspace-demo-moraes-brito`. Se não houver dados locais, a carteira inicial é derivada dos mocks preservados em `src/data/mock.ts`.

### Supabase preparado, ainda não obrigatório

A camada `src/lib/data/clients.ts` foi estruturada com modelo útil para ativação futura de Supabase real, mas nesta etapa permanece em modo `demo_local`. O build e a interface não dependem de Supabase real, chaves públicas, autenticação ativa ou banco remoto.

### Avisos de segurança

- Não foi criado `.env.local`.
- Nenhuma chave real foi adicionada.
- `chave administrativa do Supabase` não deve ser usado no frontend nem nesta camada demonstrativa.
- `localStorage` é usado apenas para demonstração controlada, não para segurança real.
- Erros ou ausência de Supabase não devem quebrar a UI do MVP.
- Nenhuma IA real, Gmail, Google Calendar, n8n, tribunal ou integração externa foi conectada.

### Próximos passos sugeridos

- Criar adapter real Supabase para `clients` com RLS por workspace e permissões por perfil.
- Adicionar histórico de interações e timeline do cliente.
- Vincular processos/tarefas por `client_id` real em vez de correspondência por nome mockado.
- Sincronizar busca global com um repositório compartilhado de dados quando a persistência real estiver ativa.
- Adicionar testes automatizados de formulário e filtros quando a suíte de testes for definida.



## Hotfix transversal — Cards operacionais clicáveis

Status: Clientes, Processos, Agenda e Financeiro receberam o mesmo padrão operacional de cards clicáveis usado em `/tarefas`.

- Indicadores de Clientes filtram a carteira por ativos, atenção, prospects e inativos, mantendo busca textual e abertura de detalhes.
- Indicadores de Processos filtram ativos, atenção, prazos próximos, risco alto/crítico, suspensos e arquivados, mantendo arquivados fora da visão principal.
- Agenda ganhou camada demonstrativa local e filtros por hoje, semana, audiências, reuniões, prazos, follow-ups e eventos passados, com modal premium de detalhe.
- Financeiro ganhou filtros clicáveis para valores a receber, inadimplentes, receita prevista, parcelas próximas, cobranças pendentes e vencidos, com modal premium de detalhe financeiro.
- Agenda e Financeiro continuam demonstrativos, sem Google Calendar, bancos, PIX, boleto, Supabase real ou integrações externas.
- Dados seguem locais/mockados e Supabase real continua preparado, mas não obrigatório.

## Etapa 2E — Tarefas funcional/controlado em modo demo

Status: o módulo `/tarefas` passou a operar como CRUD demonstrativo controlado, preservando o visual premium dark navy/gold/silver/off-white e sem exigir Supabase real.

### O que foi entregue

- Página `/tarefas` funcional com cabeçalho premium, resumo operacional, busca textual, filtros por status, prioridade, responsável e tipo.
- Cadastro, edição, detalhes, conclusão, reabertura e arquivamento não destrutivo de tarefas.
- Modelo `Task` estruturado para escritório de advocacia com vínculo opcional a cliente e processo.
- Persistência local demonstrativa via `localStorage`, segmentada por `workspace_id` da sessão demo quando disponível.
- Fallback de mocks preservado para manter o MVP demonstrável sem banco real.
- Seleção de cliente e processo usando as camadas locais/demo de Clientes e Processos; ao selecionar cliente, a lista de processos prioriza processos daquele cliente.
- Busca global preparada para reconhecer tarefas locais e abrir `/tarefas?taskId=ID`.
- Detalhe de processo passou a mostrar tarefas vinculadas por `process_id` quando existirem, com fallback textual demonstrativo.

### Regras de visibilidade

- A visão padrão de tarefas mostra apenas tarefas operacionais: `a_fazer`, `em_andamento`, `aguardando`, `em_revisao` e tarefas vencidas calculadas como `atrasada`.
- Tarefas `concluida` aparecem apenas no filtro específico de concluídas ou nos indicadores.
- Tarefas `arquivada` aparecem apenas no filtro específico de arquivadas.
- A busca textual respeita a visão/filtro atual e não traz arquivadas por padrão.
- Arquivar marca o registro como `arquivada` e registra `archived_at`; não há exclusão destrutiva como padrão.

### Segurança e limitações

- O armazenamento local é somente demonstração, sem segurança real, sincronização, auditoria definitiva ou garantia multiusuário.
- Nenhuma chave real foi adicionada, nenhum `.env.local` foi criado e `chave administrativa do Supabase` não deve ser usado.
- Supabase real continua preparado para etapa futura, mas não é obrigatório para build, lint ou uso demonstrativo.
- Não há conexão com IA real, tribunais, PJe, e-SAJ, Projudi, Gmail, Google Calendar, n8n ou integrações externas.

### Hotfix funcional da Etapa 2E

- Tarefas criadas localmente e vinculadas por `client_id` agora aparecem no painel de detalhes do cliente correspondente.
- Cards/filtros de tarefas passaram a ser atalhos operacionais clicáveis para operacionais, concluídas, prazo vencido, aguardando validação, prioridade máxima e arquivadas.
- Tarefas arquivadas têm filtro próprio e continuam fora da visão operacional padrão.
- A persistência segue local/demo em `localStorage`, sem Supabase real obrigatório.

### Próximos passos sugeridos

- Migrar `tasks` para Supabase com RLS validada por workspace/perfil.
- Criar histórico/auditoria real de alterações de tarefas.
- Conectar tarefas a agenda/prazos reais somente após validação de segurança e consentimento operacional.
- Exibir tarefas vinculadas também na página específica de cliente quando essa tela deixar de ser placeholder.

## Etapa 2D — Processos funcional/controlado em modo demo

Status: o módulo `/processos` agora está funcional para demonstração controlada do LEX.OS Control, com CRUD local, vínculo com Clientes e preparação para ativação futura de Supabase real.

### O que mudou em Processos

- Listagem funcional de processos por `workspace_id` da sessão demonstrativa atual.
- Busca por número, cliente, parte contrária, responsável, tese/assunto e próxima pendência operacional.
- Filtros por status, risco, área e responsável.
- Indicadores operacionais de processos ativos, processos em atenção, prazos próximos e risco alto/crítico.
- Cadastro via painel premium com seleção obrigatória de cliente existente.
- Edição de dados processuais, incluindo fase, status, risco, prioridade, responsável, parte contrária, prazo, próxima ação, assunto principal e observações.
- Detalhes do processo com leitura rápida de número, cliente vinculado, tribunal/órgão, jurisdição, área, fase, status, risco, prioridade, prazo, próxima ação e notas.
- Vínculos demonstrativos com tarefas, agenda e financeiro, sinalizados como mockados até ativação dos dados reais.
- Arquivamento não destrutivo: o botão **Arquivar processo** muda o status para `arquivado` e registra `archived_at` em vez de excluir o registro.
- Feedback visual de carregamento/salvamento e toasts locais para cadastro, atualização e arquivamento.

### Vínculo demonstrativo com Clientes

Ao criar ou editar um processo, o formulário carrega clientes da camada local/demo de `/clientes`. O processo salva `client_id` e `client_name`, permitindo que o detalhe do cliente mostre processos vinculados localmente quando houver correspondência por `client_id`.

Se não houver cliente disponível no workspace demonstrativo, a interface exibe o aviso: “Cadastre um cliente antes de vincular novos processos.” O módulo não quebra e mantém o fluxo controlado.

### Persistência local demonstrativa

Os processos criados, editados ou arquivados são salvos em `localStorage` com chave por `workspace_id` da sessão demo. Essa persistência é apenas para demonstração do MVP: não oferece segurança real, sincronização multiusuário, backup, auditoria ou isolamento de produção.

Sem sessão disponível, o módulo usa o fallback seguro do workspace demonstrativo `workspace-demo-moraes-brito`. Sem dados locais, a carteira inicial é derivada dos mocks preservados em `src/data/mock.ts`.

### Supabase preparado, ainda não obrigatório

A camada `src/lib/data/processes.ts` usa um modelo de dados compatível com uma futura troca entre `demo_local` e Supabase real, mas nesta etapa permanece sem conexão obrigatória com banco. O build e a interface continuam funcionando sem `.env.local`, sem chaves públicas, sem autenticação real e sem Supabase remoto.

### Busca global

A busca global continua usando a base mockada existente e agora também reconhece processos criados ou editados localmente no navegador, exibindo a ação “Abrir processo”.

### Avisos de segurança

- Não foi criado `.env.local`.
- Nenhuma chave real foi adicionada.
- Nenhuma chave `chave administrativa do Supabase` foi usada.
- `localStorage` é apenas persistência demonstrativa e não deve ser tratado como segurança real.
- Nenhuma IA real, tribunal, PJe, e-SAJ, Projudi, Gmail, Google Calendar, n8n ou integração externa foi conectada.
- Erros ou ausência de Supabase não impedem a UI demonstrativa de funcionar.

### Próximos passos sugeridos

- Migrar `processes` para Supabase real com RLS por workspace e permissões por perfil.
- Criar detalhes reais em `/processos/[id]` com deep link para processos específicos.
- Substituir vínculos mockados de tarefas, agenda e financeiro por relações reais controladas.
- Implementar auditoria de alterações e timeline processual.
- Adicionar testes automatizados para camada local/demo e validações do formulário.

### Hotfix Etapa 2D — abertura direta e arquivados

- A busca global agora envia resultados de processos para `/processos/[id]`, abrindo o processo específico pelo `id` local/demo em vez de navegar apenas para a lista geral.
- A visão principal de `/processos` oculta processos com status `arquivado` por padrão; eles aparecem somente quando o filtro de status está explicitamente em `arquivado`.
- O arquivamento continua não destrutivo, persiste em `localStorage` no modo demo e não altera a preparação futura para Supabase real.

## Etapa 2F — Agenda e Prazos funcional/controlada

A Etapa 2F transforma `/agenda` em um módulo operacional demonstrativo para compromissos, prazos, audiências, reuniões e follow-ups, mantendo a identidade premium dark navy/gold/silver/off-white e sem refazer o design global.

- A Agenda agora possui CRUD demonstrativo de compromissos próprios com criação, edição, detalhe, conclusão, remarcação, cancelamento e arquivamento não destrutivo.
- Os registros próprios seguem persistidos em `localStorage` por workspace demo e usam mocks como fallback inicial.
- A visão de Agenda combina eventos próprios, tarefas com `due_at` e processos com `next_deadline_at`, identificando discretamente a origem como “Evento”, “Tarefa” ou “Prazo processual”.
- Itens derivados de tarefas/processos são exibidos em detalhe, mas a edição direta fica bloqueada para evitar divergência; a alteração do prazo deve ocorrer na origem.
- Os cards de Hoje, Esta semana, Prazos, Audiências, Reuniões, Follow-ups, Concluídos e Arquivados/Cancelados aplicam filtros operacionais.
- A busca global passa a incluir resultados de agenda com deep link para `/agenda?eventId=ID`, abrindo o detalhe quando possível.
- Cards/ações seguros do Dashboard direcionam para `/agenda?view=hoje` ou `/agenda?view=semana`.

### Segurança e integrações

- Google Calendar real ainda **não** está conectado.
- Supabase real ainda **não** é obrigatório para a Agenda.
- Não há Gmail, PJe, tribunais, n8n, IA real, automações externas, chaves reais ou `chave administrativa do Supabase`.
- Não criar `.env.local` para testar esta etapa; o MVP deve continuar funcionando em modo local/demo.
- Os dados demonstrativos no navegador não devem ser usados para informação sensível, jurídica real ou produção.

### Próximos passos sugeridos

1. Criar tabela/edge policies definitivas de agenda no Supabase com RLS por workspace.
2. Definir conector assíncrono para Google Calendar com consentimento explícito por usuário.
3. Criar histórico estruturado de remarcações e trilha de auditoria por compromisso.
4. Unificar notificações internas de prazos com tarefas, processos e agenda.
5. Adicionar testes automatizados de filtros, deep links e operações locais.

### Hotfix Etapa 2F — cards acionáveis e modais seguros

- Os quatro cards superiores da Agenda — Operacionais, Risco máximo, Itens derivados e Modo — agora são clicáveis/acionáveis, com hover premium e estado ativo quando aplicam filtro.
- O painel/modal da Agenda foi ajustado para permanecer dentro da viewport, com cabeçalho e botão **Fechar** sempre acessíveis e corpo interno rolável.
- A Agenda permanece em modo local/demo, sem Google Calendar real, sem Supabase real, sem integrações externas, sem `.env.local` e sem `chave administrativa do Supabase`.

## Etapa 2G — Financeiro funcional/controlado em modo demo

Status: módulo **Financeiro** convertido de visão demonstrativa para operação controlada em `/financeiro`, preservando o design premium dark navy/gold/silver/off-white e sem exigir Supabase real para build ou uso local.

### O que foi entregue

- `/financeiro` agora possui CRUD demonstrativo de lançamentos/cobranças financeiras com persistência em `localStorage`.
- A estrutura `FinancialRecord` foi ampliada para workspace, cliente, processo, tarefa/agenda futuros, tipo, direção, status, valor, vencimento, pagamento, parcelas, responsável, forma demonstrativa, categoria, próxima ação e observações.
- Cards financeiros clicáveis e funcionais:
  - Valores a receber;
  - Valores vencidos;
  - Clientes inadimplentes;
  - Receita prevista;
  - Parcelas próximas;
  - Cobranças pendentes;
  - Recebidos no mês;
  - Arquivados/Cancelados.
- Busca textual e filtros por status, tipo, direção, responsável, período e cliente continuam combináveis com o card ativo.
- Novo lançamento/cobrança abre formulário premium com vínculo a cliente e processo existentes; ao escolher cliente, os processos são priorizados para aquele cliente.
- Detalhe financeiro exibe dados operacionais e permite editar, marcar como pago, reabrir cobrança, remarcar vencimento, cancelar e arquivar sem exclusão destrutiva.
- Ações de pagamento, reabertura, remarcação, arquivamento e cancelamento atualizam a lista imediatamente e emitem toast demonstrativo.
- Busca global passou a incluir registros financeiros locais e abre diretamente `/financeiro?financeId=ID`.
- Cards financeiros do Dashboard navegam para `/financeiro` com filtro contextual quando seguro.

### Limites e segurança

- Os dados continuam locais/demo, salvos apenas no navegador.
- Não há integração bancária real.
- Não há PIX real, boleto real, gateway, Asaas, Stripe, Mercado Pago ou API financeira externa.
- Supabase real permanece preparado para etapa futura, mas não é obrigatório.
- Nenhuma chave real deve ser usada no frontend; não usar `chave administrativa do Supabase`.
- `.env.local` não deve ser versionado.
- Cancelar/arquivar não exclui definitivamente registros; apenas altera status demonstrativo.

### Pendências seguras para próximas etapas

- Exibir carteira financeira resumida dentro do detalhe real de Cliente quando essa tela deixar de ser placeholder.
- Exibir registros financeiros dentro do detalhe real de Processo quando a tela de detalhe aceitar composição adicional com segurança.
- Criar adapter Supabase para `financial_records` mantendo fallback local/demo.
- Definir trilha de auditoria/histórico de pagamentos parciais antes de integrações reais.
- Só depois de validação jurídica, operacional e de segurança: avaliar PIX, boleto, conciliação ou gateway em ambiente isolado.

### Hotfix Etapa 2G — status financeiro e modal seguro

- Os status **pendente** e **aguardando** foram separados conceitualmente: pendente exige ação ativa do escritório; aguardando indica retorno, pagamento, comprovante ou confirmação externa já solicitada.
- Os filtros específicos de status agora respeitam o status exato selecionado, sem sobrepor pendente e aguardando.
- Cards agrupadores como **Valores a receber** continuam podendo consolidar previstos, pendentes e aguardando quando fizer sentido; **Cobranças pendentes** foi mantido focado em registros `pendente`.
- O modal financeiro foi ajustado para permanecer dentro da viewport, com cabeçalho e botão **Fechar** sempre acessíveis e corpo interno rolável.

## Etapa 2H — Relatórios operacionais reais/demo em modo local

Status: `/relatorios` deixou de ser apenas biblioteca estática e passou a gerar relatórios operacionais demonstrativos com base nos dados locais/demo dos módulos internos da LEX.OS Control.

### O que foi entregue

- `/relatorios` agora consolida dados demo/local de:
  - Clientes;
  - Processos;
  - Tarefas;
  - Agenda/Prazos;
  - Financeiro.
- Foi criada uma camada local de relatórios em `src/lib/data/reports.ts`, com modelo `Report`, `ReportSection`, métricas, geração determinística em português, texto markdown copiável e histórico em `localStorage` por `workspace_id`.
- Modelos clicáveis implementados:
  - Sócios/Gestores;
  - Operacional semanal;
  - Operacional mensal;
  - Financeiro;
  - Cliente;
  - Carteira de processos;
  - Tarefas e prazos;
  - Inadimplência/Cobrança;
  - Personalizado/demo.
- A página inclui indicadores rápidos, filtros por tipo, público, período, cliente, processo e responsável, botão **Gerar relatório**, preview premium e histórico local.
- O preview mostra título, tipo, público, período, data de geração, resumo executivo, indicadores, seções, pontos de atenção, próximas ações e aviso discreto de dados locais/demo.
- O relatório gerado pode ser copiado para a área de transferência e baixado em `.md`, sem PDF/Word e sem dependências pesadas.
- O histórico local lista relatórios gerados, permite abrir, copiar e arquivar sem exclusão destrutiva; arquivados ficam fora da lista principal e podem ser vistos pelo filtro **Arquivados**.
- Relatórios de cliente usam vínculos por `client_id` quando disponíveis em processos, tarefas, agenda e financeiro; quando não há vínculo, exibem estado vazio elegante sem inventar dados.
- Relatórios financeiros respeitam a leitura operacional de status:
  - `pendente`: exige ação ativa do escritório;
  - `aguardando`: depende de retorno/pagamento/confirmação externa;
  - `previsto`: vencimento futuro planejado;
  - `vencido`: vencimento passado não pago/cancelado/arquivado;
  - `pago`: recebido/quitado.
- A busca global passa a incluir relatórios gerados localmente e abre `/relatorios?reportId=ID` quando possível.

### Limites e segurança

- A geração é determinística e local; não há IA real.
- Os dados continuam locais/demo, salvos apenas no navegador por `localStorage`.
- Supabase real permanece opcional e não é obrigatório para `/relatorios`.
- Não há Gmail, Google Calendar, PJe, tribunais, n8n, bancos, PIX, boleto, PDF externo ou integração externa.
- Nenhuma chave real foi adicionada e nenhuma chave `chave administrativa do Supabase` deve ser usada.
- Não criar `.env.local` para esta etapa; o MVP precisa continuar funcionando sem banco real.
- Os relatórios trazem aviso discreto: “Relatório demonstrativo gerado com dados locais do MVP.”

### Próximos passos sugeridos

- Criar adapter Supabase para `reports` com RLS por workspace quando a persistência real for ativada.
- Adicionar tela de detalhe dedicada para relatórios arquivados e auditoria de alterações.
- Integrar cards específicos do Dashboard a `/relatorios?type=...` após validação de UX com os atalhos existentes.
- Evoluir exportação para PDF/Word apenas após definição de template, segurança e dependências leves.
- Adicionar testes automatizados para geração determinística, filtros por cliente/processo e histórico local.

## Etapa 2I — Parcerias de Processos em modo funcional/controlado

Status: módulo demonstrativo de **Parcerias de Processos** criado e vinculado ao fluxo de Processos, com persistência local via `localStorage`, dados fictícios e preparação para futura alternância controlada com Supabase.

### Nova área

- Rota criada: `/processos/parcerias`.
- A tela `/processos` agora oferece acesso visual para **Parcerias**, sem promover o módulo para item principal da sidebar.
- O detalhe de processo passa a exibir parcerias vinculadas por `process_id` e links para abrir o módulo de parcerias filtrado ou abrir uma parceria específica.

### Funcionalidades demonstrativas

- CRUD local de parcerias jurídicas com campos de parceiro, escritório, contato, OAB demonstrativa, cliente, processo, tipo, status, modelo de honorários, percentuais, valores previstos/pagos, responsáveis, datas, pendência, próxima ação e observações.
- Cards superiores clicáveis para: parcerias ativas, em negociação, aguardando documento, aguardando repasse, concluídas e arquivadas.
- Busca por parceiro, escritório, cliente, processo, status, pendência e próxima ação.
- Filtros por status, tipo de parceria, responsável interno e modelo de honorários.
- Modal/painel premium para cadastro, edição e detalhes, com botão **Fechar** sempre disponível e rodapé de ações acessível.
- Registro de **repasse demonstrativo** apenas local, atualizando `paid_amount` e sugerindo/aplicando conclusão quando o valor cobre `expected_amount`.
- Arquivamento não destrutivo: a parceria recebe status `arquivada` e `archived_at`, saindo da visão principal e aparecendo no filtro de arquivadas.
- Busca global da Topbar passa a incluir resultados de parcerias e abre `/processos/parcerias?partnershipId=ID`.

### Integrações preservadas/controladas

- Clientes e Processos: vínculos por `client_id` e `process_id` usando os cadastros locais/demo existentes.
- Financeiro: resumo financeiro interno da parceria e registro local de repasse demonstrativo, sem criar pagamento real, recibo, boleto ou integração bancária.
- Tarefas e Agenda: a próxima ação da parceria fica visível no detalhe; criação automática de tarefas/compromissos permanece como próximo passo para evitar risco aos módulos existentes.
- Relatórios: relatórios de sócios, operacional semanal, cliente e indicadores rápidos passam a considerar parcerias ativas, em negociação, aguardando repasse, pendências e valores demonstrativos quando disponíveis.

### Limites e segurança

- Sem pagamento real.
- Sem integração bancária.
- Sem dados reais de advogado, cliente, OAB ou processo.
- Sem IA real.
- Sem Gmail, WhatsApp, Google Calendar, tribunais, PJe, n8n ou integrações externas.
- Sem exigência de banco real ou Supabase configurado.
- Dados seguem em mocks e `localStorage` demonstrativo.
- Nenhum `.env.local`, segredo, chave real ou `chave administrativa do Supabase` deve ser criado ou commitado.

### Próximos passos sugeridos

- Criar schema Supabase para `process_partnerships` com RLS por `workspace_id` e papéis operacionais.
- Permitir criação controlada de tarefas e eventos de agenda vinculados a parcerias após estabilizar os contratos de dados dos módulos.
- Avaliar criação opcional de lançamentos financeiros locais/reais vinculados a repasses, com trilha de auditoria e permissões.
- Expandir detalhe de Cliente para exibir parcerias por `client_id` quando a tela deixar de ser placeholder.
- Adicionar testes automatizados de fluxo para cadastro, edição, repasse, arquivamento e abertura por busca global.

### Hotfix Etapa 2I — Status operacional x repasse

- O status operacional da parceria foi separado do status financeiro/repasse (`repasse_status`) para evitar tratar “Ativa” como sinônimo de repasse pago ou “Em negociação” como ausência de repasse.
- Uma parceria ativa não depende obrigatoriamente de repasse pago; ela representa parceria formalizada/em execução.
- Registrar repasse em parceria ainda “Em negociação” atualiza apenas o status de repasse e abre uma confirmação premium sugerindo marcar como ativa, sem forçar a alteração operacional.
- Os dados continuam em modo local/demo via mocks e `localStorage`, sem Supabase obrigatório, pagamento real, integração bancária ou segredo.

## Etapa 2J — Central LEX.OS operacional/demo conectada aos módulos internos

Status: a **Central LEX.OS** deixou de ser apenas vitrine visual e passou a operar como hub demonstrativo local, usando dados já existentes de Clientes, Processos, Parcerias, Tarefas, Agenda/Prazos, Financeiro e Relatórios.

### Funcionalidades entregues

- Camada `centralExecutions` para histórico local de execuções em `localStorage`, com listar, criar, buscar por ID, registrar cópia e arquivar.
- `/central-lexos` agora mostra indicadores de uso local, cards dos módulos e **Histórico de execuções** com abrir, copiar e arquivar.
- `/central-lexos/prompts` gera saídas determinísticas com seleção de cliente, processo, parceria, tarefa, financeiro e finalidade.
- `/central-lexos/dossie-rapido` consolida dados locais em seções executivas: resumo, situação atual, pontos de atenção, pendências, riscos, parcerias, impacto financeiro, próximas ações e versão humanizada.
- `/central-lexos/agentes` simula Agente de Intake, Prazos, Financeiro, Atendimento, Auditor Simples, Gestor Básico, Relatórios e Parcerias com base nos módulos internos.
- `/central-lexos/fluxos` transforma fluxos em checklists executáveis com etapas marcáveis, resumo, cópia e salvamento local.
- `/central-lexos/playbooks` transforma playbooks em manuais acionáveis com objetivo, quando usar, checklist, responsável sugerido, riscos comuns, padrão de mensagem e salvamento demonstrativo.
- Parcerias são consideradas nas saídas quando há vínculo por cliente/processo/parceria selecionada, incluindo status operacional, pendências, repasse e próxima ação.
- Dashboard reflete a contagem local de execuções da Central LEX.OS quando o card correspondente está disponível nos mocks.
- Busca global passa a incluir execuções locais da Central e abre `/central-lexos?executionId=ID`.

### Limites e segurança

- Não há IA real.
- Não há OpenAI API, Claude, Gemini ou qualquer outro provedor conectado.
- Não há Gmail, WhatsApp, n8n, tribunais, Google Calendar, bancos ou integrações externas.
- Não há exigência de Supabase real; os dados seguem mocks e `localStorage` demonstrativo.
- Nenhum `.env.local`, segredo real ou chave `chave administrativa do Supabase` deve ser criado ou utilizado.
- Toda saída gerada exibe aviso discreto de revisão humana obrigatória antes de uso externo.

### Próximos passos sugeridos

- Criar testes automatizados unitários para os geradores determinísticos da Central.
- Evoluir filtros do histórico por tipo, cliente e período quando a volumetria demonstrativa aumentar.
- Adicionar links profundos para detalhes específicos de parcerias, tarefas e financeiros quando esses módulos tiverem rotas individuais dedicadas.
- Planejar adapter Supabase com RLS por `workspace_id` somente quando a persistência real for priorizada.
- Avaliar exportação controlada para PDF/Word após estabilização de templates e permissões.

## Etapa 2K — Gerenciador de Prompts da Central LEX.OS

Status: a rota `/central-lexos/prompts` transformou a Biblioteca de Prompts em um gerenciador administrável em modo **demo/local**, preservando a identidade premium dark navy/gold/silver/off-white e sem acionar IA real, Supabase real obrigatório ou integrações externas.

### O que foi adicionado

- Botão **Novo prompt** com modal premium para cadastro completo de prompts.
- Edição de prompts existentes da biblioteca demonstrativa e de prompts criados localmente.
- Arquivamento sem exclusão definitiva, movendo o item para o status `arquivado`.
- Filtros por categoria, área jurídica, tipo, status, nível e visibilidade.
- Campo amplo para **Texto do prompt**, preparado para prompts extensos como Camaleão de Peça, Camaleão de Dossiê, Penal Pré-Processual, Peça Penal, Contrarrazões e Relatório ao Cliente.
- Histórico/versionamento simples por prompt com versão, data de atualização, responsável e observação de alteração.
- Execução demonstrativa preservada para prompts já existentes e saída genérica local para prompts novos, deixando explícito que não há IA real.
- Aviso conceitual sobre revisão de prompts estratégicos e futura execução encapsulada de conteúdos sensíveis.

### Persistência e limites atuais

- Os prompts cadastrados e editados ficam apenas em `localStorage` do navegador.
- A próxima etapa poderá conectar Supabase, permissões por workspace/perfil e persistência real.
- Prompts sensíveis ainda **não** estão protegidos por back-end real, RLS produtivo ou criptografia de aplicação nesta etapa.
- Não foi criado `.env.local`, não foi usada chave `chave administrativa do Supabase` e nenhuma automação externa foi conectada.

## Etapa 2L — Painel dos Sócios operacional/demo

Status: o Painel dos Sócios foi evoluído de uma tela estratégica demonstrativa para uma área executiva funcional em modo local/demo, consolidando informações já existentes dos módulos internos.

### O que mudou

- `/socios` agora consolida dados locais/demo de Clientes, Processos, Parcerias, Tarefas, Agenda/Prazos, Financeiro, Relatórios, Central LEX.OS e Biblioteca de Prompts.
- A página passou a ter cards executivos clicáveis para:
  - Clientes em atenção;
  - Processos de risco;
  - Tarefas atrasadas;
  - Prazos urgentes;
  - Valores vencidos;
  - Parcerias aguardando repasse;
  - Relatórios gerados;
  - Uso da Central LEX.OS.
- Cada card abre uma lista contextual dentro do próprio painel e cada item oferece ação de navegação para o módulo de origem.
- Foram adicionados filtros de período: Hoje, 7 dias, 30 dias, mês atual e todos os dados demo.
- Foi adicionado filtro por responsável usando linguagem de capacidade operacional, sem ranking negativo ou fiscalização de pessoas.
- A seção “Saúde operacional” calcula uma leitura determinística/demo com situação geral, principal gargalo, principal risco financeiro, principal risco de prazo, módulo com maior volume de pendências e recomendação da semana.
- O painel agora exibe gargalos, riscos e recomendações executivas determinísticas, sem IA real.
- Foram adicionados blocos consolidados para financeiro executivo, governança de parcerias, uso da Central LEX.OS, prompts e relatórios.
- O bloco da Central LEX.OS mostra execuções, dossiês rápidos, prompts usados, agentes simulados, fluxos, playbooks e prompts ativos; quando não houver execuções no navegador demo, o card contextual exibe estado vazio.
- O botão “Gerar relatório para sócios” navega para `/relatorios?type=socios_operacional` para manter o fluxo local/demo existente.

### Limites preservados

- Os dados continuam em mocks/localStorage demonstrativo.
- Não há IA real, OpenAI API, Gmail, WhatsApp, Google Calendar, tribunais, PJe, n8n, bancos ou integrações externas.
- Não há Supabase real obrigatório para usar o painel.
- Nenhuma chave real deve ser inserida e `.env.local` não deve ser criado ou commitado.
- `chave administrativa do Supabase` não deve ser usado no frontend.
- A linguagem do painel prioriza clareza operacional, proteção de receita e orientação de equipe, sem fiscalização individual.

### Próximos passos sugeridos

- Criar filtros de origem com deep link padronizado nos módulos para consumir query strings vindas do Painel dos Sócios.
- Persistir preferências de filtros do sócio em workspace real quando a autenticação definitiva estiver ativa.
- Conectar futuramente a mesma camada de consolidação a Supabase com RLS e permissões por perfil.
- Adicionar auditoria de eventos executivos com trilha de ação, mantendo revisão humana e governança de dados.

## Etapa 2M — Dashboard principal consolidado

Status: Dashboard `/dashboard` transformado em central executiva e operacional consolidada em modo demo/local, preservando o MVP premium dark navy/gold/silver/off-white e sem adicionar integrações externas.

### O que mudou

- `/dashboard` agora consolida dados locais/demo dos módulos Clientes, Processos, Parcerias, Tarefas, Agenda/Prazos, Financeiro, Relatórios, Central LEX.OS e Gerenciador de Prompts.
- Foi adicionada a camada `src/lib/data/dashboard.ts`, responsável por calcular indicadores determinísticos e listas contextuais a partir dos módulos já funcionais em `localStorage`/fallback demo.
- Cards principais clicáveis incluem clientes ativos, processos ativos, prazos urgentes, tarefas pendentes, tarefas atrasadas, valores a receber, valores vencidos, clientes sem retorno, parcerias aguardando repasse e uso da Central LEX.OS.
- A seção **Saúde operacional** gera status local determinístico (`Estável`, `Atenção` ou `Crítica`), principal risco, gargalo, prioridade recomendada e módulo com maior volume de pendências.
- **Hoje no escritório** consolida compromissos, prazos, tarefas urgentes e cobranças relevantes, sempre com ação para abrir o módulo relacionado.
- **Alertas inteligentes** são regras locais/demo, sem IA real, incluindo tarefas atrasadas, valores vencidos, clientes em atenção, processos de risco, parcerias pendentes, prazos próximos, baixa utilização da Central e relatório semanal não gerado.
- **Agenda da semana** usa os eventos de `/agenda` e derivados de tarefas/processos, com dias clicáveis e modal contextual seguro.
- **Financeiro rápido** usa `/financeiro` para total a receber, total vencido, receita prevista, recebidos no mês, cobranças pendentes e inadimplência.
- **Uso da Central LEX.OS** mostra execuções, prompts usados, dossiês, agentes, fluxos, playbooks e prompts ativos, com botões para abrir Central, Prompts, Dossiê Rápido e Histórico.
- **Parcerias em atenção** inclui aguardando documento, aguardando repasse, em negociação e repasse parcial, com navegação para `/processos/parcerias`.
- **Últimas atividades** são derivadas de `created_at`/`updated_at` dos módulos locais/demo quando não há `activity_logs` real.
- **Ações rápidas** navegam para rotas seguras dos módulos: novo cliente, processo, tarefa, compromisso, cobrança, parceria, relatório, dossiê rápido e prompts.

### Limites preservados

- Dados seguem em `localStorage`/fallback demonstrativo.
- Não há IA real, OpenAI API, Supabase real obrigatório, Gmail, WhatsApp, Google Calendar, tribunais, PJe, n8n, bancos ou integrações externas.
- Nenhuma chave real, `.env.local` ou `chave administrativa do Supabase` foi adicionada.
- Nenhum `alert`/`confirm` nativo foi usado; interações usam modais/toasts premium locais.

### Próximos passos sugeridos

- Fazer os módulos de destino interpretarem todos os filtros recebidos por query string do Dashboard.
- Criar `activity_logs` local estruturado para registrar ações do usuário em tempo real.
- Adicionar preferências por perfil para ordenar cards do Dashboard.
- Preparar seeds controlados para quando a camada Supabase real for ativada em ambiente seguro.

## Etapa 2N — Auditoria geral, estabilização e polimento final do MVP funcional/demo

Status: a Etapa 2N iniciou a auditoria transversal do MVP funcional/demo antes da próxima fase com Supabase real/controlado. O produto permanece em modo local demonstrativo, com visual premium dark navy/gold/silver/off-white preservado e sem mudança da identidade visual global.

### Módulos auditados nesta rodada

- Login e sessão demo (`/login`).
- Dashboard consolidado (`/dashboard`).
- Clientes (`/clientes`).
- Processos (`/processos`) e detalhe por rota local (`/processos/[id]`).
- Parcerias de Processos (`/processos/parcerias`).
- Tarefas (`/tarefas`).
- Agenda/Prazos (`/agenda`).
- Financeiro (`/financeiro`).
- Relatórios (`/relatorios`).
- Central LEX.OS (`/central-lexos`) e submódulos: Prompts, Dossiê Rápido, Agentes, Fluxos e Playbooks.
- Painel dos Sócios (`/socios`).
- Configurações (`/configuracoes`).

### Ajustes de estabilização aplicados

- A busca global de clientes locais agora navega para o item específico com `clientId`, permitindo abrir o detalhe correto em `/clientes` quando o resultado vier do `localStorage` demonstrativo.
- A base demonstrativa da busca global também passou a apontar clientes mockados para seus IDs de demonstração (`client-demo-*`), em vez de abrir somente a lista genérica.
- `/clientes` passou a interpretar `clientId`, `status` e `action=novo`, preservando a tela operacional e abrindo detalhe, filtro ou cadastro quando o usuário chega por Dashboard, Painel dos Sócios, busca global ou ação rápida.
- `/processos` passou a interpretar `processId`, `status` e `action=novo`, mantendo o filtro operacional e abrindo detalhe/cadastro demonstrativo quando o usuário chega por link profundo.
- `/tarefas` passou a interpretar `taskId`, `view` e `action=novo`, permitindo abrir a tarefa específica ou o cadastro demonstrativo a partir de busca global, Dashboard e Painel dos Sócios.
- O modal premium reutilizável (`SimulationModal`) recebeu fechamento por tecla ESC e ajuste de viewport/top spacing para reduzir risco de corte em telas menores.

### Situação funcional/local atual

- Os módulos continuam funcionais em modo local/demo com mocks e `localStorage` por workspace demonstrativo quando disponível.
- A criação local segue persistente após reload para clientes, processos, parcerias, tarefas, agenda/eventos, financeiro, relatórios, prompts e execuções da Central LEX.OS.
- Os vínculos principais entre cliente, processo, tarefa, agenda, financeiro, parceria, relatórios e Central permanecem demonstrativos e preparados para futura camada real.
- Cards e indicadores executivos que parecem acionáveis permanecem como botões/links com ação útil; quando o detalhe individual ainda depende de rota dedicada futura, o fluxo usa query string e abre o módulo com contexto demonstrativo.

### Limitações conhecidas pós-auditoria

- A persistência via `localStorage` é apenas demonstração controlada: não oferece segurança real, sincronização multiusuário, auditoria produtiva, backup ou isolamento de produção.
- Alguns vínculos exibidos em detalhes ainda são resumos demonstrativos quando o módulo de destino não possui rota individual dedicada; nesses casos, o link profundo abre o módulo com filtro/parâmetro quando disponível.
- O histórico operacional ainda não possui `activity_logs` real; o Dashboard e o Painel dos Sócios derivam atividades de dados locais e timestamps dos próprios registros.
- A próxima etapa deve padronizar todos os parâmetros de query string entre módulos antes de conectar Supabase real/controlado.

### Segurança e integrações preservadas

- Não há banco real obrigatório para usar o MVP funcional/demo.
- Não há IA real, OpenAI API ou provedor externo conectado.
- Não há Gmail, WhatsApp, Google Calendar, tribunais, bancos, PIX, boleto, n8n ou integrações externas conectadas.
- Nenhum `.env.local`, segredo real ou chave real foi adicionado.
- A menção a `chave administrativa do Supabase` neste README permanece apenas como proibição operacional; essa chave não deve ser usada no frontend nem na camada demonstrativa.
- Nenhum `alert`/`confirm` nativo foi introduzido; confirmações seguem por modais/toasts premium locais.

### Próximos passos

- Fechar release funcional demo para apresentação/teste controlado com escritório parceiro.
- Executar uma bateria manual assistida em navegador para validar todos os modais em larguras menores e capturar evidências visuais.
- Iniciar a etapa Supabase real/controlado com RLS, autenticação definitiva, seeds seguros e migração gradual dos módulos locais para adapters reais.

## Etapa 3A — Supabase real/controlado e migração progressiva

Status: fundação real/controlada iniciada sem substituir o MVP demo/local aprovado. O sistema continua abrindo sem Supabase configurado, preserva login demonstrativo, dados locais e fallback por `localStorage`, e inicia a migração apenas pelo módulo **Clientes**.

### Variáveis de ambiente

Configure valores reais somente na Vercel ou no ambiente seguro de execução. Não commite `.env.local` nem segredos no repositório.

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
LEXOS_DATA_SOURCE=demo
NEXT_PUBLIC_LEXOS_DATA_SOURCE=demo
```

Valores aceitos para `LEXOS_DATA_SOURCE` e `NEXT_PUBLIC_LEXOS_DATA_SOURCE`:

- `demo`: usa somente dados demonstrativos locais.
- `supabase`: tenta usar Supabase quando as variáveis públicas estão configuradas; caso contrário volta para demo.
- `hybrid`: tenta Supabase e cai para demo/local em erro controlado.

Nunca use chave administrativa no frontend. O app usa somente URL pública, publishable/public key do Supabase e, opcionalmente, `NEXT_PUBLIC_LEXOS_DATA_SOURCE` como flag pública sem segredo.

### Supabase preparado

A Etapa 3A adiciona/revisa:

- client browser em `src/lib/supabase/client.ts`;
- client server em `src/lib/supabase/server.ts`;
- helper de cookies em `src/lib/supabase/proxy.ts` e `proxy.ts`/middleware equivalente;
- camada controlada `src/lib/data/source.ts`;
- schema inicial em `supabase/schema.sql`;
- seed fictício opcional em `supabase/seed-demo.sql`.

### Schema inicial seguro

O schema inicial cobre apenas a base necessária para a ativação real/controlada:

- `workspaces`;
- `profiles`;
- `workspace_members`;
- `clients`;
- `activity_logs`.

Todas as tabelas têm RLS habilitada. As políticas bloqueiam leitura pública indiscriminada e condicionam leitura/escrita operacional à associação ativa do usuário ao workspace.

### Auth e sessão híbrida

A rota `/login` preserva **Entrar na demonstração** e adiciona entrada por e-mail/senha preparada para Supabase Auth. Quando Supabase não está configurado, o usuário vê a mensagem de ambiente ausente e pode seguir pela demonstração local.

A camada de sessão suporta:

- usuário e workspace demo/local;
- usuário Supabase real;
- workspace real via `workspace_members`;
- fallback seguro quando profile/workspace ainda não existem.

### Clientes como primeiro módulo híbrido

Apenas o módulo Clientes iniciou migração progressiva. A API atual foi preservada, e novas funções assíncronas tentam Supabase nos modos real/híbrido e caem para demo/local em erro controlado. Clientes arquivados recebem `archived_at` e deixam a visão principal.

Os demais módulos continuam no modo demo/local, salvo ajustes mínimos de importação para não quebrar o MVP.

### Configurações

`/configuracoes` exibe um bloco técnico discreto com:

- modo de dados efetivo;
- Supabase configurado: sim/não;
- workspace atual;
- usuário atual;
- aviso de implantação real/controlada com fallback demo.

Nenhuma chave é exibida na interface.

### Próximos passos

1. Criar o projeto Supabase.
2. Executar `supabase/schema.sql` no SQL Editor.
3. Opcionalmente executar `supabase/seed-demo.sql` para dados fictícios.
4. Configurar `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `LEXOS_DATA_SOURCE` e `NEXT_PUBLIC_LEXOS_DATA_SOURCE` na Vercel.
5. Criar usuário real em Supabase Auth.
6. Inserir manualmente `profiles` e `workspace_members` para o usuário real.
7. Testar login real e CRUD de clientes por workspace.
8. Migrar Processos, Tarefas, Agenda e Financeiro gradualmente, mantendo fallback demo/local.

## Consistência entre dados demo e Supabase real

O LEX.OS Control separa explicitamente os fluxos demonstrativos dos fluxos reais autenticados:

- **Clientes** já usa Supabase real quando Supabase está configurado, existe sessão Supabase ativa e há `workspace_id` resolvido; essa sessão real tem prioridade sobre um valor demonstrativo antigo de data source.
- **Processos**, **Tarefas**, **Agenda**, **Financeiro** e **Parcerias** não devem exibir mocks, seeds ou `localStorage` quando a sessão atual for Supabase. Enquanto suas tabelas reais ainda não estiverem aplicadas no ambiente Supabase, esses módulos exibem empty state premium em vez de dados demonstrativos.
- Os dados demo/localStorage aparecem somente ao entrar por **“Entrar na demonstração”** ou quando o ambiente não está configurado para Supabase real.
- Não deve haver mistura entre registros demo e registros reais na mesma sessão autenticada. Se uma consulta Supabase real falhar ou a tabela real ainda não existir, o app retorna estado vazio/controlado para aquele módulo em vez de preencher a tela com mocks.
- Vínculos operacionais previstos para a próxima etapa de Supabase real:
  - cliente ↔ processo (`processes.client_id`)
  - processo/cliente ↔ tarefa (`tasks.process_id`, `tasks.client_id`)
  - cliente/processo/tarefa ↔ agenda (`agenda_events.client_id`, `agenda_events.process_id`, `agenda_events.task_id`)
  - cliente/processo/tarefa/agenda ↔ financeiro (`financial_records.client_id`, `financial_records.process_id`, `financial_records.task_id`, `financial_records.agenda_event_id`)

Para habilitar os módulos reais, aplique o schema em `supabase/schema.sql`, incluindo as tabelas `processes`, `tasks`, `agenda_events` e `financial_records` com RLS por workspace.

## Hotfix — separação crítica entre Supabase real e demo/local

No estágio real aplicado atualmente, o Supabase operacional possui apenas estas tabelas ativas para uso do app:

- `workspaces`;
- `profiles`;
- `workspace_members`;
- `clients`;
- `activity_logs`.

Em login Supabase real, apenas módulos com tabela real ativa podem exibir dados reais. Portanto:

- `/clientes` continua carregando e persistindo registros reais de `public.clients`;
- `/processos` exibe “Nenhum processo real cadastrado neste workspace.” até existir tabela real ativa;
- `/processos/parcerias` exibe “Nenhuma parceria real cadastrada neste workspace.” até existir tabela real ativa;
- `/tarefas` exibe “Nenhuma tarefa real cadastrada neste workspace.” até existir tabela real ativa;
- `/agenda` exibe “Nenhum compromisso real cadastrado neste workspace.” até existir tabela real ativa;
- `/financeiro` exibe “Nenhum lançamento financeiro real cadastrado neste workspace.” até existir tabela real ativa.

Dados demo, mocks, seeds e registros em `localStorage` desses módulos só podem aparecer quando o usuário entra explicitamente por **Entrar na demonstração**. Em sessão Supabase real, os helpers locais desses módulos ignoram o fallback demo/local para impedir que registros fictícios pareçam dados reais.

As tabelas reais de processos, tarefas, agenda, financeiro e parcerias devem ser tratadas como próxima etapa de schema/migração, sem criação automática de seeds e sem uso de chave administrativa no frontend.

## Configurações híbridas — workspace e perfil reais

A aba `/configuracoes` agora funciona em modo híbrido:

- Em **modo Supabase**, quando há sessão autenticada e `workspace_id` ativo em `workspace_members`, a sessão real tem prioridade sobre o modo demo/local e a tela carrega:
  - workspace real de `public.workspaces`;
  - perfil real de `public.profiles`;
  - vínculo ativo em `public.workspace_members`.
- O botão **Salvar alterações** persiste no Supabase, usando somente a sessão autenticada do usuário e respeitando RLS:
  - `workspaces.name`;
  - `workspaces.status`;
  - `profiles.full_name`;
  - `profiles.email`;
  - `profiles.role`.
- O role/permissão vindo de `workspace_members` é exibido como leitura para evitar alteração indevida de permissões pela tela de configuração.
- Em **modo demonstração**, a edição continua local no navegador, sem banco real e sem misturar dados demo com dados Supabase. O modo demo/local só deve aparecer ao clicar em **Entrar na demonstração** ou como fallback quando Supabase/sessão/workspace real não estiverem disponíveis.
- O bloco técnico da tela exibe apenas informações operacionais não sensíveis: modo de dados, Supabase configurado, workspace atual e usuário atual. Chaves, tokens e segredos nunca são exibidos. Ao entrar com Supabase, flags antigas de demonstração em storage são limpas/ignoradas para não reaproveitar estado demo.

### Limitações conhecidas

O schema atual de `workspaces` ainda não possui colunas dedicadas para plano, co-branding, assinatura padrão, identidade operacional ou preferências visuais. Por isso, em sessão Supabase esses campos continuam editáveis na tela para manter a experiência premium, mas somente as colunas existentes e seguras são persistidas no banco. Uma migração futura pode adicionar um campo JSONB de preferências ou colunas específicas, sem alteração destrutiva do schema existente.

## Etapa 3C — Processos e Parcerias reais com Supabase

Status: Processos e Parcerias processuais foram integrados ao modo Supabase real, mantendo a demonstração local separada e sem mistura de dados.

### Migração obrigatória

Foi adicionada a migração:

```bash
supabase/migrations/202605151200_create_processes_and_partnerships.sql
```

Antes de testar em produção, aplique manualmente esse SQL no Supabase pelo SQL Editor ou pelo fluxo de migrations do projeto. A migração cria as tabelas reais:

- `public.processes`
- `public.process_partnerships`

A migração também configura:

- `RLS` habilitado nas duas tabelas.
- Políticas de `select`, `insert` e `update` limitadas a usuários autenticados que sejam membros ativos do `workspace` em `public.workspace_members`.
- Reuso/criação segura de `public.is_workspace_member(workspace_id)`.
- Trigger `set_updated_at` para manter `updated_at` em updates.
- Índices por `workspace_id`, vínculo de cliente/processo e arquivamento.

> Não use chave administrativa do Supabase no frontend. Não inclua chaves reais no repositório. O usuário deve aplicar a migração manualmente no Supabase antes de validar o CRUD real.

### Comportamento por modo

- Em sessão Supabase real com workspace resolvido, `/processos` lista, cria, edita e arquiva registros de `public.processes` por `workspace_id`.
- Em sessão Supabase real, o formulário de Processos carrega apenas clientes reais de `public.clients` do workspace atual; se não houver clientes reais, mostra “Nenhum cliente real cadastrado neste workspace.” e permite salvar o processo sem cliente vinculado.
- Em sessão Supabase real, `/processos/parcerias` lista, cria, edita e arquiva registros de `public.process_partnerships` por `workspace_id`, com vínculo opcional a um processo real.
- Em sessão Supabase real sem dados, Processos e Parcerias exibem empty states premium, sem carregar mocks ou `localStorage`.
- Em modo demonstração, os módulos continuam usando dados demo/local atuais, separados dos registros reais.

### Escopo preservado para próximas etapas

Nesta etapa não foram implementadas tabelas reais para:

- Tarefas
- Agenda
- Financeiro

Esses módulos devem continuar sem dados reais próprios em modo Supabase até receberem schema e camada de dados específicos em etapas futuras.

### Activity logs

Quando `public.activity_logs` estiver disponível com as políticas da fundação Supabase, a camada de dados tenta registrar criação, edição e arquivamento de Processos e Parcerias. Falhas de log não bloqueiam o CRUD principal.

### Validação recomendada após aplicar a migração

```bash
npm run typecheck
npm run build
npm run lint
git diff --check
test ! -f .env.local
```

Depois do deploy, valide login Supabase, Clientes reais, CRUD de Processos, CRUD de Parcerias e isolamento do modo demonstração conforme os critérios da Etapa 3C.

## Etapa 3D — Tarefas reais com Supabase

A Etapa 3D adiciona o módulo **Tarefas** ao fluxo real do Supabase, preservando a demonstração local totalmente separada. Quando há sessão Supabase real com workspace resolvido, `/tarefas` passa a listar, criar, editar, concluir, reabrir/remarcar e arquivar registros reais da tabela `public.tasks`; quando o usuário entra pela demonstração, os dados continuam locais/mockados e não são misturados com o workspace real.

### Migração necessária

Antes de validar em produção, execute manualmente no SQL Editor do Supabase a migração:

```bash
supabase/migrations/202605151530_create_tasks.sql
```

A migração cria `public.tasks` com vínculos opcionais para `public.clients` e `public.processes`, campos de status, prioridade, tipo, responsável, prazo, conclusão, arquivamento, próxima ação, notas, `metadata`, timestamps e trigger de `updated_at`.

### Segurança e RLS

A tabela `public.tasks` fica com RLS habilitado. As políticas permitem `select`, `insert` e `update` apenas para usuários autenticados membros ativos do workspace (`workspace_members.user_id = auth.uid()` e `workspace_members.status = 'active'`). Não há política pública aberta, não há uso de chave administrativa do Supabase no frontend e nenhum dado seed/fake é carregado em modo Supabase.

### Comportamento do módulo

- **Modo Supabase real:** tarefas vêm exclusivamente de `public.tasks` filtradas por `workspace_id`; clientes e processos exibidos nos formulários vêm das tabelas reais do workspace; se não houver tarefas, a tela mostra empty state premium sem dados demo.
- **Modo demonstração:** tarefas continuam usando o comportamento demo/local existente no navegador.
- Tarefas podem ser vinculadas a cliente real e processo real, ou permanecer internas sem vínculo.
- Filtros da aba contemplam status, prioridade, prazo vencido, responsável, tipo, cliente e processo.
- Tarefas concluídas saem da visão operacional e aparecem em **Concluídas**; tarefas arquivadas saem da visão principal e aparecem em **Arquivadas**.

### Fora do escopo desta etapa

Agenda real, Financeiro real, notificações reais, envio de e-mail/WhatsApp e automações automáticas entre processo urgente e tarefa/agenda permanecem para próximas etapas. Processos urgentes **não** geram tarefas automaticamente nesta etapa.

## Etapa 3E — Agenda/Prazos reais com Supabase

Status: o módulo `/agenda` agora possui migração e camada de dados real para Supabase, mantendo o modo demonstração totalmente separado.

### Migração `agenda_events`

A migração `supabase/migrations/202605151700_create_agenda_events.sql` cria a tabela `public.agenda_events` com vínculos opcionais para `clients`, `processes` e `tasks`, campos de tipo/status/prioridade, datas de início/fim/lembrete, conclusão, cancelamento, arquivamento e `metadata` para preservar rótulos de interface.

Para aplicar em produção/staging, copie o conteúdo do arquivo SQL e execute manualmente no SQL Editor do Supabase do projeto correto. A aplicação não assume que a migração já foi rodada.

### Segurança e RLS

- A tabela `public.agenda_events` usa RLS.
- Usuários autenticados só podem selecionar, inserir e atualizar eventos de workspaces onde `workspace_members.user_id = auth.uid()` e `workspace_members.status = 'active'`.
- A migração reaproveita/cria `public.set_updated_at()` e `public.is_workspace_member(uuid)` seguindo o padrão das etapas anteriores.
- Não há política pública aberta, chave administrativa do Supabase no frontend ou seed fake para o modo Supabase.

### Comportamento da Agenda

- Em sessão Supabase real, `/agenda` lista, cria, edita, remarca, conclui, cancela e arquiva registros reais de `public.agenda_events` do `workspace_id` atual.
- Clientes, processos e tarefas exibidos no formulário vêm das tabelas reais do workspace atual; se não existirem, o formulário mostra opções de estado vazio para vínculo opcional.
- Eventos reais podem ser vinculados manualmente a `client_id`, `process_id` e `task_id`.
- Se não houver eventos reais, a Agenda mostra empty state premium sem carregar mocks, demo ou `localStorage`.
- Em modo demonstração, a Agenda continua usando dados locais/demo e não mostra registros reais do Supabase.

### Filtros e estados

Os filtros da Agenda usam dados reais em modo Supabase:

- Hoje: eventos operacionais com `starts_at` no dia atual.
- Esta semana: eventos operacionais nos próximos 7 dias.
- Prazos: `event_type = deadline` na camada Supabase, exibido como `prazo` na UI.
- Audiências: `event_type = hearing`.
- Reuniões: `event_type = meeting`.
- Follow-ups: `event_type = follow_up`.
- Concluídos: `status = completed`.
- Arquivados/cancelados: `status = archived/canceled` ou `archived_at`/`canceled_at` preenchido.
- Operacionais: `scheduled`, `in_progress` e `rescheduled`, sem concluídos/cancelados/arquivados.
- Risco máximo: prioridade urgente/máxima ou risco alto/crítico.
- Itens derivados: eventos reais com `task_id` ou `process_id` preenchido; esta etapa não cria eventos automaticamente a partir de prazos de tarefas/processos.

### Limitações mantidas para próximas etapas

- Google Calendar real não está conectado.
- Gmail, WhatsApp, n8n, tribunais, notificações reais e IA real não foram conectados.
- Financeiro real permanece fora do escopo desta etapa.
- Eventos não são gerados automaticamente a partir de `due_at` de tarefas ou prazos de processos; apenas o vínculo manual foi habilitado nesta etapa.

## Etapa 3F — Financeiro real com Supabase

Status: o módulo `/financeiro` agora possui migração e camada de dados real para Supabase, mantendo o modo demonstração totalmente separado.

### Migração `financial_records`

A migração `supabase/migrations/202605151830_create_financial_records.sql` cria a tabela `public.financial_records` com vínculos opcionais para `clients`, `processes`, `tasks`, `agenda_events` e `process_partnerships`, além dos campos financeiros controlados: tipo (`record_type`), direção, status, valor, valor pago, vencimento, pagamento, parcelas, responsável, forma de pagamento demonstrativa, categoria, próxima ação, notas, `metadata`, cancelamento, arquivamento e timestamps.

Para aplicar em produção/staging, copie o conteúdo do arquivo SQL e execute manualmente no SQL Editor do Supabase do projeto correto. A aplicação não assume que a migração já foi rodada.

### Segurança e RLS

- A tabela `public.financial_records` usa RLS.
- Usuários autenticados só podem selecionar, inserir e atualizar lançamentos de workspaces onde `workspace_members.user_id = auth.uid()` e `workspace_members.status = 'active'`.
- A migração reaproveita/cria `public.set_updated_at()` e `public.is_workspace_member(uuid)` seguindo o padrão das etapas anteriores.
- Não há política pública aberta, chave administrativa do Supabase no frontend ou seed fake para o modo Supabase.

### Comportamento do Financeiro

- Em sessão Supabase real, `/financeiro` lista, cria, edita, marca como pago, reabre, remarca vencimento, cancela e arquiva registros reais de `public.financial_records` do `workspace_id` atual.
- Clientes e processos exibidos no formulário vêm das tabelas reais do workspace atual; se não existirem, o formulário exibe “Nenhum cliente real cadastrado neste workspace.” ou “Nenhum processo real cadastrado neste workspace.” e mantém o vínculo opcional.
- Os registros reais podem persistir `client_id` e `process_id`; a tabela já possui colunas opcionais para `task_id`, `agenda_event_id` e `partnership_id`, que ficam preparados para uma etapa futura de seleção completa desses vínculos na UI.
- Se não houver lançamentos reais, o Financeiro mostra empty state premium sem carregar mocks, demo ou `localStorage`.
- Em modo demonstração, o Financeiro continua usando dados locais/demo e não mostra registros reais do Supabase.

### Status e filtros

A camada Supabase armazena status normalizados (`planned`, `pending`, `waiting`, `paid`, `overdue`, `canceled`, `archived`) e a UI mantém os rótulos em português. Os cards/filtros usam os dados reais em modo Supabase:

- Valores a receber: entradas planejadas, pendentes ou aguardando, não pagas/canceladas/arquivadas.
- Valores vencidos: vencimentos anteriores à data atual com status diferente de pago/cancelado/arquivado, mesmo que ainda não estejam marcados como `overdue`.
- Clientes inadimplentes: agrupamento de clientes com registros vencidos.
- Receita prevista: entradas futuras planejadas (`planned`/“previsto”).
- Parcelas próximas: vencimentos dos próximos 30 dias.
- Cobranças pendentes: status exato `pending`/“pendente”, sem misturar com `waiting`/“aguardando”.
- Recebidos no mês: status pago com `paid_at` no mês atual.
- Arquivados/Cancelados: status arquivado/cancelado ou timestamps de arquivamento/cancelamento preenchidos.

### Fora do escopo desta etapa

- Não há PIX real, boleto real, gateway, banco, Asaas, Stripe, Mercado Pago ou integração financeira externa.
- Formas de pagamento são apenas registros demonstrativos/controlados dentro do workspace.
- Não há cobrança automática por WhatsApp/e-mail, emissão de recibo real ou automações financeiras complexas.
- Automações financeiras, seleção completa de tarefa/agenda/parceria no formulário e integrações bancárias ficam para próximas etapas.

### Hotfix Etapa 3F — Salvamento de lançamentos financeiros

O fluxo de criação/edição de `financial_records` foi ajustado para enviar ao Supabase apenas colunas existentes no schema real (`record_type`, `due_date`, `amount`, vínculos por UUID e campos opcionais nulos/omitidos com segurança). Valores monetários digitados como `100`, `100,00` ou `R$ 100,00` são normalizados para número antes do insert/update, e datas são normalizadas para `YYYY-MM-DD`. O `workspace_id` real da sessão continua obrigatório e as políticas RLS por membro ativo do workspace são respeitadas; bloqueios de workspace/RLS exibem toast amigável sem misturar dados demo.

## Etapa 3J — Central LEX.OS real/controlada com Supabase

Status: a Central LEX.OS agora possui histórico real por workspace em Supabase, mantendo a demonstração local separada e sem conexão com IA real.

### Migração `central_executions`

A migração `supabase/migrations/202605152130_create_central_executions.sql` cria a tabela `public.central_executions` para registrar execuções da Central LEX.OS por workspace. A tabela inclui tipo de execução (`execution_type`), título, módulo de origem, vínculos opcionais com `clients`, `processes`, `process_partnerships`, `tasks`, `agenda_events`, `financial_records` e `reports`, resumo de entrada, `output_text`, status (`generated`, `copied`, `archived`), `metadata`, timestamps de cópia/arquivamento e `created_at`/`updated_at`.

Para aplicar em produção/staging, copie o conteúdo do arquivo SQL e execute manualmente no SQL Editor do Supabase do projeto correto antes do teste final. A aplicação não usa chave administrativa do Supabase, não cria `.env.local` e não assume que a migração já foi rodada.

### Segurança e RLS

- A tabela `public.central_executions` usa RLS.
- Usuários autenticados só podem selecionar, inserir e atualizar execuções de workspaces onde `workspace_members.user_id = auth.uid()` e `workspace_members.status = 'active'`.
- A migração reaproveita/cria `public.set_updated_at()` e `public.is_workspace_member(uuid)` seguindo o padrão das etapas anteriores.
- Não há política pública aberta, seed fake para modo Supabase ou chave administrativa no frontend.

### Comportamento da Central LEX.OS

- Em sessão Supabase real, `/central-lexos` lista o histórico real de `public.central_executions` filtrado pelo `workspace_id` atual.
- Prompts, Dossiê Rápido, Agentes, Fluxos Guiados e Playbooks carregam dados reais do workspace (`clients`, `processes`, `process_partnerships`, `tasks`, `agenda_events`, `financial_records` e `reports`) e salvam a execução real em `central_executions`.
- As saídas são determinísticas/controladas, geradas por templates locais a partir dos dados do workspace. Não há IA real, OpenAI API, Claude API, Gemini API, n8n, WhatsApp, e-mail, Google Calendar ou qualquer integração externa.
- O botão “Copiar resultado” copia o `output_text` e atualiza `copied_at`/`status = copied` quando há execução salva.
- O arquivamento é não destrutivo: marca `status = archived` e `archived_at`, removendo a execução da lista principal e mantendo-a no filtro de arquivadas.
- Toda saída mostra o aviso: “Saída gerada com dados do workspace. Revisão humana obrigatória antes de uso externo.”

### Separação do modo demonstração

- Ao entrar por “Entrar na demonstração”, a Central continua usando dados demo/local e `localStorage`.
- Execuções reais do Supabase não aparecem na demonstração.
- Em sessão Supabase real, a Central não carrega mocks/demo para preencher histórico ou saídas reais; se não houver execuções, exibe: “Nenhuma execução real da Central LEX.OS registrada neste workspace.”

### Limitações mantidas para próximas etapas

- A promptoteca global real por workspace ainda não foi criada; nesta etapa apenas as execuções reais são persistidas.
- Não há execução real por LLM nem automação externa.
- Busca global e Dashboard/Painel dos Sócios consomem o histórico real disponível, mas a evolução de métricas avançadas da Central fica para etapas futuras.

## Etapa 3L — Usuários, equipe e permissões reais por workspace

Status: a área de Configurações agora possui gestão real/controlada de usuários do workspace, mantendo o modo demonstração separado.

### Migração `workspace_members` e `profiles`

A migração `supabase/migrations/202605153000_update_workspace_members_permissions.sql` adiciona campos opcionais e seguros em `public.workspace_members` (`display_name`, `position`, `department`, `permissions`, dados de convite, desativação, última atividade e `metadata`) e em `public.profiles` (`phone`, `position`, `department`, `avatar_url` e `metadata`). Ela também cria a função `public.can_manage_workspace_members(uuid)` e ajusta policies para leitura de membros do mesmo workspace e atualização por gestores.

Para testar em Supabase, copie o conteúdo dessa migração e execute manualmente no SQL Editor do projeto correto antes do deploy/teste final. A aplicação não usa chave administrativa, não cria usuário via Admin API no frontend e não cria `.env.local`.

### Papéis oficiais

Papéis padronizados por workspace:

- `owner`: acesso total, gestão de membros, Painel dos Sócios e configurações avançadas.
- `admin`: acesso amplo à operação e gestão de membros.
- `socio`: visão estratégica, Painel dos Sócios, financeiro e relatórios estratégicos.
- `advogado`: operação jurídica com clientes, processos, parcerias, tarefas, agenda, relatórios operacionais e Central.
- `estagiario`: operação limitada a clientes, processos, tarefas, agenda e Central.
- `financeiro`: financeiro, clientes e relatórios financeiros, sem Painel dos Sócios por padrão.
- `operacional`: tarefas, agenda, clientes, processos e Central, sem áreas sensíveis.
- `leitura`: leitura quando possível, sem edição sensível.

A matriz simplificada fica centralizada em `src/lib/permissions.ts`, com helpers como `getRolePermissions`, `canAccessModule`, `canManageMembers`, `canViewPartnersDashboard`, `canViewFinance`, `canEditFinance`, `canManagePrompts`, `canGenerateReports` e `canEditWorkspaceSettings`.

### Comportamento em Configurações

- `Configurações > Usuários e permissões` lista membros reais de `public.workspace_members` e perfis de `public.profiles` quando a sessão está em modo Supabase.
- A tela exibe nome, e-mail, papel, status, cargo, departamento, última atividade disponível e permissões derivadas do papel.
- `owner/admin` podem editar papel, status, nome de exibição, cargo e departamento do membro, respeitando RLS.
- O usuário atual pode editar dados seguros do próprio perfil em “Meu perfil”: nome, cargo, departamento e telefone.
- O e-mail é exibido em leitura e o próprio usuário não recebe controle para se promover a `owner/admin`.
- Alterações tentam registrar auditoria simples em `public.activity_logs` (`member_role_updated`, `member_deactivated`, `member_reactivated`, `workspace_member_updated`, `profile_updated`). Falhas de log não bloqueiam o fluxo operacional.

### Áreas restritas

Há bloqueio visual premium para áreas sensíveis com base no papel do workspace:

- Painel dos Sócios (`/socios`): liberado para `owner`, `admin` e `socio`.
- Financeiro (`/financeiro`): liberado para `owner`, `admin`, `socio` e `financeiro`.
- Biblioteca de Prompts (`/central-lexos/prompts`): acesso conforme matriz simplificada; gestão plena fica para papéis estratégicos.

Quando o papel não permite acesso, a aplicação mostra “Acesso restrito neste workspace.” e botão para voltar ao Dashboard, sem quebrar a navegação.

### Limitações atuais

- Convite real por e-mail ainda não foi implementado.
- Criação automática de usuário externo ainda não existe; por enquanto, crie o usuário manualmente no Supabase Authentication e vincule em `public.workspace_members` com o `workspace_id` correto.
- A RLS já evita leitura entre workspaces e restringe gestão de membros a papéis autorizados, mas validações finas por coluna ainda ficam como evolução futura; a camada de frontend/dados não oferece autopromoção ao usuário comum.
- Não há Gmail, WhatsApp, Google Calendar, n8n, OpenAI, Claude, Gemini, SSO, MFA customizado, billing real, marketplace ou portal do cliente nesta etapa.
- Busca global de usuários reais fica como próximo passo para evitar ampliar escopo e risco de RLS nesta entrega.

### Separação do modo demonstração

- Ao entrar por “Entrar na demonstração”, Configurações mostra apenas usuários demo locais.
- Usuários reais de `profiles`/`workspace_members` não aparecem misturados na sessão demo.
- Em sessão Supabase real, a lista de usuários vem do workspace real e não usa usuários fictícios para preencher a tela.

### Próximas etapas sugeridas

- Convites reais por e-mail com fluxo seguro no backend.
- Permissões refinadas por ação/campo.
- Auditoria avançada e tela dedicada de histórico.
- Busca global de membros reais do workspace.

## Etapa 3M — Activity logs e auditoria operacional real

A Etapa 3M consolida `public.activity_logs` como trilha operacional real por workspace para sessões autenticadas no Supabase, mantendo o modo demonstração/local totalmente separado.

### Estrutura e segurança

- A tabela `activity_logs` preserva colunas legadas (`user_id`, `module`) e adiciona campos padronizados para auditoria operacional: `actor_user_id`, `entity_type`, `title` e `metadata`.
- Os registros são sempre vinculados a `workspace_id` e as policies RLS permitem leitura e inserção somente para usuários autenticados com vínculo ativo em `workspace_members` (`status = 'active'`).
- Não há policy pública aberta, seed fake, automação externa, webhook, e-mail, WhatsApp, IA real ou uso de chave administrativa.

### Helper centralizado

- A camada `src/lib/data/activityLogs.ts` centraliza listagem e gravação de logs reais.
- Falhas ao gravar activity log são tratadas de forma controlada e não interrompem o fluxo principal de criação, edição, cópia, conclusão ou arquivamento dos módulos.
- O helper remove metadados com nomes sensíveis como senha, token, secret, key/chave e authorization antes de persistir.

### Módulos que geram logs reais

Em modo Supabase, os seguintes módulos registram eventos operacionais mínimos:

- Clientes: criação, atualização e arquivamento.
- Processos: criação, atualização e arquivamento.
- Parcerias: criação, atualização e arquivamento.
- Tarefas: criação, atualização, conclusão e arquivamento.
- Agenda/Prazos: criação, atualização, remarcação, conclusão, cancelamento e arquivamento.
- Financeiro: criação, atualização, pagamento, reabertura, alteração de vencimento, cancelamento e arquivamento.
- Relatórios: geração, cópia e arquivamento.
- Central LEX.OS: geração, cópia e arquivamento de execuções.
- Prompts: criação, atualização, versionamento, arquivamento e execução pela Central LEX.OS.
- Usuários/permissões: atualização de perfil, papel e status de membros.
- Configurações: atualização de dados do workspace.

### UI e limites atuais

- O Dashboard passa a usar `activity_logs` reais em sessão Supabase para “Últimas atividades”. Se não houver registros, mostra: “Nenhuma atividade real registrada neste workspace.”
- A área `/configuracoes/auditoria` oferece uma consulta simples com data, ação, módulo, usuário, descrição, entidade relacionada e filtros por módulo/ação.
- Em modo demonstração, os dados continuam locais/demo; a aplicação não lista nem grava logs reais do Supabase.
- A auditoria desta etapa é operacional e mínima. Ainda não implementa logs imutáveis, auditoria jurídica avançada, exportação avançada, alertas externos ou integrações.


## Etapa 3O — Segurança, LGPD e produção para piloto controlado

O LEX.OS Control está posicionado como **piloto controlado em escritório real**, não como produto público final. O Supabase real permanece separado do modo demonstração, e a aplicação deve operar com sessão autenticada, `workspace_id` resolvido e usuário vinculado em `workspace_members`.

### Uso recomendado

- Use o ambiente real apenas com escritórios e clientes piloto autorizados.
- Valide login Supabase, workspace atual, usuário atual e papel atual em `/configuracoes` e `/configuracoes/seguranca` antes da entrega.
- Revise manualmente dados de teste, relatórios, saídas da Central LEX.OS e prompts antes de qualquer uso externo.
- Não trate o checklist LGPD como declaração de conformidade completa; ele é apoio operacional e não substitui revisão jurídica específica.

### Módulos reais cobertos

Os módulos reais integrados ao workspace incluem configurações/workspace/perfil, usuários e permissões, clientes, processos, parcerias, tarefas, agenda/prazos, financeiro, dashboard, Painel dos Sócios, relatórios, Central LEX.OS, Biblioteca/Gerenciador de Prompts, activity logs/auditoria e onboarding de escritório real.

### Separação demo/real

- Modo Supabase consulta apenas dados reais do workspace autenticado e não preenche listas com dados demo quando uma consulta real falha.
- Modo demonstração usa dados locais/fictícios e não consulta registros reais do Supabase.
- Dados reais devem ser sempre filtrados por `workspace_id`; inserts e updates devem incluir o workspace correto e depender de usuário membro ativo.
- A busca global em sessão Supabase usa resultados carregados por workspace e oculta financeiro quando o papel atual não possui permissão financeira.

### Segurança, RLS e permissões

- As policies esperadas usam `public.is_workspace_member(workspace_id)` com membro ativo e `auth.uid()`.
- Não crie policy pública aberta e não relaxe RLS para corrigir telas.
- Áreas sensíveis mínimas: Painel dos Sócios (`owner/admin/socio`), Financeiro (`owner/admin/socio/financeiro`), Usuários e permissões (`owner/admin`), Configurações avançadas (`owner/admin`), gestão de prompts (`owner/admin/socio`) e relatórios estratégicos (`owner/admin/socio`).
- Usuários sem acesso devem ver a tela premium “Acesso restrito neste workspace” com retorno ao Dashboard.
- Activity logs registram ações operacionais quando a RLS permitir; falha de log não deve quebrar o fluxo do usuário.

### Variáveis de ambiente esperadas

```bash
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
LEXOS_DATA_SOURCE=demo
NEXT_PUBLIC_LEXOS_DATA_SOURCE=demo
```

Nunca use chaves administrativas no frontend, nunca commite `.env.local`, tokens, segredos, credenciais reais, URLs sigilosas ou credenciais em exemplos. O cliente Supabase do navegador deve usar apenas a URL pública e a chave anônima/publicável do projeto.

### Limitações LGPD e produção

- Checklist LGPD é informativo/operacional e não substitui política formal, termos públicos definitivos ou revisão jurídica.
- Não há billing real, gateway de pagamento, e-mail, WhatsApp, Google Calendar, portal do cliente, SSO, MFA customizado, IA real, criptografia campo a campo ou backup automatizado avançado nesta etapa.
- O financeiro é controle interno e não substitui sistema bancário, contábil ou gateway.
- Relatórios e Central LEX.OS produzem saídas controladas/determinísticas e exigem revisão humana antes de uso externo.
- Prompts não devem receber senhas, tokens, chaves, credenciais ou documentos sigilosos fora do escopo.

### Checklist antes de entregar ao escritório

1. Confirmar login real Supabase.
2. Confirmar “Modo de dados: Supabase” em `/configuracoes`.
3. Abrir `/configuracoes/seguranca` e revisar workspace, usuário, papel, RLS esperada e checklist LGPD.
4. Revisar usuários/permissões e inativar acessos indevidos.
5. Revisar dados de teste no onboarding e arquivar manualmente quando necessário.
6. Confirmar activity logs para ações críticas.
7. Confirmar avisos de revisão em Relatórios, Central LEX.OS, Financeiro, Prompts e Onboarding.
8. Rodar typecheck, lint, build, `git diff --check` e varredura de segredos antes do release.

### Próximas etapas

- Auditoria final de release.
- Manual do usuário e roteiro de operação assistida.
- Termos de uso e política de privacidade formais.
- Rotina de backup/exportação.
- Convites reais e gestão avançada de usuários.
- Integrações externas futuras somente após aprovação de segurança e escopo.

## QA Agent / Testes E2E

A suíte E2E usa Playwright para validar os fluxos principais do LEX.OS Control em ambiente controlado.

### Variáveis obrigatórias

Defina no ambiente (sem commitar senha/chaves):

```bash
E2E_BASE_URL=https://seu-ambiente
E2E_EMAIL=usuario@escritorio.com.br
E2E_PASSWORD=sua-senha
E2E_WORKSPACE_NAME="Almeida e Saraiva Advocacia"
```

Se faltar variável obrigatória, os testes falham com mensagem clara:

`Configure E2E_BASE_URL, E2E_EMAIL e E2E_PASSWORD antes de rodar os testes.`

### Comandos

```bash
npm run test:e2e
npm run test:e2e:headed
npm run test:e2e:ui
npm run test:e2e:report
```

### Segurança e operação

- Não usar `service_role` nos testes.
- Não commitar `.env.local` nem senhas reais.
- Dados criados por automação devem usar prefixo `QA ... Automatizado` para facilitar filtro/arquivamento manual.
- A suíte gera screenshot/trace/video em falhas para diagnóstico.


### GitHub Actions (execução manual)

O workflow `.github/workflows/e2e.yml` roda **manualmente** via `workflow_dispatch`.

- Ele usa **npm install** (não `npm ci`) para não depender de lockfile obrigatório no repositório atual.
- O `setup-node` está sem cache (`cache: npm`) até existir lockfile versionado compatível.
- Em seguida instala browsers do Playwright, roda `typecheck`, `build`, `lint` e `test:e2e`.
- Em caso de falha/cancelamento, publica artifacts (`playwright-report` e `test-results`) para diagnóstico.

Secrets necessários no repositório GitHub:

- `E2E_BASE_URL`
- `E2E_EMAIL`
- `E2E_PASSWORD`
- `E2E_WORKSPACE_NAME`

Para executar: GitHub → **Actions** → **E2E QA Agent** → **Run workflow**.

## Rodada pós-redesign — refinamento operacional premium

Esta rodada preserva a base visual navy premium aprovada e consolida ajustes para uso diário em escritórios com carteiras maiores:

- superfícies e cards foram suavizados para reduzir bordas agressivas e manter leitura executiva em telas grandes;
- listas principais de Clientes, Processos, Tarefas, Agenda e Financeiro passam a trabalhar com recortes/paginação local, contadores e filtros antes de exibir novos grupos;
- CTAs principais continuam navegando para rotas internas existentes, abrindo painéis/modais locais ou exibindo feedback controlado quando a ação ainda é assistida;
- o modo demonstração permanece local e separado do modo Supabase/autenticado, sem envio externo automático, cobrança real ou alteração de schema/migrations;
- saídas sensíveis continuam exigindo revisão humana antes de qualquer uso externo.

Checklist recomendado para validar esta rodada: abrir Dashboard, Clientes, Processos, Tarefas, Agenda, Financeiro, Painel dos Sócios, Relatórios, Central LEX.OS, Configurações e Onboarding; clicar nos principais CTAs; testar filtros/buscas; confirmar ausência de rolagem horizontal global; rodar `npm run typecheck`, `npm run lint` e `npm run build`.
