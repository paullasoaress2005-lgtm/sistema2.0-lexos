-- LEX.OS Control — Etapa 3K
-- Biblioteca real de prompts por workspace, com versionamento simples e RLS por membro ativo.
-- Execute manualmente no SQL Editor do Supabase antes de validar em produção.

create extension if not exists "pgcrypto";

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create or replace function public.is_workspace_member(target_workspace_id uuid)
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
  );
$$;

create table if not exists public.prompt_templates (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid null references public.workspaces(id) on delete cascade,
  created_by uuid null references auth.users(id) on delete set null,
  title text not null,
  slug text null,
  description text null,
  category text not null default 'geral',
  legal_area text null,
  prompt_type text not null default 'operacional',
  audience text null,
  status text not null default 'active',
  visibility text not null default 'workspace',
  current_version integer not null default 1,
  prompt_body text not null,
  variables jsonb not null default '[]'::jsonb,
  tags jsonb not null default '[]'::jsonb,
  metadata jsonb not null default '{}'::jsonb,
  archived_at timestamptz null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.prompt_templates add column if not exists workspace_id uuid null references public.workspaces(id) on delete cascade;
alter table public.prompt_templates add column if not exists created_by uuid null references auth.users(id) on delete set null;
alter table public.prompt_templates add column if not exists title text not null default 'Prompt sem título';
alter table public.prompt_templates add column if not exists slug text null;
alter table public.prompt_templates add column if not exists description text null;
alter table public.prompt_templates add column if not exists category text not null default 'geral';
alter table public.prompt_templates add column if not exists legal_area text null;
alter table public.prompt_templates add column if not exists prompt_type text not null default 'operacional';
alter table public.prompt_templates add column if not exists audience text null;
alter table public.prompt_templates add column if not exists status text not null default 'active';
alter table public.prompt_templates add column if not exists visibility text not null default 'workspace';
alter table public.prompt_templates add column if not exists current_version integer not null default 1;
alter table public.prompt_templates add column if not exists prompt_body text not null default '';
alter table public.prompt_templates add column if not exists variables jsonb not null default '[]'::jsonb;
alter table public.prompt_templates add column if not exists tags jsonb not null default '[]'::jsonb;
alter table public.prompt_templates add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.prompt_templates add column if not exists archived_at timestamptz null;
alter table public.prompt_templates add column if not exists created_at timestamptz not null default now();
alter table public.prompt_templates add column if not exists updated_at timestamptz not null default now();
alter table public.prompt_templates alter column title drop default;
alter table public.prompt_templates alter column prompt_body drop default;
alter table public.prompt_templates alter column category set default 'geral';
alter table public.prompt_templates alter column prompt_type set default 'operacional';
alter table public.prompt_templates alter column status set default 'active';
alter table public.prompt_templates alter column visibility set default 'workspace';
alter table public.prompt_templates alter column variables set default '[]'::jsonb;
alter table public.prompt_templates alter column tags set default '[]'::jsonb;
alter table public.prompt_templates alter column metadata set default '{}'::jsonb;

create table if not exists public.prompt_template_versions (
  id uuid primary key default gen_random_uuid(),
  prompt_template_id uuid not null references public.prompt_templates(id) on delete cascade,
  workspace_id uuid null references public.workspaces(id) on delete cascade,
  created_by uuid null references auth.users(id) on delete set null,
  version_number integer not null,
  title text not null,
  prompt_body text not null,
  variables jsonb not null default '[]'::jsonb,
  change_summary text null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

alter table public.prompt_template_versions add column if not exists prompt_template_id uuid not null references public.prompt_templates(id) on delete cascade;
alter table public.prompt_template_versions add column if not exists workspace_id uuid null references public.workspaces(id) on delete cascade;
alter table public.prompt_template_versions add column if not exists created_by uuid null references auth.users(id) on delete set null;
alter table public.prompt_template_versions add column if not exists version_number integer not null default 1;
alter table public.prompt_template_versions add column if not exists title text not null default 'Versão de prompt';
alter table public.prompt_template_versions add column if not exists prompt_body text not null default '';
alter table public.prompt_template_versions add column if not exists variables jsonb not null default '[]'::jsonb;
alter table public.prompt_template_versions add column if not exists change_summary text null;
alter table public.prompt_template_versions add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.prompt_template_versions add column if not exists created_at timestamptz not null default now();
alter table public.prompt_template_versions alter column title drop default;
alter table public.prompt_template_versions alter column prompt_body drop default;
alter table public.prompt_template_versions alter column variables set default '[]'::jsonb;
alter table public.prompt_template_versions alter column metadata set default '{}'::jsonb;

create unique index if not exists prompt_templates_workspace_slug_uidx on public.prompt_templates(workspace_id, slug) where slug is not null;
create index if not exists prompt_templates_workspace_id_idx on public.prompt_templates(workspace_id);
create index if not exists prompt_templates_created_by_idx on public.prompt_templates(created_by);
create index if not exists prompt_templates_category_idx on public.prompt_templates(category);
create index if not exists prompt_templates_legal_area_idx on public.prompt_templates(legal_area);
create index if not exists prompt_templates_prompt_type_idx on public.prompt_templates(prompt_type);
create index if not exists prompt_templates_status_idx on public.prompt_templates(status);
create index if not exists prompt_templates_visibility_idx on public.prompt_templates(visibility);
create index if not exists prompt_templates_archived_at_idx on public.prompt_templates(archived_at);
create index if not exists prompt_templates_tags_gin_idx on public.prompt_templates using gin(tags);

create unique index if not exists prompt_template_versions_template_version_uidx on public.prompt_template_versions(prompt_template_id, version_number);
create index if not exists prompt_template_versions_prompt_template_id_idx on public.prompt_template_versions(prompt_template_id);
create index if not exists prompt_template_versions_workspace_id_idx on public.prompt_template_versions(workspace_id);
create index if not exists prompt_template_versions_created_by_idx on public.prompt_template_versions(created_by);
create index if not exists prompt_template_versions_created_at_idx on public.prompt_template_versions(created_at desc);

create or replace trigger set_prompt_templates_updated_at
before update on public.prompt_templates
for each row execute function public.set_updated_at();

alter table public.prompt_templates enable row level security;
alter table public.prompt_template_versions enable row level security;

-- Prompts reais por workspace. Prompts globais ficam apenas legíveis para usuários autenticados.
drop policy if exists "members read prompt templates" on public.prompt_templates;
create policy "members read prompt templates"
  on public.prompt_templates for select
  to authenticated
  using (
    (workspace_id is not null and public.is_workspace_member(workspace_id))
    or (workspace_id is null and visibility = 'global')
  );

drop policy if exists "members insert prompt templates" on public.prompt_templates;
create policy "members insert prompt templates"
  on public.prompt_templates for insert
  to authenticated
  with check (
    workspace_id is not null
    and visibility in ('workspace', 'private')
    and public.is_workspace_member(workspace_id)
  );

drop policy if exists "members update prompt templates" on public.prompt_templates;
create policy "members update prompt templates"
  on public.prompt_templates for update
  to authenticated
  using (workspace_id is not null and public.is_workspace_member(workspace_id))
  with check (
    workspace_id is not null
    and visibility in ('workspace', 'private')
    and public.is_workspace_member(workspace_id)
  );

drop policy if exists "members read prompt template versions" on public.prompt_template_versions;
create policy "members read prompt template versions"
  on public.prompt_template_versions for select
  to authenticated
  using (
    (workspace_id is not null and public.is_workspace_member(workspace_id))
    or exists (
      select 1
      from public.prompt_templates pt
      where pt.id = prompt_template_id
        and pt.workspace_id is null
        and pt.visibility = 'global'
    )
  );

drop policy if exists "members insert prompt template versions" on public.prompt_template_versions;
create policy "members insert prompt template versions"
  on public.prompt_template_versions for insert
  to authenticated
  with check (
    workspace_id is not null
    and public.is_workspace_member(workspace_id)
    and exists (
      select 1
      from public.prompt_templates pt
      where pt.id = prompt_template_id
        and pt.workspace_id = prompt_template_versions.workspace_id
        and public.is_workspace_member(pt.workspace_id)
    )
  );

-- Version history is append-only for regular authenticated users in this etapa.
