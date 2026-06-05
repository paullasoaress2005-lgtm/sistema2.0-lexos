-- LEX.OS Control — Etapa 3O
-- Hardening transversal de RLS por workspace, membro ativo e papéis sensíveis.
-- Execute manualmente no SQL Editor do projeto Supabase do piloto antes do release assistido.

create or replace function public.current_workspace_role(target_workspace_id uuid)
returns text
language sql
security definer
set search_path = public
stable
as $$
  select wm.role
  from public.workspace_members wm
  where wm.workspace_id = target_workspace_id
    and wm.user_id = auth.uid()
    and wm.status = 'active'
  limit 1;
$$;

create or replace function public.has_workspace_role(target_workspace_id uuid, allowed_roles text[])
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select coalesce(public.current_workspace_role(target_workspace_id) = any(allowed_roles), false);
$$;

-- Configurações avançadas do workspace: edição somente owner/admin.
drop policy if exists "members update workspaces" on public.workspaces;
create policy "workspace admins update workspaces"
  on public.workspaces for update
  to authenticated
  using (public.has_workspace_role(id, array['owner','admin']))
  with check (public.has_workspace_role(id, array['owner','admin']));

-- Financeiro: leitura/escrita somente owner/admin/socio/financeiro.
drop policy if exists "members read financial records" on public.financial_records;
create policy "finance roles read financial records"
  on public.financial_records for select
  to authenticated
  using (public.has_workspace_role(workspace_id, array['owner','admin','socio','financeiro']));

drop policy if exists "members insert financial records" on public.financial_records;
create policy "finance roles insert financial records"
  on public.financial_records for insert
  to authenticated
  with check (public.has_workspace_role(workspace_id, array['owner','admin','socio','financeiro']));

drop policy if exists "members update financial records" on public.financial_records;
create policy "finance roles update financial records"
  on public.financial_records for update
  to authenticated
  using (public.has_workspace_role(workspace_id, array['owner','admin','socio','financeiro']))
  with check (public.has_workspace_role(workspace_id, array['owner','admin','socio','financeiro']));

-- Relatórios estratégicos: leitura/escrita somente owner/admin/socio.
drop policy if exists "members read reports" on public.reports;
create policy "strategic roles read reports"
  on public.reports for select
  to authenticated
  using (public.has_workspace_role(workspace_id, array['owner','admin','socio']));

drop policy if exists "members insert reports" on public.reports;
create policy "strategic roles insert reports"
  on public.reports for insert
  to authenticated
  with check (public.has_workspace_role(workspace_id, array['owner','admin','socio']));

drop policy if exists "members update reports" on public.reports;
create policy "strategic roles update reports"
  on public.reports for update
  to authenticated
  using (public.has_workspace_role(workspace_id, array['owner','admin','socio']))
  with check (public.has_workspace_role(workspace_id, array['owner','admin','socio']));

-- Gestão de prompts reais: leitura por membro ativo; criação/edição/versionamento somente owner/admin/socio.
drop policy if exists "members insert prompt templates" on public.prompt_templates;
create policy "prompt managers insert prompt templates"
  on public.prompt_templates for insert
  to authenticated
  with check (
    workspace_id is not null
    and visibility in ('workspace', 'private')
    and public.has_workspace_role(workspace_id, array['owner','admin','socio'])
  );

drop policy if exists "members update prompt templates" on public.prompt_templates;
create policy "prompt managers update prompt templates"
  on public.prompt_templates for update
  to authenticated
  using (workspace_id is not null and public.has_workspace_role(workspace_id, array['owner','admin','socio']))
  with check (
    workspace_id is not null
    and visibility in ('workspace', 'private')
    and public.has_workspace_role(workspace_id, array['owner','admin','socio'])
  );

drop policy if exists "members insert prompt template versions" on public.prompt_template_versions;
create policy "prompt managers insert prompt template versions"
  on public.prompt_template_versions for insert
  to authenticated
  with check (
    workspace_id is not null
    and public.has_workspace_role(workspace_id, array['owner','admin','socio'])
    and exists (
      select 1
      from public.prompt_templates pt
      where pt.id = prompt_template_id
        and pt.workspace_id = prompt_template_versions.workspace_id
        and public.has_workspace_role(pt.workspace_id, array['owner','admin','socio'])
    )
  );
