-- LEX.OS Control — Etapa 3F
-- Financeiro real por workspace, com vínculos opcionais a clientes, processos, tarefas, agenda e parcerias.
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

create table if not exists public.financial_records (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  client_id uuid null references public.clients(id) on delete set null,
  process_id uuid null references public.processes(id) on delete set null,
  task_id uuid null references public.tasks(id) on delete set null,
  agenda_event_id uuid null references public.agenda_events(id) on delete set null,
  partnership_id uuid null references public.process_partnerships(id) on delete set null,
  title text not null,
  description text null,
  record_type text not null default 'honorarios',
  direction text not null default 'entrada',
  status text not null default 'pending',
  amount numeric not null default 0,
  paid_amount numeric null,
  due_date date null,
  paid_at timestamptz null,
  installment_number integer null,
  installment_total integer null,
  responsible text null,
  payment_method text null default 'nao_definido',
  category text null,
  next_action text null,
  notes text null,
  metadata jsonb not null default '{}'::jsonb,
  canceled_at timestamptz null,
  archived_at timestamptz null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.financial_records add column if not exists client_id uuid null references public.clients(id) on delete set null;
alter table public.financial_records add column if not exists process_id uuid null references public.processes(id) on delete set null;
alter table public.financial_records add column if not exists task_id uuid null references public.tasks(id) on delete set null;
alter table public.financial_records add column if not exists agenda_event_id uuid null references public.agenda_events(id) on delete set null;
alter table public.financial_records add column if not exists partnership_id uuid null references public.process_partnerships(id) on delete set null;
alter table public.financial_records add column if not exists description text null;
alter table public.financial_records add column if not exists record_type text not null default 'honorarios';
alter table public.financial_records add column if not exists direction text not null default 'entrada';
alter table public.financial_records add column if not exists status text not null default 'pending';
alter table public.financial_records add column if not exists amount numeric not null default 0;
alter table public.financial_records add column if not exists paid_amount numeric null;
alter table public.financial_records add column if not exists due_date date null;
alter table public.financial_records add column if not exists paid_at timestamptz null;
alter table public.financial_records add column if not exists installment_number integer null;
alter table public.financial_records add column if not exists installment_total integer null;
alter table public.financial_records add column if not exists responsible text null;
alter table public.financial_records add column if not exists payment_method text null default 'nao_definido';
alter table public.financial_records add column if not exists category text null;
alter table public.financial_records add column if not exists next_action text null;
alter table public.financial_records add column if not exists notes text null;
alter table public.financial_records add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.financial_records add column if not exists canceled_at timestamptz null;
alter table public.financial_records add column if not exists archived_at timestamptz null;
alter table public.financial_records add column if not exists created_at timestamptz not null default now();
alter table public.financial_records add column if not exists updated_at timestamptz not null default now();
alter table public.financial_records alter column record_type set default 'honorarios';
alter table public.financial_records alter column direction set default 'entrada';
alter table public.financial_records alter column status set default 'pending';
alter table public.financial_records alter column amount set default 0;
alter table public.financial_records alter column payment_method set default 'nao_definido';
alter table public.financial_records alter column metadata set default '{}'::jsonb;

create index if not exists financial_records_workspace_id_idx on public.financial_records(workspace_id);
create index if not exists financial_records_client_id_idx on public.financial_records(client_id);
create index if not exists financial_records_process_id_idx on public.financial_records(process_id);
create index if not exists financial_records_task_id_idx on public.financial_records(task_id);
create index if not exists financial_records_agenda_event_id_idx on public.financial_records(agenda_event_id);
create index if not exists financial_records_partnership_id_idx on public.financial_records(partnership_id);
create index if not exists financial_records_record_type_idx on public.financial_records(record_type);
create index if not exists financial_records_direction_idx on public.financial_records(direction);
create index if not exists financial_records_status_idx on public.financial_records(status);
create index if not exists financial_records_due_date_idx on public.financial_records(due_date);
create index if not exists financial_records_paid_at_idx on public.financial_records(paid_at);
create index if not exists financial_records_responsible_idx on public.financial_records(responsible);
create index if not exists financial_records_archived_at_idx on public.financial_records(archived_at);
create index if not exists financial_records_canceled_at_idx on public.financial_records(canceled_at);

create or replace trigger set_financial_records_updated_at
before update on public.financial_records
for each row execute function public.set_updated_at();

alter table public.financial_records enable row level security;

drop policy if exists "members read financial records" on public.financial_records;
create policy "members read financial records"
  on public.financial_records for select
  to authenticated
  using (public.is_workspace_member(workspace_id));

drop policy if exists "members insert financial records" on public.financial_records;
create policy "members insert financial records"
  on public.financial_records for insert
  to authenticated
  with check (public.is_workspace_member(workspace_id));

drop policy if exists "members update financial records" on public.financial_records;
create policy "members update financial records"
  on public.financial_records for update
  to authenticated
  using (public.is_workspace_member(workspace_id))
  with check (public.is_workspace_member(workspace_id));
