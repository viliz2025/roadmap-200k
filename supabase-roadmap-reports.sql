create table if not exists public.roadmap_reports (
  id uuid primary key default gen_random_uuid(),

  owner_id text not null,
  step_id int not null,
  step_title text not null,
  deadline text,
  reward_rub int,
  days_total int,
  days_done int,

  is_done boolean default false,
  done_at timestamptz,
  updated_at timestamptz default now(),

  report_data jsonb default '{}'::jsonb,
  daily_data jsonb default '{}'::jsonb,
  checklist jsonb default '[]'::jsonb,
  local_state jsonb default '{}'::jsonb,

  created_at timestamptz default now()
);

create unique index if not exists roadmap_reports_owner_step_unique
on public.roadmap_reports (owner_id, step_id);

alter table public.roadmap_reports enable row level security;

drop policy if exists "Allow public insert roadmap reports"
on public.roadmap_reports;

create policy "Allow public insert roadmap reports"
on public.roadmap_reports
for insert
to anon
with check (owner_id = 'lyubov-main-roadmap');

drop policy if exists "Allow public update roadmap reports"
on public.roadmap_reports;

create policy "Allow public update roadmap reports"
on public.roadmap_reports
for update
to anon
using (owner_id = 'lyubov-main-roadmap')
with check (owner_id = 'lyubov-main-roadmap');

drop policy if exists "Allow public select roadmap reports"
on public.roadmap_reports;

create policy "Allow public select roadmap reports"
on public.roadmap_reports
for select
to anon
using (owner_id = 'lyubov-main-roadmap');
