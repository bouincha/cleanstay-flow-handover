-- Main DB
create table tasks (
  id bigint generated always as identity primary key,
  task_id text unique not null,
  title text,
  description text,
  status text,
  room text,
  deadline timestamptz,
  shift text,
  source text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Handover DB
create table handovers (
  id bigint generated always as identity primary key,
  task_id text,
  priority text,          -- CRITICAL / WARNING / NORMAL
  ai_reason text,
  recommended_action text,
  status text,
  source_shift text,
  target_shift text,
  deadline timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);
