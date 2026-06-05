const $ = (selector) => document.querySelector(selector);
const $$ = (selector) => [...document.querySelectorAll(selector)];

const state = {
  view: "dashboard",
  conversation: "oliveira",
};

const views = {
  dashboard: ["CENTRAL OPERACIONAL", "Visão geral"],
  atendimento: ["ATENDIMENTO VIVO", "Conversas"],
  casos: ["CARTEIRA JURÍDICA", "Casos"],
  clientes: ["BASE DE RELACIONAMENTO", "Clientes"],
  agenda: ["AGENDA JURÍDICA", "Agenda"],
  tarefas: ["CENTRAL DE EXECUÇÃO", "Tarefas"],
  agentes: ["AUTOMAÇÕES GOVERNADAS", "Agentes"],
  financeiro: ["CONTROLE FINANCEIRO", "Financeiro"],
  documentos: ["REPOSITÓRIO CONTROLADO", "Documentos"],
  auditoria: ["TRILHA OPERACIONAL", "Auditoria"],
  configuracoes: ["CONFIGURAÇÃO", "Preferências"],
};

const metrics = [
  ["Casos ativos", "42", "12 exigem acompanhamento nos próximos 7 dias", "briefcase-business"],
  ["Conversas vivas", "18", "4 aguardam intervenção humana", "messages-square"],
  ["Prazos críticos", "7", "3 vencem até amanhã", "alarm-clock"],
  ["Automações", "11", "9 operando em modo assistido", "bot"],
];

const cases = [
  ["LEX-2026-041", "Rescisão contratual Oliveira", "Contratual", "Mariana Castro", "Em andamento", "Alta", "03 jun"],
  ["LEX-2026-040", "Reclamação trabalhista Santos", "Trabalhista", "Lucas Almeida", "Prazo crítico", "Crítica", "02 jun"],
  ["LEX-2026-039", "Revisão societária Vega", "Empresarial", "Carolina Reis", "Revisão humana", "Normal", "07 jun"],
  ["LEX-2026-038", "Ação indenizatória Martins", "Cível", "Mariana Castro", "Aguardando cliente", "Normal", "10 jun"],
  ["LEX-2026-037", "Regularização tributária Atlas", "Tributário", "Paulla Soares", "Em andamento", "Alta", "11 jun"],
];

const clients = [
  ["Oliveira & Ramos Ltda.", "Pessoa jurídica", "Fernanda Oliveira", "(85) 98888-1201", "Cliente ativo"],
  ["Grupo Santos", "Pessoa jurídica", "Ricardo Santos", "(85) 98777-4510", "Cliente ativo"],
  ["Helena Martins", "Pessoa física", "Helena Martins", "(85) 99128-9044", "Triagem"],
  ["Vega Participações", "Pessoa jurídica", "Clara Vega", "(85) 98665-1142", "Cliente ativo"],
  ["Atlas Serviços", "Pessoa jurídica", "Gustavo Nunes", "(85) 99932-2285", "Cliente ativo"],
];

const conversations = {
  oliveira: {
    initials: "FO",
    name: "Fernanda Oliveira",
    company: "Oliveira & Ramos Ltda.",
    state: "Agente respondendo",
    owner: "Agente LEX.OS",
    caseId: "LEX-2026-041",
    summary: "Cliente enviou a última versão contratual e quer confirmar suficiência dos anexos.",
    messages: [
      ["contact", "Bom dia. Enviamos a última versão do contrato e os anexos para análise.", "10:31"],
      ["agent", "Bom dia, Fernanda. Recebi os arquivos e já vinculei ao atendimento.", "10:33"],
      ["contact", "Consegue confirmar se faltou algum documento?", "10:42"],
    ],
  },
  helena: {
    initials: "HM",
    name: "Helena Martins",
    company: "Pessoa física",
    state: "Revisão humana",
    owner: "Mariana Castro",
    caseId: "LEX-2026-038",
    summary: "Triagem recebeu comprovantes complementares. Próxima resposta depende da equipe.",
    messages: [
      ["agent", "Helena, para concluir a triagem precisamos dos comprovantes mencionados.", "08:46"],
      ["contact", "Consegui separar os comprovantes. Posso encaminhar por aqui?", "09:18"],
    ],
  },
  santos: {
    initials: "RS",
    name: "Ricardo Santos",
    company: "Grupo Santos",
    state: "Aguardando equipe",
    owner: "Lucas Almeida",
    caseId: "LEX-2026-040",
    summary: "Cliente solicitou confirmação de reunião sobre a defesa trabalhista.",
    messages: [
      ["contact", "Podemos confirmar a reunião de amanhã pela manhã?", "Ontem, 16:20"],
      ["agent", "Vou validar a disponibilidade da equipe responsável e retorno.", "Ontem, 16:21"],
    ],
  },
};

