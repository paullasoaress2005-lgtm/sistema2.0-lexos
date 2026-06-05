# Auditoria técnica de QA/segurança — separação de acesso do LEX.OS Control

**Data da revisão estática:** 2026-06-01

**Escopo:** separação entre demonstração local sem credenciais e operação autenticada via Supabase.

**Natureza desta entrega:** documentação somente. Nenhum componente visual, comportamento funcional, schema, policy, usuário ou integração foi alterado.

## 1. Resumo executivo

A aplicação possui dois **modos de sessão**, mas não dois conjuntos independentes de rotas:

1. **Demonstração local controlada:** iniciada sem usuário/senha pelo botão da tela `/login`; persiste uma sessão `mode: "demo"` no `localStorage`; usa dados fictícios locais e não executa chamadas externas explícitas encontradas na varredura estática.
2. **Operação conectada Supabase:** iniciada por e-mail/senha na mesma tela `/login`; usa `supabase.auth.signInWithPassword`, resolve o usuário autenticado e uma associação ativa em `workspace_members`, persiste um espelho local `mode: "supabase"` e passa a selecionar os adaptadores Supabase dos módulos operacionais.

As URLs operacionais são compartilhadas pelos dois modos. O controle de entrada nas páginas ocorre no navegador por meio de `AuthGate`, que considera suficiente a existência de um objeto de sessão estruturalmente válido no `localStorage`. O middleware atual atualiza cookies da sessão Supabase, mas não bloqueia nem redireciona rotas.

**Conclusão para pré-piloto:** a separação de dados locais versus Supabase está explicitamente modelada e os acessos de banco foram desenhados para depender de RLS por workspace. Porém, a área autenticada **não pode ser considerada protegida integralmente na camada de rotas** até existir validação server-side de sessão Supabase para o modo conectado e tratamento fail-closed para usuários autenticados sem workspace ativo. A proteção efetiva de dados reais depende da aplicação das migrations RLS no projeto remoto e deve ser validada no ambiente do piloto.

## 2. Metodologia e limites da auditoria

### 2.1 Verificações executadas

A auditoria foi feita por inspeção estática do repositório, incluindo:

- inventário de páginas em `src/app/**/page.tsx`;
- inspeção de `middleware.ts`, `AuthGate`, tela de login, helpers de autenticação e clientes Supabase;
- rastreamento de imports das páginas para módulos em `src/lib/data`;
- inventário das tabelas acessadas pelos adaptadores Supabase;
- busca por primitivas de envio externo (`fetch`, `axios`, `XMLHttpRequest`, `sendBeacon`, `WebSocket`, `supabase.functions`, `invoke`);
- busca por termos relacionados a segredo/credencial em arquivos rastreados pelo Git;
- conferência de `.env.example`, `.gitignore`, schema e migrations RLS versionadas.

### 2.2 Limites

Esta é uma revisão estática do código versionado. Ela **não comprova**:

- quais variáveis existem no deploy real;
- quais migrations foram efetivamente aplicadas no projeto Supabase remoto;
- quais usuários existem no Supabase Auth remoto;
- se há usuários indevidos, associações antigas ou dados reais no banco remoto;
- o comportamento de RLS no ambiente remoto sem executar testes autenticados contra esse ambiente.

## 3. Modelo atual de acesso

### 3.1 Entrada pública e seleção do modo

- `/` redireciona para `/login`.
- `/login` é a entrada pública explícita.
- O botão de demonstração chama `startDemoSession()` sem solicitar credenciais e envia o navegador para `/dashboard`.
- O formulário conectado chama `signInWithEmail(email, password)`, que usa Supabase Auth quando as variáveis públicas estão configuradas.

A demonstração é, portanto, **sem login/senha**, mas há uma etapa de entrada pública que cria uma sessão local demonstrativa. Não existe uma URL pública paralela como `/demo/*`.

### 3.2 Rotas públicas encontradas

