import { expect, test, type Request } from '@playwright/test';

const operationalRoutes = [
  '/dashboard',
  '/clientes',
  '/processos/qualquer-id',
  '/configuracoes/seguranca',
  '/central-lexos/prompts',
] as const;

function isSupabaseRequest(request: Request) {
  return new URL(request.url()).hostname.endsWith('.supabase.co');
}

test.describe('hardening de acesso demo e operação Supabase', () => {
  test('rotas públicas permanecem acessíveis e rota operacional sem sessão redireciona com segurança', async ({ page }) => {
    await page.context().clearCookies();
    await page.goto('/login');
    await expect(page).toHaveURL(/\/login$/);

    await page.goto('/');
    await expect(page).toHaveURL(/\/login$/);

    for (const route of operationalRoutes) {
      await page.goto(route);
      await expect(page, `${route} deve redirecionar para a entrada segura sem sessão.`).toHaveURL(/\/login$/);
    }
  });

  test('espelho local fabricado não libera operação Supabase sem sessão válida', async ({ page }) => {
    await page.context().clearCookies();
    await page.goto('/login');
    await page.evaluate(() => {
      window.localStorage.setItem('lexos.control.demo.session', JSON.stringify({
        mode: 'supabase',
        user: { name: 'Fabricado', email: 'fabricado@example.test', workspaceId: 'workspace-fabricado' },
        workspace: { id: 'workspace-fabricado', name: 'Workspace fabricado' },
        permissions: [],
      }));
    });

    await page.goto('/dashboard');
    await expect(page).toHaveURL(/\/login$/);
  });

  test('demo segue acessível sem login e não consulta Supabase', async ({ page }) => {
    const supabaseRequests: string[] = [];
    page.on('request', (request) => {
      if (isSupabaseRequest(request)) supabaseRequests.push(request.url());
    });

    await page.context().clearCookies();
    await page.goto('/login');
    await page.getByRole('button', { name: /^Entrar na demonstração$/i }).click();
    await expect(page).toHaveURL(/\/dashboard$/);
    await page.goto('/clientes');
    await expect(page).toHaveURL(/\/clientes$/);
    await expect(page.getByRole('navigation')).toBeVisible();

    const sessionMode = await page.evaluate(() => {
      const raw = window.localStorage.getItem('lexos.control.demo.session');
      return raw ? JSON.parse(raw).mode : null;
    });
    expect(sessionMode).toBe('demo');
    expect(supabaseRequests, 'A demonstração local não deve consultar endpoints Supabase.').toEqual([]);
  });
});