const tasks = [
  ["Revisar defesa trabalhista", "LEX-2026-040 · vence hoje às 17h", "Crítica"],
  ["Validar documentos societários", "LEX-2026-039 · vence amanhã", "Alta"],
  ["Confirmar reunião com cliente", "LEX-2026-041 · hoje às 15h", "Normal"],
  ["Solicitar comprovantes pendentes", "LEX-2026-038 · vence em 2 dias", "Normal"],
];

const appointments = [
  ["01", "JUN", "Reunião estratégica · Oliveira & Ramos", "15:00 · Videoconferência · Mariana Castro"],
  ["02", "JUN", "Prazo para defesa · Grupo Santos", "17:00 · LEX-2026-040 · Lucas Almeida"],
  ["03", "JUN", "Audiência inicial · Helena Martins", "09:30 · Fórum Central · Mariana Castro"],
  ["05", "JUN", "Revisão societária · Vega Participações", "11:00 · Escritório · Carolina Reis"],
];

const audits = [
  ["10:42", "Mensagem classificada", "Conversa FO vinculada ao caso LEX-2026-041"],
  ["09:58", "Ação bloqueada", "Resposta com orientação técnica exige revisão humana"],
  ["09:31", "Documento consultado", "Comprovantes recebidos.zip acessado por Mariana"],
  ["08:12", "Automação executada", "Follow-up interno gerado para prazo trabalhista"],
];

function icon(name) {
  return `<i data-lucide="${name}"></i>`;
}

function statusClass(value) {
  if (/crítica|prazo|bloqueada/i.test(value)) return "is-danger";
  if (/revisão|triagem|aguardando/i.test(value)) return "is-warning";
  if (/ativo|andamento|respondendo|executada/i.test(value)) return "is-ok";
  return "";
}

function showApp() {
  $("#login-screen").hidden = true;
  $("#app-shell").hidden = false;
  const route = location.hash.replace("#", "") || "dashboard";
  renderView(views[route] ? route : "dashboard");
}

function showLogin() {
  $("#login-screen").hidden = false;
  $("#app-shell").hidden = true;
}

function navigate(view) {
  location.hash = view;
  renderView(view);
}

function renderView(view) {
  state.view = views[view] ? view : "dashboard";
  const [eyebrow, title] = views[state.view];
  $("#view-eyebrow").textContent = eyebrow;
  $("#view-title").textContent = title;
  $("#view-root").innerHTML = renderers[state.view]();
  $("#view-root").classList.remove("is-entering");
  requestAnimationFrame(() => $("#view-root").classList.add("is-entering"));
  $$("[data-view]").forEach((button) => button.classList.toggle("is-active", button.dataset.view === state.view));
  lucide.createIcons();
}

