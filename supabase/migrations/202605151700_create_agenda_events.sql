-- LEX.OS Control — Etapa 3E
-- Agenda/Prazos reais por workspace, com vínculos opcionais a clientes, processos e tarefas.
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

create table if not exists public.agenda_events (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid null references public.clients(id) on delete set null,
  process_id uuid null references public.processes(id) on delete set null,
  task_id uuid null references public.tasks(id) on delete set null,
  title text not null,
  description text null,
  event_type text not null default 'internal',
  status text not null default 'scheduled',
  priority text not null default 'medium',
  risk_level text null,
  responsible text null,
  starts_at timestamptz not null,
  ends_at timestamptz null,
  reminder_at timestamptz null,
  location text null,
  next_action text null,
  notes text null,
  metadata jsonb not null default '{}'::jsonb,
  completed_at timestamptz null,
  canceled_at timestamptz null,
  archived_at timestamptz null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.agenda_events add column if not exists client_id uuid null references public.clients(id) on delete set null;
alter table public.agenda_events add column if not exists process_id uuid null references public.processes(id) on delete set null;
alter table public.agenda_events add column if not exists task_id uuid null references public.tasks(id) on delete set null;
alter table public.agenda_events add column if not exists description text null;
alter table public.agenda_events add column if not exists event_type text not null default 'internal';
alter table public.agenda_events add column if not exists status text not null default 'scheduled';
alter table public.agenda_events add column if not exists priority text not null default 'medium';
alter table public.agenda_events add column if not exists risk_level text null;
alter table public.agenda_events add column if not exists responsible text null;
alter table public.agenda_events add column if not exists starts_at timestamptz not null default now();
alter table public.agenda_events alter column starts_at drop default;
alter table public.agenda_events add column if not exists ends_at timestamptz null;
alter table public.agenda_events add column if not exists reminder_at timestamptz null;
alter table public.agenda_events add column if not exists location text null;
alter table public.agenda_events add column if not exists next_action text null;
alter table public.agenda_events add column if not exists notes text null;
alter table public.agenda_events add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.agenda_events add column if not exists completed_at timestamptz null;
alter table public.agenda_events add column if not exists canceled_at timestamptz null;
alter table public.agenda_events add column if not exists archived_at timestamptz null;
alter table public.agenda_events add column if not exists created_at timestamptz not null default now();
alter table public.agenda_events add column if not exists updated_at timestamptz not null default now();
alter table public.agenda_events alter column event_type set default 'internal';
alter table public.agenda_events alter column status set default 'scheduled';
alter table public.agenda_events alter column priority set default 'medium';
alter table public.agenda_events alter column metadata set default '{}'::jsonb;
alter table public.agenda_events alter column starts_at type timestamptz using starts_at::timestamptz;
alter table public.agenda_events alter column ends_at type timestamptz using ends_at::timestamptz;
alter table public.agenda_events alter column reminder_at type timestamptz using reminder_at::timestamptz;

create index if not exists agenda_events_workspace_id_idx on public.agenda_events(workspace_id);
create index if not exists agenda_events_client_id_idx on public.agenda_events(client_id);
create index if not exists agenda_events_process_id_idx on public.agenda_events(process_id);
create index if not exists agenda_events_task_id_idx on public.agenda_events(task_id);
create index if not exists agenda_events_starts_at_idx on public.agenda_events(starts_at);
create index if not exists agenda_events_event_type_idx on public.agenda_events(event_type);
create index if not exists agenda_events_status_idx on public.agenda_events(status);
create index if not exists agenda_events_priority_idx on public.agenda_events(priority);
create index if not exists agenda_events_responsible_idx on public.agenda_events(responsible);
create index if not exists agenda_events_archived_at_idx on public.agenda_events(archived_at);
create index if not exists agenda_events_canceled_at_idx on public.agenda_events(canceled_at);

create or replace trigger set_agenda_events_updated_at
before update on public.agenda_events
for each row execute function public.set_updated_at();

alter table public.agenda_events enable row level security;

drop policy if exists "members read agenda events" on public.agenda_events;
create policy "members read agenda events"
  on public.agenda_events for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert agenda events" on public.agenda_events;
create policy "members insert agenda events"
  on public.agenda_events for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update agenda events" on public.agenda_events;
create policy "members update agenda events"
  on public.agenda_events for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));