| Rota | Situação | Observação |
| --- | --- | --- |
| `/` | Pública | Executa redirect server-side para `/login`. |
| `/login` | Pública | Oferece entrada na demonstração e autenticação Supabase por e-mail/senha. |

Arquivos estáticos do Next.js e imagens também são excluídos do matcher do middleware, como esperado.

### 3.3 Rotas operacionais tratadas como protegidas

`AuthGate` considera protegidos estes prefixos e todos os seus subcaminhos:

| Prefixo protegido | Páginas identificadas no repositório |
| --- | --- |
| `/dashboard` | `/dashboard` |
| `/clientes` | `/clientes`, `/clientes/[id]` |
| `/processos` | `/processos`, `/processos/[id]`, `/processos/parcerias` |
| `/tarefas` | `/tarefas` |
| `/agenda` | `/agenda` |
| `/financeiro` | `/financeiro` |
| `/relatorios` | `/relatorios` |
| `/central-lexos` | `/central-lexos`, `/central-lexos/agentes`, `/central-lexos/dossie-rapido`, `/central-lexos/fluxos`, `/central-lexos/playbooks`, `/central-lexos/prompts` |
| `/configuracoes` | `/configuracoes`, `/configuracoes/auditoria`, `/configuracoes/release`, `/configuracoes/seguranca`, `/configuracoes/usuarios` (redirect para `/configuracoes`) |
| `/socios` | `/socios` |
| `/onboarding` | `/onboarding` |
| `/minha-semana` | `/minha-semana` |

As páginas operacionais renderizam `AppLayout` diretamente ou por `PlaceholderPage`; `AppLayout` envolve o conteúdo com `AuthGate`. A rota `/configuracoes/usuarios` não renderiza conteúdo próprio: redireciona para `/configuracoes`, que está sob o gate.

### 3.4 Autorização por papel

Há também controles de módulos por papel no frontend (`RestrictedAccess` e helpers em `src/lib/permissions.ts`). Eles são úteis para UX, mas não devem ser tratados como barreira de segurança porque dependem da sessão espelhada no navegador. Para dados reais, a barreira mandatória deve continuar sendo RLS no Supabase.

## 4. Onde ocorre autenticação

| Ponto | Responsabilidade |
| --- | --- |
| `src/app/login/page.tsx` | Captura e-mail/senha, chama login Supabase e oferece entrada local na demonstração. |
| `src/lib/auth/session.ts` | Cria, persiste, lê e limpa o espelho local da sessão; autentica via `signInWithPassword`; resolve `profiles`, `workspace_members` e `workspaces`. |
| `src/lib/supabase/client.ts` | Cria o cliente Supabase do navegador com URL e chave pública anônima/publicável. |
| `src/lib/supabase/proxy.ts` | Atualiza a sessão Supabase nos cookies durante o middleware com `auth.getUser()`. |
| `middleware.ts` | Executa o proxy em praticamente todas as rotas, exceto estáticos/imagens; não contém bloqueio de rota. |
| `src/lib/supabase/server.ts` | Disponibiliza cliente Supabase server-side baseado em cookies, mas não é usado atualmente para impor proteção às páginas operacionais. |
| `src/components/AuthGate.tsx` | Redireciona para `/login` no browser quando não existe sessão local estruturalmente válida. |

## 5. Páginas e módulos que dependem de Supabase

### 5.1 Dependência direta da tela de login

- `/login` consulta o status público de configuração Supabase e usa o fluxo de autenticação conectado.

### 5.2 Dependência indireta por adaptadores de dados

As páginas abaixo usam módulos que possuem caminhos Supabase quando `shouldUseWorkspaceSupabase()` detecta configuração pública e sessão local `mode: "supabase"`:

