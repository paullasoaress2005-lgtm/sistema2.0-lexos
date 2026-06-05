-- LEX.OS Control — Etapa 3J
-- Central LEX.OS real/controlada por workspace, com histórico persistente e RLS por membro ativo.
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

create table if not exists public.central_executions (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  created_by uuid null references auth.users(id) on delete set null,
  execution_type text not null,
  title text not null,
  source_module text null,
  client_id uuid null references public.clients(id) on delete set null,
  process_id uuid null references public.processes(id) on delete set null,
  partnership_id uuid null references public.process_partnerships(id) on delete set null,
  task_id uuid null references public.tasks(id) on delete set null,
  agenda_event_id uuid null references public.agenda_events(id) on delete set null,
  financial_record_id uuid null references public.financial_records(id) on delete set null,
  report_id uuid null references public.reports(id) on delete set null,
  input_summary text null,
  output_text text not null,
  status text not null default 'generated',
  metadata jsonb not null default '{}'::jsonb,
  copied_at timestamptz null,
  archived_at timestamptz null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.central_executions add column if not exists created_by uuid null references auth.users(id) on delete set null;
alter table public.central_executions add column if not exists execution_type text not null default 'prompt';
alter table public.central_executions add column if not exists title text not null default 'Execução Central LEX.OS';
alter table public.central_executions add column if not exists source_module text null;
alter table public.central_executions add column if not exists client_id uuid null references public.clients(id) on delete set null;
alter table public.central_executions add column if not exists process_id uuid null references public.processes(id) on delete set null;
alter table public.central_executions add column if not exists partnership_id uuid null references public.process_partnerships(id) on delete set null;
alter table public.central_executions add column if not exists task_id uuid null references public.tasks(id) on delete set null;
alter table public.central_executions add column if not exists agenda_event_id uuid null references public.agenda_events(id) on delete set null;
alter table public.central_executions add column if not exists financial_record_id uuid null references public.financial_records(id) on delete set null;
alter table public.central_executions add column if not exists report_id uuid null references public.reports(id) on delete set null;
alter table public.central_executions add column if not exists input_summary text null;
alter table public.central_executions add column if not exists output_text text not null default '';
alter table public.central_executions add column if not exists status text not null default 'generated';
alter table public.central_executions add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.central_executions add column if not exists copied_at timestamptz null;
alter table public.central_executions add column if not exists archived_at timestamptz null;
alter table public.central_executions add column if not exists created_at timestamptz not null default now();
alter table public.central_executions add column if not exists updated_at timestamptz not null default now();
alter table public.central_executions alter column execution_type drop default;
alter table public.central_executions alter column title drop default;
alter table public.central_executions alter column output_text drop default;
alter table public.central_executions alter column status set default 'generated';
alter table public.central_executions alter column metadata set default '{}'::jsonb;

create index if not exists central_executions_workspace_id_idx on public.central_executions(workspace_id);
create index if not exists central_executions_created_by_idx on public.central_executions(created_by);
create index if not exists central_executions_execution_type_idx on public.central_executions(execution_type);
create index if not exists central_executions_status_idx on public.central_executions(status);
create index if not exists central_executions_client_id_idx on public.central_executions(client_id);
create index if not exists central_executions_process_id_idx on public.central_executions(process_id);
create index if not exists central_executions_partnership_id_idx on public.central_executions(partnership_id);
create index if not exists central_executions_task_id_idx on public.central_executions(task_id);
create index if not exists central_executions_agenda_event_id_idx on public.central_executions(agenda_event_id);
create index if not exists central_executions_financial_record_id_idx on public.central_executions(financial_record_id);
create index if not exists central_executions_report_id_idx on public.central_executions(report_id);
create index if not exists central_executions_created_at_idx on public.central_executions(created_at desc);
create index if not exists central_executions_archived_at_idx on public.central_executions(archived_at);

create or replace trigger set_central_executions_updated_at
before update on public.central_executions
for each row execute function public.set_updated_at();

alter table public.central_executions enable row level security;

drop policy if exists "members read central executions" on public.central_executions;
create policy "members read central executions"
  on public.central_executions for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert central executions" on public.central_executions;
create policy "members insert central executions"
  on public.central_executions for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update central executions" on public.central_executions;
create policy "members update central executions"
  on public.central_executions for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));
