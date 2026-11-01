-- Run in Supabase SQL Editor. No destructive statements.
create table if not exists public.license_flow_items (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 license_id text not null,
 kind text not null,
 payload jsonb not null default '{}'::jsonb,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists license_flow_items_user_license on public.license_flow_items(user_id,license_id,kind);
alter table public.license_flow_items enable row level security;
drop policy if exists "license_items_own" on public.license_flow_items;
create policy "license_items_own" on public.license_flow_items for all to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);
