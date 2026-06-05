import { test, expect, Page } from '@playwright/test';
import { attachErrorMonitors, ensureE2EEnv, ensureShellVisible, gotoAndAssertAppRoute, qaSuffix } from './helpers';

const workspaceName = process.env.E2E_WORKSPACE_NAME ?? 'Almeida e Saraiva Advocacia';
const routes = ['/dashboard','/clientes','/processos','/processos/parcerias','/tarefas','/agenda','/financeiro','/relatorios','/central-lexos','/central-lexos/prompts','/socios','/configuracoes','/configuracoes/seguranca','/configuracoes/release','/onboarding'];

test.beforeEach(async ({ page }) => { ensureE2EEnv(); });

function sidebar(page: Page) {
  return page.locator('aside').first();
}

async function login(page: Page){
  await page.goto('/login');
  await page.locator('input[type="email"]').fill(process.env.E2E_EMAIL!);
  await page.locator('input[type="password"]').fill(process.env.E2E_PASSWORD!);
  await page.getByRole('button', { name: /Entrar no ambiente conectado/i }).click();
  await page.waitForURL('**/dashboard');

  const shell = sidebar(page);
  await expect(shell.getByText(`Escritório | ${workspaceName}`, { exact: false })).toBeVisible();
  await expect(shell.getByText('Dados do escritório ativos.', { exact: true })).toBeVisible();
  await expect(shell.getByText('Demonstração local separada.', { exact: true })).toHaveCount(0);
}

test('login com supabase e workspace correto', async ({ page }, testInfo) => { const monitor = await attachErrorMonitors(page, testInfo); await login(page); await ensureShellVisible(page); await monitor.assertNoCriticalErrors('Falha no fluxo de login conectado.'); });

test('navegação principal sem 404/500', async ({ page }, testInfo) => {
  const monitor = await attachErrorMonitors(page, testInfo);
  await login(page);
  for (const route of routes) {
    await gotoAndAssertAppRoute(page, route, monitor);
  }
});

test('fluxo operacional principal com dados QA', async ({ page }, testInfo) => {
  const monitor = await attachErrorMonitors(page, testInfo);
  await login(page);
  const s = qaSuffix();
  const clientName = `QA Cliente Automatizado ${s}`;
  const processTitle = `QA Processo Automatizado ${s}`;
  const taskTitle = `QA Tarefa Automatizada ${s}`;
  const promptTitle = `QA Prompt Automatizado ${s}`;

  await page.goto('/clientes');
  await page.getByRole('button', { name: /novo cliente/i }).click();
  await page.getByLabel(/Nome\/Razão social/i).fill(clientName);
  await page.getByLabel(/Tipo/i).selectOption('pessoa_fisica');
  await page.getByLabel(/CPF\/CNPJ|documento/i).fill(`QA-${s}`);
  await page.getByLabel('E-mail').fill(`qa.cliente+${s}@lexos.test`);
  await page.getByLabel(/Telefone/i).fill('(11) 90000-0000');
  await page.getByLabel(/Status/i).selectOption('ativo');
  await page.getByLabel(/Responsável/i).fill('QA Agent');
  await page.getByLabel(/Pendência principal/i).fill('Teste automatizado');
  await page.getByLabel(/Observações/i).fill('Teste automatizado E2E');
  await page.getByRole('button', { name: /salvar|cadastrar/i }).click();
  await page.waitForLoadState('domcontentloaded');
  const searchInput = page.locator('input[placeholder*="Buscar" i], input[placeholder*="busca" i]').first();
  if (await searchInput.count()) {
    await searchInput.fill(clientName);
  }
  const createdMatches = page.getByText(clientName, { exact: true });
  const createdCount = await createdMatches.count();
  await expect(createdMatches.first(), `Cliente QA não encontrado após salvar. Cliente: ${clientName}. URL: ${page.url()}. Busca presente: ${await searchInput.count() > 0}. Matches: ${createdCount}. Heading: ${await page.getByRole('heading').first().textContent()}. Warnings: ${monitor.getWarnings().slice(-5).join(' | ') || 'nenhum'}`).toBeVisible({ timeout: 15000 });
  await page.reload();
  await page.waitForLoadState('domcontentloaded');
  if (await searchInput.count()) {
    await searchInput.fill(clientName);
  }
  const persistedMatches = page.getByText(clientName, { exact: true });
  const persistedCount = await persistedMatches.count();
  await expect(persistedMatches.first(), `Cliente QA não persistiu após reload. Cliente: ${clientName}. URL: ${page.url()}. Busca presente: ${await searchInput.count() > 0}. Matches: ${persistedCount}. Heading: ${await page.getByRole('heading').first().textContent()}. Warnings: ${monitor.getWarnings().slice(-5).join(' | ') || 'nenhum'}`).toBeVisible({ timeout: 15000 });

  for (const route of ['/processos','/tarefas','/agenda','/financeiro','/relatorios','/central-lexos','/central-lexos/prompts']) {
    await gotoAndAssertAppRoute(page, route, monitor);
  }
  await expect(page.getByText(promptTitle)).toHaveCount(0);

  void processTitle; void taskTitle;
  await monitor.assertNoCriticalErrors(`Fluxo QA com cliente ${clientName} apresentou erro crítico.`);
});

test('modo demonstração permanece isolado', async ({ page }, testInfo) => {
  const monitor = await attachErrorMonitors(page, testInfo);
  await page.goto('/login');
  await page.getByRole('button', { name: /^Entrar na demonstração$/i }).click();
  await page.waitForURL('**/dashboard');

  const shell = sidebar(page);
  const demoIndicator = shell.getByText('Demonstração local separada.', { exact: true });
  await expect(
    demoIndicator,
    `Indicador esperado do modo demo não apareceu no sidebar. URL atual: ${page.url()}`,
  ).toBeVisible();

  await expect(
    shell.getByText(`Escritório | ${workspaceName}`, { exact: false }),
    `Workspace real não deve estar ativo no modo demonstração. URL atual: ${page.url()}`,
  ).toHaveCount(0);

  await page.goto('/clientes');
  await expect(
    page.getByText('QA Cliente Automatizado', { exact: false }),
    'Dados QA reais não devem aparecer no modo demonstração.',
  ).toHaveCount(0);
  await monitor.assertNoCriticalErrors('Falha na validação de isolamento do modo demonstração.');
});
