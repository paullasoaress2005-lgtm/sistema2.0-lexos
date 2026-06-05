-- LEX.OS Control — Etapa 3C
-- Processos e parcerias processuais reais por workspace, com RLS por membership ativo.
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

create table if not exists public.processes (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid null references public.clients(id) on delete set null,
  title text not null,
  process_number text null,
  area text null,
  status text not null default 'active',
  risk_level text null,
  phase text null,
  responsible text null,
  counterparty text null,
  court_or_agency text null,
  next_action text null,
  due_date date null,
  notes text null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz null
);

create table if not exists public.process_partnerships (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  process_id uuid null references public.processes(id) on delete set null,
  partner_name text not null,
  partner_type text null,
  status text not null default 'negotiation',
  fee_model text null,
  fee_percentage numeric null,
  expected_transfer_value numeric null,
  transferred_value numeric null,
  transfer_status text null,
  responsible text null,
  notes text null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  archived_at timestamptz null
);

create index if not exists processes_workspace_id_idx on public.processes(workspace_id);
create index if not exists processes_client_id_idx on public.processes(client_id);
create index if not exists processes_archived_at_idx on public.processes(archived_at);
create index if not exists process_partnerships_workspace_id_idx on public.process_partnerships(workspace_id);
create index if not exists process_partnerships_process_id_idx on public.process_partnerships(process_id);
create index if not exists process_partnerships_archived_at_idx on public.process_partnerships(archived_at);

create or replace trigger set_processes_updated_at
before update on public.processes
for each row execute function public.set_updated_at();

create or replace trigger set_process_partnerships_updated_at
before update on public.process_partnerships
for each row execute function public.set_updated_at();

alter table public.processes enable row level security;
alter table public.process_partnerships enable row level security;

drop policy if exists "members read processes" on public.processes;
create policy "members read processes"
  on public.processes for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert processes" on public.processes;
create policy "members insert processes"
  on public.processes for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update processes" on public.processes;
create policy "members update processes"
  on public.processes for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members read process partnerships" on public.process_partnerships;
create policy "members read process partnerships"
  on public.process_partnerships for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert process partnerships" on public.process_partnerships;
create policy "members insert process partnerships"
  on public.process_partnerships for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update process partnerships" on public.process_partnerships;
create policy "members update process partnerships"
  on public.process_partnerships for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));