const renderers = {
  dashboard() {
    return `
      <section class="welcome-row">
        <div><p class="eyebrow">OPERAÇÃO EM TEMPO REAL</p><h2>Uma central para operar <em>casos, prazos e atendimento</em> com menos ruído.</h2></div>
        <span class="today-tag">05 JUN 2026 · AMÉRICA/FORTALEZA</span>
      </section>
      <section class="metric-grid">${metrics.map(([label, value, detail, iconName]) => `
        <article class="metric-card">
          <span class="metric-label">${icon(iconName)}${label}</span>
          <strong class="metric-value">${value}</strong>
          <p class="metric-detail">${detail}</p>
        </article>`).join("")}</section>
      <section class="dashboard-grid" style="margin-top:12px">
        <article class="panel"><div class="panel-heading"><div><h3>Prioridades do dia</h3><small>Prazos, conversas e aprovações em ordem operacional</small></div></div><ul class="list">${tasks.map(([title, meta, priority]) => `<li class="list-item"><strong>${title}</strong><small>${meta}</small><span class="priority ${priority === "Crítica" ? "is-high" : ""}">${priority}</span></li>`).join("")}</ul></article>
        <aside class="panel"><div class="panel-heading"><div><h3>Governança</h3><small>Regras permanentes do ambiente</small></div></div><ul class="list"><li class="list-item"><strong>IA assistida</strong><small>Mensagens jurídicas seguem para revisão humana.</small></li><li class="list-item"><strong>Documentos protegidos</strong><small>Arquivos sigilosos não saem por canais externos automaticamente.</small></li><li class="list-item"><strong>Auditoria ativa</strong><small>Ações críticas ficam registradas com responsável e horário.</small></li></ul></aside>
      </section>`;
  },
  atendimento() {
    const current = conversations[state.conversation] || conversations.oliveira;
    return `
      <section class="section-heading"><div><p class="eyebrow">WHATSAPP CONECTADO · INSTAGRAM EM PREPARAÇÃO</p><h2>Atendimento vivo</h2><p>Acompanhe agentes, assuma conversas sensíveis e refine respostas antes do envio.</p></div><button class="secondary-button" type="button" data-view="agentes">${icon("sliders-horizontal")} Regras do agente</button></section>
      <section class="service-shell">
        <aside class="inbox-pane">
          <div class="inbox-toolbar"><div><h3>Conversas</h3><small>Filtradas por atenção</small></div><span class="status is-ok">online</span></div>
          <div class="compact-search">${icon("search")}<input placeholder="Buscar conversa" /></div>
          <ul class="conversation-list">${Object.entries(conversations).map(([id, entry]) => `<li><button class="conversation-item ${id === state.conversation ? "is-selected" : ""}" type="button" data-conversation="${id}"><span class="conversation-avatar">${entry.initials}</span><span class="conversation-copy"><strong>${entry.name}</strong><small>${entry.company}</small></span></button></li>`).join("")}</ul>
        </aside>
        <section class="chat-pane">
          <div class="chat-header"><div><h3>${current.name}</h3><small>${current.company} · ${current.caseId}</small></div><span class="status ${statusClass(current.state)}">${current.state}</span></div>
          <div class="chat-thread">${current.messages.map(([who, text, time]) => `<article class="chat-message ${who === "agent" ? "is-agent" : who === "human" ? "is-human" : ""}"><span class="chat-author">${who === "agent" ? "Agente LEX.OS" : current.name}</span><p>${text}</p><time>${time}</time></article>`).join("")}</div>
          <form class="chat-composer"><label>Resposta assistida</label><div><textarea rows="3" placeholder="Rascunhe uma resposta para revisão"></textarea><button class="primary-button" type="submit">${icon("send-horizontal")}</button></div><small class="muted">Nenhuma mensagem externa é enviada sem validação.</small></form>
        </section>
        <aside class="context-pane">
          <div class="context-section"><p class="eyebrow">CONTEXTO</p><h3>${current.caseId}</h3><p class="muted">${current.summary}</p></div>
          <div class="context-section"><h3>Responsável</h3><span class="tag is-gold">${current.owner}</span></div>
          <div class="context-section"><h3>Ações rápidas</h3><button class="quiet-button" type="button" data-open-drawer="conversation">${icon("arrow-up-right")} Ver detalhes</button></div>
        </aside>
      </section>`;
  },
  casos() {
    return tableView("Casos e processos", "Organize demandas judiciais e extrajudiciais com responsáveis, prioridade, prazos e histórico auditável.", ["CASO", "ÁREA", "RESPONSÁVEL", "STATUS", "PRIORIDADE", "PRAZO"], cases);
  },
  clientes() {
    return tableView("Clientes", "Base de relacionamento para clientes, empresas, partes e contatos de triagem.", ["NOME", "TIPO", "CONTATO", "TELEFONE", "SITUAÇÃO"], clients);
  },
  agenda() {
    return `<section class="section-heading"><div><p class="eyebrow">AGENDA JURÍDICA</p><h2>Junho de 2026</h2><p>Compromissos, audiências, diligências e prazos reunidos em uma visão operacional.</p></div><button class="primary-button" type="button" data-open-modal="appointment">${icon("calendar-plus")} Novo compromisso</button></section><section class="split-grid"><article class="panel"><div class="panel-heading"><div><h3>Próximos eventos</h3><small>Ordenados por vencimento</small></div></div><ul class="list">${appointments.map(([date, month, title, meta]) => `<li class="list-item"><span class="tag">${date} ${month}</span><strong>${title}</strong><small>${meta}</small></li>`).join("")}</ul></article><aside class="panel"><div class="panel-heading"><div><h3>Regras</h3><small>Proteções da agenda</small></div></div><ul class="list"><li class="list-item"><strong>Meet automático</strong><small>Gerado apenas quando o evento for aprovado.</small></li><li class="list-item"><strong>Follow-up</strong><small>Lembretes externos exigem confirmação humana.</small></li></ul></aside></section>`;
  },
  tarefas() {
    return cardGrid("Tarefas", "Providências internas organizadas por prioridade e vencimento.", tasks.map(([title, meta, priority]) => [title, meta, priority]));
  },
  agentes() {
    return cardGrid("Agentes e automações", "Controle regras, handoff humano, limites de resposta e workflows conectados.", [
      ["Assessora LEX.OS", "Grupo interno, agenda, despesas, Drive e follow-ups", "Homologação"],
      ["Atendimento jurídico", "Triagem WhatsApp com revisão humana", "Ativo"],
      ["Disparos controlados", "Campanhas sob responsabilidade do cliente", "Bloqueado"],
      ["Monitor de integrações", "n8n, Evolution, Supabase e Google", "Preparando"],
    ]);
  },
  financeiro() {
    return cardGrid("Financeiro", "Assinaturas, despesas recorrentes, planos e auditoria de cobrança.", [
      ["Receita recorrente", "R$ 18.420 previstos no ciclo atual", "Projetado"],
      ["Despesas registradas", "GPT, Vercel, Supabase e infraestrutura", "Auditar"],
      ["Clientes em análise", "4 contas aguardando validação de plano", "Atenção"],
    ]);
  },
  documentos() {
    return cardGrid("Documentos", "Arquivos vinculados aos casos com acesso restrito e trilha de consulta.", [
      ["Contrato social consolidado.pdf", "LEX-2026-039 · sigiloso", "Equipe do caso"],
      ["Notificação extrajudicial.docx", "LEX-2026-041 · minuta", "Revisão"],
      ["Comprovantes recebidos.zip", "LEX-2026-038 · anexos", "Restrito"],
    ]);
  },
  auditoria() {
    return `<section class="section-heading"><div><p class="eyebrow">TRILHA OPERACIONAL</p><h2>Auditoria</h2><p>Eventos críticos registrados para rastreabilidade e governança.</p></div><button class="secondary-button" type="button" data-action="export-audit">${icon("download")} Exportar</button></section><article class="panel"><ul class="list">${audits.map(([time, title, detail]) => `<li class="timeline-item"><span class="tag">${time}</span><strong>${title}</strong><small>${detail}</small></li>`).join("")}</ul></article>`;
  },
  configuracoes() {
    return `<section class="section-heading"><div><p class="eyebrow">CONFIGURAÇÃO</p><h2>Preferências</h2><p>Parâmetros de ambiente, segurança e comportamento visual.</p></div></section><form class="split-grid"><section class="panel"><div class="panel-heading"><div><h3>Operação</h3><small>Dados demonstrativos para integração futura</small></div></div><label><span>Unidade</span><input value="LEX.OS Advocacia" /></label><label><span>Timezone</span><input value="America/Fortaleza" /></label><label><span>Modo de IA</span><select><option>Assistido com aprovação humana</option></select></label></section><aside class="panel"><div class="panel-heading"><div><h3>Segurança</h3><small>Regras permanentes</small></div></div><ul class="list"><li class="list-item"><strong>RLS obrigatório</strong><small>Dados reais exigem políticas por usuário e organização.</small></li><li class="list-item"><strong>Service role fora do frontend</strong><small>Chaves administrativas ficam somente no servidor.</small></li></ul></aside></form>`;
  },
};

