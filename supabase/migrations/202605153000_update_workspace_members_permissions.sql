-- ETAPA 3L — usuários, equipe e permissões reais por workspace.
-- Migração segura: adiciona colunas opcionais, helpers e policies sem usar chave administrativa no cliente.

create extension if not exists "pgcrypto";

alter table public.workspace_members
  add column if not exists display_name text null,
  add column if not exists position text null,
  add column if not exists department text null,
  add column if not exists permissions jsonb not null default '{}'::jsonb,
  add column if not exists invited_by uuid null references auth.users(id) on delete set null,
  add column if not exists invited_at timestamptz null,
  add column if not exists deactivated_at timestamptz null,
  add column if not exists last_seen_at timestamptz null,
  add column if not exists metadata jsonb not null default '{}'::jsonb;

alter table public.profiles
  add column if not exists phone text null,
  add column if not exists position text null,
  add column if not exists department text null,
  add column if not exists avatar_url text null,
  add column if not exists metadata jsonb not null default '{}'::jsonb;

create index if not exists workspace_members_workspace_status_idx on public.workspace_members(workspace_id, status);
create index if not exists profiles_email_idx on public.profiles(email);

create or replace function public.can_manage_workspace_members(target_workspace_id uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1
    from public.workspace_members wm
    where wm.workspace_id = target_workspace_id
      and wm.user_id = auth.uid()
      and wm.status = 'active'
      and wm.role in ('owner', 'admin', 'socio')
  );
$$;

drop policy if exists "members read own memberships" on public.workspace_members;
drop policy if exists "workspace members read same workspace" on public.workspace_members;
create policy "workspace members read same workspace"
  on public.workspace_members for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "workspace managers update members" on public.workspace_members;
create policy "workspace managers update members"
  on public.workspace_members for update
  to authenticated
  using (public.can_manage_workspace_members(workspace_id))
  with check (public.can_manage_workspace_members(workspace_id));

drop policy if exists "workspace managers insert existing members" on public.workspace_members;
create policy "workspace managers insert existing members"
  on public.workspace_members for insert
  to authenticated
  with check (public.can_manage_workspace_members(workspace_id));

drop policy if exists "profiles read same workspace" on public.profiles;
create policy "profiles read same workspace"
  on public.profiles for select
  to authenticated
  using (
    id = auth.uid()
    or exists (
      select 1
      from public.workspace_members viewer
      join public.workspace_members subject
        on subject.workspace_id = viewer.workspace_id
      where viewer.user_id = auth.uid()
        and viewer.status = 'active'
        and subject.user_id = profiles.id
    )
  );

-- Mantém a policy de update self já existente: o usuário só atualiza seu próprio public.profiles.
-- Enforcement de colunas sensíveis de role continua na camada de aplicação nesta etapa;
-- não há policy pública aberta e nenhuma policy usa anon.
