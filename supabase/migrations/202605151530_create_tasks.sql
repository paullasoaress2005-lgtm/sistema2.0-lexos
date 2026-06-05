-- LEX.OS Control — Etapa 3D
-- Tarefas reais por workspace, com vínculos opcionais a clientes/processos e RLS por membership ativo.
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

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid null references public.clients(id) on delete set null,
  process_id uuid null references public.processes(id) on delete set null,
  title text not null,
  description text null,
  status text not null default 'pending',
  priority text not null default 'medium',
  task_type text null,
  responsible text null,
  due_date date null,
  due_at timestamptz null,
  completed_at timestamptz null,
  archived_at timestamptz null,
  next_action text null,
  notes text null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
 );

alter table public.tasks add column if not exists client_id uuid null references public.clients(id) on delete set null;
alter table public.tasks add column if not exists process_id uuid null references public.processes(id) on delete set null;
alter table public.tasks add column if not exists description text null;
alter table public.tasks add column if not exists status text not null default 'pending';
alter table public.tasks add column if not exists priority text not null default 'medium';
alter table public.tasks add column if not exists task_type text null;
alter table public.tasks add column if not exists responsible text null;
alter table public.tasks add column if not exists due_date date null;
alter table public.tasks add column if not exists due_at timestamptz null;
alter table public.tasks add column if not exists completed_at timestamptz null;
alter table public.tasks add column if not exists archived_at timestamptz null;
alter table public.tasks add column if not exists next_action text null;
alter table public.tasks add column if not exists notes text null;
alter table public.tasks add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.tasks add column if not exists created_at timestamptz not null default now();
alter table public.tasks add column if not exists updated_at timestamptz not null default now();
alter table public.tasks alter column status set default 'pending';
alter table public.tasks alter column priority set default 'medium';
alter table public.tasks alter column metadata set default '{}'::jsonb;
alter table public.tasks alter column due_at type timestamptz using due_at::timestamptz;

create index if not exists tasks_workspace_id_idx on public.tasks(workspace_id);
create index if not exists tasks_client_id_idx on public.tasks(client_id);
create index if not exists tasks_process_id_idx on public.tasks(process_id);
create index if not exists tasks_status_idx on public.tasks(status);
create index if not exists tasks_priority_idx on public.tasks(priority);
create index if not exists tasks_due_date_idx on public.tasks(due_date);
create index if not exists tasks_responsible_idx on public.tasks(responsible);
create index if not exists tasks_archived_at_idx on public.tasks(archived_at);

create or replace trigger set_tasks_updated_at
before update on public.tasks
for each row execute function public.set_updated_at();

alter table public.tasks enable row level security;

drop policy if exists "members read tasks" on public.tasks;
create policy "members read tasks"
  on public.tasks for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert tasks" on public.tasks;
create policy "members insert tasks"
  on public.tasks for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update tasks" on public.tasks;
create policy "members update tasks"
  on public.tasks for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));