function tableView(title, description, heads, rows) {
  return `<section class="section-heading"><div><p class="eyebrow">GESTÃO JURÍDICA</p><h2>${title}</h2><p>${description}</p></div><button class="primary-button" type="button" data-open-modal="record">${icon("plus")} Novo registro</button></section><div class="table-shell"><table class="data-table"><thead><tr>${heads.map((head) => `<th>${head}</th>`).join("")}<th></th></tr></thead><tbody>${rows.map((row, index) => `<tr>${row.map((cell, cellIndex) => `<td>${cellIndex === 3 || cellIndex === 4 ? `<span class="${cellIndex === 4 ? "priority" : "status"} ${statusClass(cell)}">${cell}</span>` : cell}</td>`).join("")}<td><button class="quiet-button" type="button" data-open-row="${index}">${icon("arrow-up-right")}</button></td></tr>`).join("")}</tbody></table></div>`;
}

function cardGrid(title, description, entries) {
  return `<section class="section-heading"><div><p class="eyebrow">CONTROLE</p><h2>${title}</h2><p>${description}</p></div><button class="primary-button" type="button" data-open-modal="record">${icon("plus")} Novo</button></section><section class="card-grid">${entries.map(([title, detail, state]) => `<article class="panel data-card"><div class="panel-heading"><div><h3>${title}</h3><small>${detail}</small></div><span class="status ${statusClass(state)}">${state}</span></div><p class="muted">Detalhes ficam disponíveis sob demanda para reduzir poluição visual e preservar foco operacional.</p><button class="quiet-button" type="button" data-open-drawer="${title}">${icon("arrow-up-right")} Detalhes</button></article>`).join("")}</section>`;
}

