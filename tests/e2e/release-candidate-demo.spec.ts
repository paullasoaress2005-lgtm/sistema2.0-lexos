import { expect, test, type Page, type Request } from '@playwright/test';
import { attachErrorMonitors, gotoAndAssertAppRoute } from './helpers';

const pilotRoutes = [
  '/dashboard',
  '/clientes',
  '/processos',
  '/tarefas',
  '/agenda',
  '/financeiro',
  '/central-lexos',
  '/socios',
  '/relatorios',
  '/configuracoes',
  '/configuracoes/release',
  '/onboarding',
] as const;

const sidebarEntries = [
  ['Visão Geral', '/dashboard'],
  ['Clientes', '/clientes'],
  ['Processos', '/processos'],
  ['Tarefas', '/tarefas'],
  ['Agenda', '/agenda'],
  ['Financeiro', '/financeiro'],
  ['Central LEX.OS', '/central-lexos'],
  ['Painel dos Sócios', '/socios'],
  ['Relatórios', '/relatorios'],
  ['Configurações', '/configuracoes'],
  ['Implantação', '/configuracoes/release'],
  ['Primeiros passos', '/onboarding'],
] as const;

const notebook = { width: 1366, height: 768 };
const largeMonitor = { width: 1920, height: 1080 };
const demoClientsStorageKey = 'lexos.control.demo.clients.workspace-demo-moraes-brito';

function isLocalApplicationRequest(request: Request) {
  const url = new URL(request.url());
  return ['127.0.0.1', 'localhost'].includes(url.hostname);
}

async function enterSafeDemo(page: Page) {
  await page.goto('/login');
  await page.getByRole('button', { name: /^Entrar na demonstração$/i }).click();
  await page.waitForURL('**/dashboard');
  await expect(page.getByRole('navigation').getByText('Demonstração local separada.', { exact: true })).toBeVisible();
}

async function expectNoHorizontalPageOverflow(page: Page, route: string) {
  const sizes = await page.evaluate(() => ({
    clientWidth: document.documentElement.clientWidth,
    scrollWidth: document.documentElement.scrollWidth,
  }));
  expect(sizes.scrollWidth, `Overflow horizontal global em ${route}: ${sizes.scrollWidth}px para viewport de ${sizes.clientWidth}px.`)
    .toBeLessThanOrEqual(sizes.clientWidth + 1);
}