| Área/página | Módulos de dados relevantes | Tabelas Supabase acessadas |
| --- | --- | --- |
| `/dashboard` | `dashboard` e agregações dos módulos operacionais | Derivadas dos módulos listados abaixo. |
| `/clientes` | `clients`, além de processos e tarefas relacionados | `clients`, `processes`, `tasks` |
| `/processos`, `/processos/[id]` | `processes`, tarefas e parcerias relacionadas | `processes`, `tasks`, `process_partnerships` |
| `/processos/parcerias` | `partnerships`, clientes e processos | `process_partnerships`, `clients`, `processes` |
| `/tarefas` | `tasks`, clientes e processos | `tasks`, `clients`, `processes` |
| `/agenda` | `agenda`, clientes, processos e tarefas | `agenda_events`, `clients`, `processes`, `tasks` |
| `/financeiro` | `finance`, clientes e processos | `financial_records`, `clients`, `processes` |
| `/relatorios` | `reports` e agregações operacionais | `reports` e tabelas agregadas dos módulos relacionados |
| `/central-lexos` | `centralExecutions`, `promptTemplates` | `central_executions`, `prompt_templates`, `prompt_template_versions` |
| `/central-lexos/prompts` | `promptTemplates` | `prompt_templates`, `prompt_template_versions` |
| `/configuracoes` | `settings`, `users`, `demoSeed` | `profiles`, `workspace_members`, `workspaces`; seed controlado usa tabelas operacionais |
| `/configuracoes/auditoria` | `activityLogs` | `activity_logs`, `profiles` |
| `/configuracoes/release`, `/configuracoes/seguranca` | `settings`, `activityLogs`, status da fonte | `workspaces`, `workspace_members`, `profiles`, `activity_logs` |
| `/socios` | `partnersDashboard` e agregações | Dados agregados do workspace a partir dos módulos operacionais. |
| `/onboarding` | `onboarding` | `workspace_members` |

Os módulos com chamadas `.from(...)` explícitas são: `activityLogs`, `agenda`, `centralExecutions`, `clients`, `demoSeed`, `finance`, `onboarding`, `partnerships`, `processes`, `promptTemplates`, `reports`, `settings`, `tasks` e `users`.

### 5.3 Páginas sem chamada Supabase própria identificada

- `/clientes/[id]` e `/minha-semana` usam `PlaceholderPage` e dados demonstrativos de UI.
- As subpáginas `/central-lexos/agentes`, `/central-lexos/dossie-rapido`, `/central-lexos/fluxos` e `/central-lexos/playbooks` geram saídas locais/determinísticas; seus tipos se relacionam à Central, mas não foi encontrada chamada externa própria nessas páginas.

## 6. Validação da demonstração local

### 6.1 Sem exigência de credenciais

**Validado por código:** a entrada demonstrativa chama `startDemoSession()` diretamente e não exige login/senha. A sessão demo usa identificadores e pessoas fictícias hardcoded para apresentação.

### 6.2 Isolamento da fonte de dados

**Validado por código, com ressalvas:**

- `shouldUseWorkspaceSupabase()` somente retorna verdadeiro quando há configuração pública do Supabase **e** a sessão local contém `mode: "supabase"`.
- `shouldUseDemoData()` é o inverso desse predicado.
- Em fluxo normal, `startDemoSession()` cria `mode: "demo"`; portanto, os adaptadores seguem o caminho local.
- O repositório contém `supabase/seed-demo.sql` com aviso expresso de dados 100% fictícios e endereços `example.invalid`.

### 6.3 Ausência de envio externo explícito no modo demo

**Validado por varredura estática do código versionado:** não foram encontradas ocorrências de `fetch(`, `axios`, `XMLHttpRequest`, `sendBeacon`, `WebSocket`, `supabase.functions` ou `.invoke(` em `src`. Foram encontradas cópias deliberadas para `navigator.clipboard` em telas específicas, acionadas pelo usuário.

A conclusão é limitada ao código atual: bibliotecas, scripts de terceiros futuros e configuração de infraestrutura devem ser reavaliados caso sejam adicionados.

