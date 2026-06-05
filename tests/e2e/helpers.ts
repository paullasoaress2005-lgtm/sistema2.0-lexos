import { expect, Page, TestInfo } from '@playwright/test';

export const REQUIRED_ENV_ERROR = 'Configure E2E_BASE_URL, E2E_EMAIL e E2E_PASSWORD antes de rodar os testes.';

export function ensureE2EEnv() {
  const required = ['E2E_BASE_URL', 'E2E_EMAIL', 'E2E_PASSWORD'];
  const missing = required.filter((key) => !process.env[key]);
  if (missing.length > 0) throw new Error(REQUIRED_ENV_ERROR);
}

type MonitorState = {
  criticalErrors: string[];
  warnings: string[];
  assertNoCriticalErrors: (context: string) => Promise<void>;
  getWarnings: () => string[];
};

function isRscFallbackConsoleError(text: string) {
  return text.includes('Failed to fetch RSC payload')
    && text.includes('Falling back to browser navigation')
    && text.includes('TypeError: Failed to fetch');
}

function isFetchNoiseConsoleError(text: string) {
  return text.includes('TypeError: Failed to fetch')
    || text.includes('TypeError: network error')
    || isRscFallbackConsoleError(text);
}

function isHydrationNoise(text: string) {
  return text.includes('Minified React error #418')
    || text.includes('Minified React error #423')
    || text.includes('Minified React error #425');
}

function isIgnorableFailure(url: string, errorText: string) {
  const u = url.toLowerCase();
  const e = errorText.toLowerCase();
  if (u.includes('/_next/') || u.includes('favicon.ico')) return true;
  if (u.includes('/_next/static') || u.includes('/_next/data')) return true;
  if (u.match(/\.(png|jpg|jpeg|gif|svg|woff|woff2|ttf|ico)(\?|$)/)) return true;
  if (u.includes('.supabase.co/rest/v1/') || u.includes('.supabase.co/auth/v1/')) {
    if (e.includes('failed to fetch') || e.includes('net::err_aborted') || e.includes('ns_binding_aborted')) return true;
  }
  if (e.includes('failed to fetch') || e.includes('network error')) return true;
  if (e.includes('net::err_aborted') || e.includes('ns_binding_aborted') || e.includes('page was closed')) return true;
  return false;
}

function isMainRoute(url: string) {
  return /\/((dashboard|clientes|processos|tarefas|agenda|financeiro|relatorios|central-lexos|socios|configuracoes|onboarding))(\/|$)/.test(url);
}

export async function attachErrorMonitors(page: Page, testInfo: TestInfo): Promise<MonitorState> {
  const criticalErrors: string[] = [];
  const warnings: string[] = [];

  page.on('console', (msg) => {
    if (msg.type() !== 'error') return;
    const text = msg.text();
    if (isFetchNoiseConsoleError(text) || isHydrationNoise(text)) {
      warnings.push(`console.warning[fetch-noise]: ${text}`);
      return;
    }
    criticalErrors.push(`console.error: ${text}`);
  });

  page.on('pageerror', (error) => {
    const message = error.message || '';
    if (isFetchNoiseConsoleError(message) || isHydrationNoise(message)) {
      warnings.push(`pageerror.warning[transient-noise]: ${message}`);
      return;
    }
    criticalErrors.push(`pageerror: ${message}`);
  });

  page.on('requestfailed', (request) => {
    const url = request.url();
    const errorText = request.failure()?.errorText || 'unknown';
    const entry = `requestfailed: ${errorText} - ${url}`;
    if (isIgnorableFailure(url, errorText)) {
      warnings.push(entry);
      return;
    }
    criticalErrors.push(entry);
  });

  page.on('response', (response) => {
    const status = response.status();
    const url = response.url();
    if (status >= 500) criticalErrors.push(`response ${status}: ${url}`);
    if (status === 404 && isMainRoute(url)) criticalErrors.push(`response 404 em rota principal: ${url}`);
  });

  return {
    criticalErrors,
    warnings,
    getWarnings: () => [...warnings],
    assertNoCriticalErrors: async (context: string) => {
      if (warnings.length) {
        await testInfo.attach(`monitor-warnings-${Date.now()}.log`, { body: warnings.join('\n'), contentType: 'text/plain' });
      }
      await expect(criticalErrors, `${context}\nURL atual: ${page.url()}\nTítulo: ${await page.title()}\nErros críticos:\n${criticalErrors.join('\n') || '(nenhum)'}`).toEqual([]);
    },
  };
}

export async function ensureShellVisible(page: Page) {
  await expect(page.getByRole('navigation')).toBeVisible();
}

export async function gotoAndAssertAppRoute(page: Page, route: string, monitor?: MonitorState) {
  await page.goto(route, { waitUntil: 'domcontentloaded' });
  await page.waitForLoadState('domcontentloaded');
  if (monitor && monitor.getWarnings().some((entry) => entry.includes('RSC payload') || entry.includes('fetch-noise'))) {
    await page.waitForLoadState('domcontentloaded');
  }
  await ensureShellVisible(page);
  await expect(page).toHaveURL(new RegExp(route.replace('/', '\\/')));
  await expect(page.getByText('404')).toHaveCount(0);
  await expect(page.getByText('500')).toHaveCount(0);
  const main = page.locator('main').first();
  if (await main.count()) {
    await expect(main, `Main ausente/invisível na rota ${route}. URL: ${page.url()}`).toBeVisible();
    const text = await main.innerText().catch(() => '');
    await expect(
      text.trim().length,
      `Conteúdo principal vazio na rota ${route}. URL: ${page.url()}. Warnings: ${monitor?.getWarnings().slice(-5).join(' | ') || 'nenhum'}`,
    ).toBeGreaterThan(0);
  } else {
    await expect(page.locator('body')).toContainText(/LEX\.OS|Control|Clientes|Processos|Tarefas|Agenda|Financeiro|Relatórios|Central/i);
  }
  if (monitor) await monitor.assertNoCriticalErrors(`Falha ao validar rota principal ${route}.`);
}

export function qaSuffix() { return `${Date.now()}`; }
