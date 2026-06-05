-- LEX.OS Control — seed demonstrativo seguro para Etapa 3A.
-- Dados 100% fictícios. Não contém CPF, OAB, processo, e-mail ou cliente real.
-- Execute após supabase/schema.sql. Para vincular usuário real, crie um usuário em Auth
-- e insira manualmente uma linha em public.workspace_members com o auth.users.id desse usuário.

insert into public.workspaces (id, name, slug, status)
values ('00000000-0000-4000-8000-000000000301', 'Workspace Demo LEX.OS Control', 'lexos-demo-control', 'active')
on conflict (id) do update set
  name = excluded.name,
  slug = excluded.slug,
  status = excluded.status;

insert into public.clients (
  id,
  workspace_id,
  name,
  type,
  document,
  email,
  phone,
  status,
  owner,
  segment,
  pending,
  next_action,
  notes
)
values
  (
    '00000000-0000-4000-8000-000000000311',
    '00000000-0000-4000-8000-000000000301',
    'Cliente Demo Aurora Consultoria',
    'pessoa_juridica',
    '00.000.000/0000-00',
    'aurora.demo@example.invalid',
    '(11) 90000-0000',
    'ativo',
    'Equipe Demo',
    'Consultivo empresarial fictício',
    'Validar documentos fictícios de onboarding',
    'Agendar reunião demonstrativa',
    'Registro fictício para homologação controlada.'
  ),
  (
    '00000000-0000-4000-8000-000000000312',
    '00000000-0000-4000-8000-000000000301',
    'Cliente Demo Bento Lima',
    'pessoa_fisica',
    '000.000.000-00',
    'bento.demo@example.invalid',
    '(21) 90000-0000',
    'prospect',
    'Equipe Demo',
    'Planejamento patrimonial fictício',
    'Aguardar informações demonstrativas',
    'Enviar checklist fictício',
    'Registro fictício sem dado pessoal real.'
  )
on conflict (id) do update set
  name = excluded.name,
  status = excluded.status,
  updated_at = now();
