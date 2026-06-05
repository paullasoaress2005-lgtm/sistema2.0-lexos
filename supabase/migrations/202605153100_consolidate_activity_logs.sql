-- ETAPA 3M: consolida activity_logs para auditoria operacional real por workspace.
-- Migração aditiva e segura: preserva colunas legadas (user_id/module) e não remove dados.

alter table public.activity_logs
  add column if not exists actor_user_id uuid references auth.users(id) on delete set null,
  add column if not exists entity_type text,
  add column if not exists title text,
  add column if not exists metadata jsonb not null default '{}'::jsonb;

update public.activity_logs
set actor_user_id = coalesce(actor_user_id, user_id)
where actor_user_id is null and user_id is not null;

update public.activity_logs
set entity_type = coalesce(entity_type, module)
where entity_type is null and module is not null;

alter table public.activity_logs
  alter column metadata set default '{}'::jsonb;

-- Só endurece NOT NULL quando não há registros antigos incompatíveis.
do $$
begin
  if not exists (select 1 from public.activity_logs where workspace_id is null) then
    alter table public.activity_logs alter column workspace_id set not null;
  end if;

  if not exists (select 1 from public.activity_logs where entity_type is null) then
    alter table public.activity_logs alter column entity_type set not null;
  end if;

  if not exists (select 1 from public.activity_logs where created_at is null) then
    alter table public.activity_logs alter column created_at set not null;
  end if;
end $$;

create index if not exists activity_logs_workspace_created_at_idx on public.activity_logs(workspace_id, created_at desc);
create index if not exists activity_logs_entity_type_idx on public.activity_logs(entity_type);
create index if not exists activity_logs_action_idx on public.activity_logs(action);

alter table public.activity_logs enable row level security;

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
