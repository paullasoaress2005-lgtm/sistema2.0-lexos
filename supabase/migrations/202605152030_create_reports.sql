-- LEX.OS Control — Etapa 3I
-- Relatórios reais por workspace, com histórico persistente e RLS por membro ativo.
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

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  created_by uuid null references auth.users(id) on delete set null,
  title text not null,
  report_type text not null,
  audience text null,
  period_start date null,
  period_end date null,
  client_id uuid null references public.clients(id) on delete set null,
  process_id uuid null references public.processes(id) on delete set null,
  status text not null default 'generated',
  summary text null,
  generated_text text not null,
  metrics jsonb not null default '{}'::jsonb,
  sections jsonb not null default '[]'::jsonb,
  filters jsonb not null default '{}'::jsonb,
  metadata jsonb not null default '{}'::jsonb,
  copied_at timestamptz null,
  archived_at timestamptz null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.reports add column if not exists created_by uuid null references auth.users(id) on delete set null;
alter table public.reports add column if not exists audience text null;
alter table public.reports add column if not exists period_start date null;
alter table public.reports add column if not exists period_end date null;
alter table public.reports add column if not exists client_id uuid null references public.clients(id) on delete set null;
alter table public.reports add column if not exists process_id uuid null references public.processes(id) on delete set null;
alter table public.reports add column if not exists status text not null default 'generated';
alter table public.reports add column if not exists summary text null;
alter table public.reports add column if not exists metrics jsonb not null default '{}'::jsonb;
alter table public.reports add column if not exists sections jsonb not null default '[]'::jsonb;
alter table public.reports add column if not exists filters jsonb not null default '{}'::jsonb;
alter table public.reports add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.reports add column if not exists copied_at timestamptz null;
alter table public.reports add column if not exists archived_at timestamptz null;
alter table public.reports add column if not exists created_at timestamptz not null default now();
alter table public.reports add column if not exists updated_at timestamptz not null default now();
alter table public.reports alter column status set default 'generated';
alter table public.reports alter column metrics set default '{}'::jsonb;
alter table public.reports alter column sections set default '[]'::jsonb;
alter table public.reports alter column filters set default '{}'::jsonb;
alter table public.reports alter column metadata set default '{}'::jsonb;

create index if not exists reports_workspace_id_idx on public.reports(workspace_id);
create index if not exists reports_created_by_idx on public.reports(created_by);
create index if not exists reports_report_type_idx on public.reports(report_type);
create index if not exists reports_status_idx on public.reports(status);
create index if not exists reports_client_id_idx on public.reports(client_id);
create index if not exists reports_process_id_idx on public.reports(process_id);
create index if not exists reports_created_at_idx on public.reports(created_at desc);
create index if not exists reports_archived_at_idx on public.reports(archived_at);

create or replace trigger set_reports_updated_at
before update on public.reports
for each row execute function public.set_updated_at();

alter table public.reports enable row level security;

drop policy if exists "members read reports" on public.reports;
create policy "members read reports"
  on public.reports for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert reports" on public.reports;
create policy "members insert reports"
  on public.reports for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update reports" on public.reports;
create policy "members update reports"
  on public.reports for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));