### 6.4 Dados sensíveis na demonstração

**Não foram identificadas credenciais reais ou segredos hardcoded.** Há nomes, e-mails locais e registros demonstrativos hardcoded. Eles aparentam ser fictícios e servem ao protótipo. O seed SQL também declara explicitamente que os dados são fictícios e usa domínios inválidos.

**Ressalva operacional:** a demonstração persiste dados em `localStorage`. Em computador compartilhado, dados digitados manualmente durante uma demonstração permanecem no perfil do navegador até limpeza apropriada. Não inserir dados reais na demo e limpar storage após apresentações.

## 7. Validação da área Supabase autenticada

### 7.1 O que está implementado

- Login conectado por `supabase.auth.signInWithPassword`.
- Verificação do usuário Supabase por `supabase.auth.getUser()`.
- Consulta de `workspace_members` com `status = "active"` ao resolver a sessão.
- Proxy de middleware que chama `supabase.auth.getUser()` para atualizar cookies.
- Clientes Supabase configurados somente por URL pública e chave anônima/publicável.
- Migrations versionadas com RLS e policies por workspace; várias usam membro ativo e `auth.uid()`; hardening adicional restringe financeiro, relatórios, configurações e gestão de prompts por papel.

### 7.2 O que ainda impede afirmar proteção integral

- `AuthGate` não consulta Supabase; ele aceita qualquer JSON local que satisfaça poucos campos estruturais.
- O middleware não diferencia rotas públicas/protegidas e não redireciona acesso sem usuário Supabase válido.
- O espelho local da sessão Supabase pode ficar obsoleto após expiração, revogação ou remoção do membro. As queries reais ainda devem ser barradas por RLS, mas a UI pode permanecer acessível e inconsistente.
- Se Supabase autenticar um usuário sem associação ativa a workspace, `resolveSupabaseSession()` retorna fallback demonstrativo marcado como `mode: "supabase"` em vez de falhar fechado.
- Não é possível provar pelo repositório que as migrations RLS foram executadas no ambiente remoto do piloto. A migration de hardening contém instrução de execução manual antes do release assistido.

## 8. Variáveis de ambiente do Supabase

### 8.1 Variáveis utilizadas pelo código

| Variável | Uso |
| --- | --- |
| `NEXT_PUBLIC_SUPABASE_URL` | URL pública usada pelos clientes browser, server e proxy. |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Chave pública anônima preferencial usada pelos clientes browser, server e proxy. |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Alternativa suportada pelo código quando a anon key não existe. |
| `LEXOS_DATA_SOURCE` | Fonte solicitada no ambiente. |
| `NEXT_PUBLIC_LEXOS_DATA_SOURCE` | Fonte solicitada exposta ao browser; tem precedência no helper de fonte. |

### 8.2 Arquivo de exemplo

`.env.example` contém somente placeholders vazios para URL e anon key e mantém fonte `demo` como padrão. Nenhum valor real foi encontrado versionado. O código aceita também `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`, mas essa alternativa não está documentada em `.env.example`.

### 8.3 Chaves e segredos hardcoded

- Não foi encontrada `service_role`, chave privada, token bearer, senha real ou chave Supabase preenchida nos arquivos rastreados.
- `.gitignore` ignora `.env` e variantes locais, preservando `.env.example`.
- O workflow E2E referencia GitHub Secrets, sem valores hardcoded.
- A chave anônima/publicável Supabase, quando configurada, é intencionalmente pública no frontend; segurança de dados reais depende de RLS correto, não do sigilo dessa chave.

## 9. Achados e riscos