test.describe('RC do piloto controlado em demonstração local', () => {
  test('navegação de todas as abas preserva shell, conteúdo e isolamento externo', async ({ page }, testInfo) => {
    const monitor = await attachErrorMonitors(page, testInfo);
    const externalRequests: string[] = [];
    page.on('request', (request) => {
      if (!isLocalApplicationRequest(request)) externalRequests.push(request.url());
    });

    await enterSafeDemo(page);
    const navigation = page.getByRole('navigation');

    for (const [label, route] of sidebarEntries) {
      const link = navigation.getByRole('link', { name: label, exact: true });
      await expect(link, `Aba ${label} ausente da navegação principal.`).toBeVisible();
      await link.click();
      await expect(page).toHaveURL(new RegExp(`${route.replaceAll('/', '\\/')}$`));
      await expect(page.locator('main')).not.toBeEmpty();
    }

    expect(externalRequests, `O modo demonstração não deve enviar requisições externas automaticamente: ${externalRequests.join(', ')}`).toEqual([]);
    await monitor.assertNoCriticalErrors('Navegação principal da RC apresentou erro crítico.');
  });

  for (const viewport of [notebook, largeMonitor]) {
    test(`abas permanecem legíveis e sem quebra visual em ${viewport.width}x${viewport.height}`, async ({ page }, testInfo) => {
      const monitor = await attachErrorMonitors(page, testInfo);
      await page.setViewportSize(viewport);
      await enterSafeDemo(page);

      for (const route of pilotRoutes) {
        await gotoAndAssertAppRoute(page, route, monitor);
        await expectNoHorizontalPageOverflow(page, route);
      }
    });
  }

  test('clientes suporta volume, filtros, estado vazio, nome longo e persistência local', async ({ page }, testInfo) => {
    const monitor = await attachErrorMonitors(page, testInfo);
    const longClientName = `Sociedade Empresária de Participações Estratégicas e Recuperação de Ativos Patrimoniais Horizonte ${Date.now()}`;
    await enterSafeDemo(page);
    await page.goto('/clientes');

    const previousClients = await page.evaluate((key) => window.localStorage.getItem(key), demoClientsStorageKey);
    const search = page.getByPlaceholder(/Buscar por nome, documento, responsável ou pendência/i);
    expect(await page.locator('article').count(), 'A carteira demonstrativa deve representar um estado com múltiplos registros.').toBeGreaterThan(2);

    const primaryAction = page.getByRole('button', { name: 'Cadastrar cliente', exact: true }).first();
    const secondaryAction = page.getByRole('button', { name: 'Limpar filtros', exact: true });
    const destructiveAction = page.getByRole('button', { name: 'Arquivar cliente', exact: true }).first();
    await expect(primaryAction).toHaveClass(/bg-lexos-gold/);
    await expect(secondaryAction).toHaveClass(/border-lexos-line/);
    await expect(destructiveAction).toHaveClass(/border-lexos-wine/);

    await search.fill('registro-inexistente-para-validar-empty-state');
    await expect(page.getByText('Nenhum cliente encontrado com os filtros atuais.')).toBeVisible();
    await page.getByRole('button', { name: 'Limpar filtros', exact: true }).click();

    await primaryAction.click();
    await page.getByLabel('Nome/Razão social').fill(longClientName);
    await page.getByLabel('CPF/CNPJ ou documento').fill('RC-LONGO-001');
    await page.getByLabel('E-mail').fill('qa.rc.demo@lexos.test');
    await page.getByLabel('Telefone/WhatsApp').fill('(11) 90000-0000');
    await page.getByLabel('Responsável').fill('Equipe RC');
    await page.getByLabel('Segmento').fill('Empresarial estratégico');
    await page.getByLabel('Pendência principal').fill('Validar leitura confortável do nome longo');
    await page.getByLabel('Próxima ação').fill('Revisão humana do cadastro demonstrativo');
    await page.getByLabel('Observações').fill('Registro local temporário criado exclusivamente pelo smoke test da RC.');
    await page.getByRole('button', { name: /Salvar cliente/i }).click();

    await search.fill(longClientName);
    await expect(page.getByText(longClientName, { exact: true }).first()).toBeVisible();
    await expectNoHorizontalPageOverflow(page, '/clientes?nome-longo');
    await page.reload();
    await search.fill(longClientName);
    await expect(page.getByText(longClientName, { exact: true }).first(), 'Cliente com nome longo deve persistir após reload no modo demo.').toBeVisible();

    await page.evaluate(({ key, value }) => {
      if (value === null) window.localStorage.removeItem(key);
      else window.localStorage.setItem(key, value);
    }, { key: demoClientsStorageKey, value: previousClients });
    await monitor.assertNoCriticalErrors('Fluxo local de clientes da RC apresentou erro crítico.');
  });

  test('implantação comunica revisão humana obrigatória e ausência de envio automático', async ({ page }, testInfo) => {
    const monitor = await attachErrorMonitors(page, testInfo);
    await enterSafeDemo(page);
    await page.goto('/configuracoes/release');

    await expect(page.getByText('Revisão humana obrigatória', { exact: true })).toBeVisible();
    await expect(page.getByText(/Sem envio externo automático/i)).toBeVisible();
    await expect(page.getByText(/Piloto seguro/i)).toBeVisible();
    await monitor.assertNoCriticalErrors('Mensagens obrigatórias de segurança da implantação não foram preservadas.');
  });
});
