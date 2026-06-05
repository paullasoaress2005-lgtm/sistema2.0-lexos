-- LEX.OS Control — Etapa 3A
-- Supabase real/controlado com workspace, autenticação preparada, RLS e fallback demo/local no app.
-- Execute no SQL Editor do Supabase. Não use service keys no frontend.

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

create table if not exists public.workspaces (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique,
  status text default 'active',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  email text,
  role text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.workspace_members (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid references public.workspaces(id) on delete cascade,
  user_id uuid references auth.users(id) on delete cascade,
  role text not null default 'member',
  status text not null default 'active',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(workspace_id, user_id)
);

create table if not exists public.clients (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid references public.workspaces(id) on delete cascade,
  name text not null,
  type text,
  document text,
  email text,
  phone text,
  status text default 'active',
  owner text,
  segment text,
  pending text,
  next_action text,
  notes text,
  archived_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.activity_logs (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  user_id uuid references auth.users(id) on delete set null,
  actor_user_id uuid references auth.users(id) on delete set null,
  module text not null,
  entity_type text not null,
  entity_id uuid,
  action text not null,
  title text,
  description text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists workspaces_slug_idx on public.workspaces(slug);
create index if not exists workspace_members_workspace_id_idx on public.workspace_members(workspace_id);
create index if not exists workspace_members_user_id_idx on public.workspace_members(user_id);
create index if not exists clients_workspace_id_idx on public.clients(workspace_id);
create index if not exists clients_archived_at_idx on public.clients(archived_at);
create index if not exists activity_logs_workspace_id_idx on public.activity_logs(workspace_id);
create index if not exists activity_logs_workspace_created_at_idx on public.activity_logs(workspace_id, created_at desc);
create index if not exists activity_logs_entity_type_idx on public.activity_logs(entity_type);
create index if not exists activity_logs_action_idx on public.activity_logs(action);

create or replace trigger set_workspaces_updated_at
before update on public.workspaces
for each row execute function public.set_updated_at();

create or replace trigger set_profiles_updated_at
before update on public.profiles
for each row execute function public.set_updated_at();

create or replace trigger set_workspace_members_updated_at
before update on public.workspace_members
for each row execute function public.set_updated_at();

create or replace trigger set_clients_updated_at
before update on public.clients
for each row execute function public.set_updated_at();

alter table public.workspaces enable row level security;
alter table public.profiles enable row level security;
alter table public.workspace_members enable row level security;
alter table public.clients enable row level security;
alter table public.activity_logs enable row level security;

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

create or replace function public.current_workspace_ids()
returns setof uuid
language sql
security definer
set search_path = public
stable
as $$
  select wm.workspace_id
  from public.workspace_members wm
  where wm.user_id = auth.uid()
    and wm.status = 'active';
$$;

drop policy if exists "members read own memberships" on public.workspace_members;
create policy "members read own memberships"
  on public.workspace_members for select
  to authenticated
  using (user_id = auth.uid());

drop policy if exists "profiles read self" on public.profiles;
create policy "profiles read self"
  on public.profiles for select
  to authenticated
  using (id = auth.uid());

drop policy if exists "profiles insert self" on public.profiles;
create policy "profiles insert self"
  on public.profiles for insert
  to authenticated
  with check (id = auth.uid());

drop policy if exists "profiles update self" on public.profiles;
create policy "profiles update self"
  on public.profiles for update
  to authenticated
  using (id = auth.uid())
  with check (id = auth.uid());

drop policy if exists "members read workspaces" on public.workspaces;
create policy "members read workspaces"
  on public.workspaces for select
  to authenticated
  using (id in (select public.current_workspace_ids()));

drop policy if exists "members update workspaces" on public.workspaces;
create policy "members update workspaces"
  on public.workspaces for update
  to authenticated
  using (public.is_workspace_member(id))
  with check (public.is_workspace_member(id));

drop policy if exists "members read clients" on public.clients;
create policy "members read clients"
  on public.clients for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert clients" on public.clients;
create policy "members insert clients"
  on public.clients for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update clients" on public.clients;
create policy "members update clients"
  on public.clients for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members read activity logs" on public.activity_logs;
create policy "members read activity logs"
  on public.activity_logs for select
  to authenticated
  using (
    exists (
      select 1
      from public.workspace_members wm
      where wm.workspace_id = activity_logs.workspace_id
        and wm.user_id = auth.uid()
        and wm.status = 'active'
    )
  );

drop policy if exists "members insert activity logs" on public.activity_logs;
create policy "members insert activity logs"
  on public.activity_logs for insert
  to authenticated
  with check (
    exists (
      select 1
      from public.workspace_members wm
      where wm.workspace_id = activity_logs.workspace_id
        and wm.user_id = auth.uid()
        and wm.status = 'active'
    )
    and (actor_user_id is null or actor_user_id = auth.uid())
    and (user_id is null or user_id = auth.uid())
  );

-- Módulos operacionais reais por workspace (processos, tarefas, agenda e financeiro).
-- Essas tabelas evitam mistura entre dados demo/local e registros reais autenticados.
create table if not exists public.processes (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid references public.clients(id) on delete set null,
  client_name text,
  number text,
  title text not null,
  court text,
  jurisdiction text,
  area text,
  phase text,
  status text default 'ativo',
  risk text default 'médio',
  priority text default 'média',
  responsible text,
  opposing_party text,
  next_deadline_at date,
  next_action text,
  main_issue text,
  notes text,
  archived_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid references public.clients(id) on delete set null,
  client_name text,
  process_id uuid references public.processes(id) on delete set null,
  process_number text,
  title text not null,
  description text,
  type text,
  status text default 'a_fazer',
  priority text default 'média',
  responsible text,
  due_at date,
  reminder_at timestamptz,
  completed_at timestamptz,
  archived_at timestamptz,
  next_action text,
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.agenda_events (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid references public.clients(id) on delete set null,
  client_name text,
  process_id uuid references public.processes(id) on delete set null,
  process_number text,
  task_id uuid references public.tasks(id) on delete set null,
  title text not null,
  description text,
  type text,
  status text default 'agendado',
  priority text default 'média',
  risk text,
  responsible text,
  starts_at timestamptz not null,
  ends_at timestamptz,
  reminder_at timestamptz,
  location text,
  next_action text,
  notes text,
  completed_at timestamptz,
  archived_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.financial_records (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid references public.clients(id) on delete set null,
  client_name text,
  process_id uuid references public.processes(id) on delete set null,
  process_number text,
  task_id uuid references public.tasks(id) on delete set null,
  agenda_event_id uuid references public.agenda_events(id) on delete set null,
  title text not null,
  description text,
  type text,
  direction text default 'entrada',
  status text default 'pendente',
  amount numeric(14,2) not null default 0,
  paid_amount numeric(14,2),
  due_at date,
  paid_at timestamptz,
  installment_number integer,
  installment_total integer,
  responsible text,
  payment_method text default 'nao_definido',
  category text,
  next_action text,
  notes text,
  archived_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index if not exists processes_workspace_id_idx on public.processes(workspace_id);
create index if not exists processes_client_id_idx on public.processes(client_id);
create index if not exists tasks_workspace_id_idx on public.tasks(workspace_id);
create index if not exists tasks_client_id_idx on public.tasks(client_id);
create index if not exists tasks_process_id_idx on public.tasks(process_id);
create index if not exists agenda_events_workspace_id_idx on public.agenda_events(workspace_id);
create index if not exists agenda_events_client_id_idx on public.agenda_events(client_id);
create index if not exists agenda_events_process_id_idx on public.agenda_events(process_id);
create index if not exists financial_records_workspace_id_idx on public.financial_records(workspace_id);
create index if not exists financial_records_client_id_idx on public.financial_records(client_id);
create index if not exists financial_records_process_id_idx on public.financial_records(process_id);

create or replace trigger set_processes_updated_at before update on public.processes for each row execute function public.set_updated_at();
create or replace trigger set_tasks_updated_at before update on public.tasks for each row execute function public.set_updated_at();
create or replace trigger set_agenda_events_updated_at before update on public.agenda_events for each row execute function public.set_updated_at();
create or replace trigger set_financial_records_updated_at before update on public.financial_records for each row execute function public.set_updated_at();

alter table public.processes enable row level security;
alter table public.tasks enable row level security;
alter table public.agenda_events enable row level security;
alter table public.financial_records enable row level security;

drop policy if exists "members read processes" on public.processes;
create policy "members read processes" on public.processes for select to authenticated using (public.is_workspace_member(workspace_id));
drop policy if exists "members insert processes" on public.processes;
create policy "members insert processes" on public.processes for insert to authenticated with check (public.is_workspace_member(workspace_id));
drop policy if exists "members update processes" on public.processes;
create policy "members update processes" on public.processes for update to authenticated using (public.is_workspace_member(workspace_id)) with check (public.is_workspace_member(workspace_id));

drop policy if exists "members read tasks" on public.tasks;
create policy "members read tasks" on public.tasks for select to authenticated using (public.is_workspace_member(workspace_id));
drop policy if exists "members insert tasks" on public.tasks;
create policy "members insert tasks" on public.tasks for insert to authenticated with check (public.is_workspace_member(workspace_id));
drop policy if exists "members update tasks" on public.tasks;
create policy "members update tasks" on public.tasks for update to authenticated using (public.is_workspace_member(workspace_id)) with check (public.is_workspace_member(workspace_id));

drop policy if exists "members read agenda events" on public.agenda_events;
create policy "members read agenda events" on public.agenda_events for select to authenticated using (public.is_workspace_member(workspace_id));
drop policy if exists "members insert agenda events" on public.agenda_events;
create policy "members insert agenda events" on public.agenda_events for insert to authenticated with check (public.is_workspace_member(workspace_id));
drop policy if exists "members update agenda events" on public.agenda_events;
create policy "members update agenda events" on public.agenda_events for update to authenticated using (public.is_workspace_member(workspace_id)) with check (public.is_workspace_member(workspace_id));

drop policy if exists "members read financial records" on public.financial_records;
create policy "members read financial records" on public.financial_records for select to authenticated using (public.is_workspace_member(workspace_id));
drop policy if exists "members insert financial records" on public.financial_records;
create policy "members insert financial records" on public.financial_records for insert to authenticated with check (public.is_workspace_member(workspace_id));
drop policy if exists "members update financial records" on public.financial_records;
create policy "members update financial records" on public.financial_records for update to authenticated using (public.is_workspace_member(workspace_id)) with check (public.is_workspace_member(workspace_id));