| ID | Severidade | Achado | Impacto | Evidência técnica | Recomendação |
| --- | --- | --- | --- | --- | --- |
| AC-01 | **Alta** | Proteção das rotas operacionais ocorre apenas no cliente e confia em sessão no `localStorage`. | Um visitante pode fabricar um objeto local e renderizar telas protegidas. Isso não deveria liberar dados reais se RLS remoto estiver correto, mas permite bypass da barreira de navegação e aumenta risco caso alguma tela futura exponha dados sem RLS. | `AuthGate` usa `getCurrentSession()`; `getCurrentSession()` valida somente campos estruturais locais; middleware somente atualiza sessão. | Antes do piloto, impor verificação server-side de usuário Supabase nas rotas conectadas e manter uma exceção explícita, isolada e documentada para demo. |
| AC-02 | **Alta** | Usuário Supabase autenticado sem workspace ativo recebe fallback demonstrativo marcado como `mode: "supabase"`. | Mistura semântica entre conectado e demo; UI pode indicar modo real e disparar adaptadores reais com workspace demo, dificultando diagnóstico e validação de isolamento. | Branch de fallback em `resolveSupabaseSession()`. | Falhar fechado: negar entrada conectada sem membership ativa e exibir orientação administrativa. |
| AC-03 | **Alta** | Aplicação efetiva de RLS no projeto remoto não é comprovável pelo repositório. | Se migrations não tiverem sido executadas, a anon key pública pode expor dados conforme a configuração remota. | Migration de hardening declara execução manual pré-release. | Executar checklist remoto, confirmar migrations aplicadas e rodar testes positivos/negativos com usuários de workspaces e papéis diferentes. |
| AC-04 | **Média** | Demonstração e Supabase compartilham os mesmos paths; distinção depende de estado local. | A arquitetura é menos fácil de auditar e testar do que namespaces separados; regressões podem misturar fontes se um helper for usado incorretamente. | `protectedRoutes` único; `shouldUseWorkspaceSupabase()` depende do espelho local. | Para evolução futura, considerar boundary explícito de modo no servidor ou namespace demo dedicado. Não é necessário mudar layout. |
| AC-05 | **Média** | Sessão local Supabase pode permanecer obsoleta após revogação/expiração. | UI conectada pode continuar aparente até a próxima resposta RLS; experiência inconsistente e risco de implementação futura confiar indevidamente no espelho local. | Sessão é persistida no `localStorage`; gate não revalida `auth.getUser()`. | Revalidar sessão e membership ativa no acesso protegido e limpar espelho local ao falhar. |
| AC-06 | **Média** | Dados digitados na demo persistem em `localStorage`. | Em máquina compartilhada, informação inserida por engano pode permanecer localmente. | Módulos demo persistem localmente; sessão demo também persiste localmente. | Proibir uso de dados reais na demo, usar perfil temporário e adicionar procedimento operacional de limpeza entre apresentações. |
| AC-07 | **Baixa** | Alternativa `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` é aceita pelo código, mas não aparece em `.env.example`. | Configuração operacional pode ficar ambígua ao migrar de anon key para publishable key. | Clientes Supabase possuem fallback; arquivo de exemplo lista apenas anon key. | Documentar a alternativa em etapa futura de documentação/configuração. |

## 10. Recomendações para pré-piloto

### 10.1 Bloqueadores antes de dados reais

1. Implementar validação server-side nas rotas conectadas: usuário Supabase válido e membership ativa no workspace.
2. Alterar o fluxo conectado para falhar fechado quando não houver workspace ativo; nunca retornar fallback demo como sessão Supabase.
3. Confirmar no banco remoto que todas as migrations versionadas, especialmente `202605160300_security_hardening_rls.sql`, foram aplicadas.
4. Executar testes RLS remotos negativos e positivos:
   - sem login;
   - usuário autenticado sem membership;
   - membro inativo;
   - membro de outro workspace;
   - papéis sem acesso financeiro;
   - papéis sem acesso a relatórios estratégicos;
   - papéis sem gestão de prompts/configurações.
5. Validar que nenhuma tabela nova seja acessível por `anon` ou `authenticated` sem policy explícita e revisão de workspace.