function openDrawer(contentKey) {
  $("#drawer-content").innerHTML = `<p class="eyebrow">DETALHE</p><h2 class="drawer-title">${contentKey}</h2><p class="muted">Painel demonstrativo para concentrar informação secundária fora da tela principal.</p><div class="drawer-grid"><article class="mini-card"><span>STATUS</span><strong>Em análise</strong></article><article class="mini-card"><span>RESPONSÁVEL</span><strong>Equipe LEX.OS</strong></article><article class="mini-card"><span>PRIORIDADE</span><strong>Normal</strong></article><article class="mini-card"><span>AUDITORIA</span><strong>Ativa</strong></article></div><button class="primary-button" type="button">Abrir fluxo completo</button>`;
  $("#detail-drawer").classList.add("is-open");
  $("#detail-drawer").setAttribute("aria-hidden", "false");
  $("#close-drawer").focus();
}

function closeDrawer() {
  $("#detail-drawer").classList.remove("is-open");
  $("#detail-drawer").setAttribute("aria-hidden", "true");
}

function openModal() {
  $("#entity-modal").hidden = false;
  requestAnimationFrame(() => $("#entity-modal input")?.focus());
}

function closeModal() {
  $("#entity-modal").hidden = true;
}

function showToast(message) {
  const toast = $("#toast");
  toast.textContent = message;
  toast.classList.add("is-visible");
  clearTimeout(showToast.timer);
  showToast.timer = setTimeout(() => toast.classList.remove("is-visible"), 3000);
}