### 10.2 Recomendações operacionais

1. Manter `LEXOS_DATA_SOURCE=demo` e `NEXT_PUBLIC_LEXOS_DATA_SOURCE=demo` nos ambientes puramente demonstrativos.
2. Usar somente `NEXT_PUBLIC_SUPABASE_ANON_KEY` ou `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` no frontend; nunca usar `service_role`.
3. Não digitar dados reais na demonstração; limpar storage do navegador após cada apresentação.
4. Separar contas de QA, piloto e demonstração; não reaproveitar credenciais pessoais.
5. Revisar usuários e memberships remotos antes de liberar escritório parceiro.
6. Repetir varredura de segredos, typecheck, build e testes E2E antes do release.
7. Registrar evidência da versão de migrations aplicada no ambiente do piloto.

## 11. Resultado objetivo por requisito

| Requisito | Resultado |
| --- | --- |
| Identificar rotas públicas e protegidas | Concluído nas seções 3.2 e 3.3. |
| Identificar autenticação/login | Concluído na seção 4. |
| Identificar páginas dependentes de Supabase | Concluído na seção 5. |
| Verificar demo sem login e sem dados sensíveis | Parcialmente validado por revisão estática: sem credenciais; fixtures aparentam fictícias; há persistência local e deve-se proibir dados reais. |
| Verificar área autenticada com sessão válida | **Não atendido integralmente na camada de rota**: banco deve depender de Supabase Auth + RLS, mas UI protegida confia em sessão local fabricável. |
| Verificar credenciais/chaves/dados sensíveis hardcoded | Nenhum segredo ou credencial real encontrado nos arquivos rastreados; fixtures fictícias existem intencionalmente. |
| Verificar variáveis Supabase | Concluído na seção 8. |
| Verificar risco de acesso indevido | Concluído na seção 9. |
| Documentar sem modificar comportamento | Concluído por este arquivo. |

## 12. Arquivos alterados por esta auditoria

- `docs/qa-security-access-audit.md` — novo documento técnico de QA/segurança.

## 13. Rodada de hardening de acesso implementada

**Data da implementação:** 2026-06-01

Esta seção registra a implementação posterior à revisão estática original. Ela substitui, para o estado atual do código, as conclusões anteriores que descreviam o middleware como apenas renovador de cookies e o fluxo conectado como permissivo para usuário sem workspace.

### 13.1 Mapa de rotas após o hardening

| Categoria | Rotas | Regra atual |
| --- | --- | --- |
| Públicas | `/`, `/login` | `/` redireciona para `/login`; `/login` continua disponível sem autenticação. |
| Demo local | mesmos paths operacionais listados abaixo, após entrada explícita pelo botão da demonstração em `/login` | A entrada demo grava sessão local fictícia e um marcador de acesso demo. O middleware aceita esse marcador sem consultar Supabase. Os adaptadores permanecem locais e não devem consultar endpoints Supabase. |
| Operação Supabase | `/dashboard`, `/clientes/**`, `/processos/**`, `/tarefas/**`, `/agenda/**`, `/financeiro/**`, `/relatorios/**`, `/central-lexos/**`, `/configuracoes/**`, `/socios/**`, `/onboarding/**`, `/minha-semana/**` | Sem marcador demo, o middleware permite acesso somente com usuário Supabase válido, membership ativa e workspace ativo. Qualquer ausência ou erro redireciona para `/login`. |

As URLs operacionais continuam compartilhadas para preservar navegação, layout, textos das abas e regras operacionais. A separação agora possui um boundary server-side explícito: demo local declarada ou operação Supabase validada. O marcador demo não concede acesso a dados reais; ele apenas seleciona a demonstração pública local, cujos dados são fictícios.

### 13.2 Mudanças implementadas

1. Foi criado um inventário reutilizável dos prefixos operacionais e do marcador demo em `src/lib/auth/routes.ts`, consumido pelo middleware e pelo gate cliente para evitar divergência de rotas.
2. O middleware foi posicionado em `src/middleware.ts`, diretório reconhecido pelo build desta aplicação Next.js baseada em `src/`, e passou a redirecionar acessos operacionais inválidos para `/login`.
3. Sem marcador demo, a validação server-side exige configuração Supabase, `auth.getUser()` válido, membership `active` e workspace com status `active`. Erros e ausências falham fechado.
4. A entrada demo passou a gravar um cookie marcador local; encerramento da sessão e tentativa de login conectado removem esse marcador. Enquanto ele estiver presente, a seleção cliente de fonte de dados também bloqueia adaptadores Supabase e força a demonstração local.
5. `resolveSupabaseSession()` deixou de criar fallback demonstrativo marcado como Supabase para usuário sem workspace. Agora retorna falha, e o login conectado encerra a sessão Supabase e não persiste espelho operacional.
6. `AuthGate` continua sendo uma defesa adicional no navegador: para sessões Supabase espelhadas, revalida usuário e workspace e limpa o espelho local em caso de falha. A barreira primária para entrada de rota passou a ser o middleware.
7. Nenhum componente visual, layout, texto de aba, schema, migration, policy RLS ou usuário Supabase foi alterado nesta rodada.

### 13.3 Comportamento antes e depois

| Cenário | Antes | Depois |
| --- | --- | --- |
| Acesso direto a `/dashboard` sem sessão | Middleware permitia renderização; `AuthGate` cliente redirecionava se não houvesse espelho local. | Middleware redireciona imediatamente para `/login`. |
| Objeto `mode: "supabase"` fabricado no `localStorage` | Podia atravessar o gate cliente estrutural. | Não atravessa o middleware sem sessão Supabase válida, membership ativa e workspace ativo. |
| Usuário Supabase válido sem membership ativa ou sem workspace ativo | Recebia fallback demo marcado como Supabase. | Login conectado falha fechado, encerra a sessão Supabase e não persiste sessão operacional local. |
| Demonstração local sem credenciais | Disponível após entrada explícita em `/login`. | Continua disponível da mesma forma e usa somente dados locais/fictícios. |
| Middleware em rota operacional conectada | Apenas renovava cookies Supabase. | Renova/valida sessão e exige usuário + membership ativa + workspace ativo; caso contrário redireciona para `/login`. |

### 13.4 Testes adicionados

O spec `tests/e2e/access-hardening.spec.ts` cobre:

- disponibilidade de `/login` e redirecionamento público de `/`;
- redirecionamento seguro de rotas operacionais sem sessão;
- bloqueio de espelho Supabase fabricado em `localStorage` sem sessão válida;
- continuidade da demo sem login/senha;
- ausência de requisições a hosts `*.supabase.co` durante entrada e navegação demo.

O comando `npm run test:e2e:demo` foi ampliado para incluir esse spec junto à regressão da release candidate demo.

### 13.5 Riscos ainda pendentes

1. **RLS remoto deve continuar sendo validado antes do piloto.** Esta rodada não altera policies nem comprova migrations aplicadas no projeto hospedado.
2. **O marcador demo é intencionalmente um seletor público, não uma credencial.** Qualquer pessoa pode entrar na demonstração fictícia; ele nunca deve ser usado para autorizar leitura de Supabase.
3. **As URLs continuam compartilhadas.** O boundary server-side reduz o risco sem mudar navegação, mas um namespace `/demo/**` dedicado ainda pode ser considerado em evolução futura.
4. **Dados inseridos manualmente na demo persistem localmente.** Continua necessário proibir dados reais em apresentações e limpar storage em máquinas compartilhadas.
5. **Testes remotos autenticados e negativos continuam necessários.** Devem cobrir memberships inativas, usuários de workspaces diferentes, revogação de sessão e papéis restritos no projeto Supabase do piloto.