function openCommands() {
  const commands = [
    ["Atendimento", "Abrir conversas em tempo real", "atendimento", "messages-square"],
    ["Novo caso", "Cadastrar demanda jurídica", "", "briefcase-business"],
    ["Agenda", "Ver compromissos e prazos", "agenda", "calendar-days"],
    ["Agentes", "Configurar automações assistidas", "agentes", "bot"],
  ];
  $("#command-results").innerHTML = commands.map(([title, detail, view, iconName]) => `<button class="command-item" type="button" data-command-view="${view}">${icon(iconName)}<span><strong>${title}</strong><small>${detail}</small></span></button>`).join("");
  $("#command-palette").hidden = false;
  requestAnimationFrame(() => $("#command-input").focus());
  lucide.createIcons();
}

function closeCommands() {
  $("#command-palette").hidden = true;
}

document.addEventListener("click", (event) => {
  const viewButton = event.target.closest("[data-view]");
  const conversationButton = event.target.closest("[data-conversation]");
  const openDrawerButton = event.target.closest("[data-open-drawer], [data-open-row]");
  const modalButton = event.target.closest("[data-open-modal]");
  const closeModalButton = event.target.closest("[data-close-modal]");
  const commandButton = event.target.closest("[data-command-view]");
  const actionButton = event.target.closest("[data-action]");

  if (viewButton) navigate(viewButton.dataset.view);
  if (conversationButton) { state.conversation = conversationButton.dataset.conversation; renderView("atendimento"); }
  if (openDrawerButton) openDrawer(openDrawerButton.dataset.openDrawer || "Registro");
  if (modalButton) openModal();
  if (closeModalButton) closeModal();
  if (commandButton) { closeCommands(); commandButton.dataset.commandView ? navigate(commandButton.dataset.commandView) : openModal(); }
  if (actionButton?.dataset.action === "notifications") openDrawer("Notificações");
  if (actionButton?.dataset.action === "workspace") showToast("Unidade principal selecionada.");
  if (actionButton?.dataset.action === "mobile-menu") openDrawer("Menu completo");
  if (actionButton?.dataset.action === "export-audit") showToast("Exportação demonstrativa registrada.");
});

document.addEventListener("submit", (event) => {
  event.preventDefault();
  if (event.target.id === "login-form") showApp();
  else { closeModal(); showToast("Registro salvo no ambiente demonstrativo."); }
});

document.addEventListener("keydown", (event) => {
  if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === "k") {
    event.preventDefault();
    openCommands();
  }
  if (event.key === "Escape") {
    closeCommands();
    closeModal();
    closeDrawer();
  }
});

document.addEventListener("pointermove", (event) => {
  document.documentElement.style.setProperty("--mouse-x", `${event.clientX}px`);
  document.documentElement.style.setProperty("--mouse-y", `${event.clientY}px`);
});

$("#close-drawer").addEventListener("click", closeDrawer);
$("#search-trigger").addEventListener("click", openCommands);
$("#mobile-search").addEventListener("click", openCommands);
$("#command-palette").addEventListener("click", (event) => { if (event.target === event.currentTarget) closeCommands(); });
$("#entity-modal").addEventListener("click", (event) => { if (event.target === event.currentTarget) closeModal(); });
$("[data-demo-login]").addEventListener("click", showApp);

window.addEventListener("hashchange", () => {
  const route = location.hash.replace("#", "") || "dashboard";
  if (!$("#app-shell").hidden) renderView(views[route] ? route : "dashboard");
});

if (location.pathname.includes("login")) showLogin();
else showApp();

lucide.createIcons();
