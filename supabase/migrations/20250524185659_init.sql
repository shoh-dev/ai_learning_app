-- migrations/20250525_create_learning_plan_schema.sql
-- ===================================================
-- Creates the relational tables that persist a PlanResponse.
-- Run via:  supabase db push   (or psql -f ...)
-- 1 · extensions ------------------------------------------------------------
create extension if not exists "pgcrypto";

-- for gen_random_uuid()
-- 2 · root table : plans ----------------------------------------------------
create table
    public.plans (
        id uuid primary key default gen_random_uuid (),
        topic text not null,
        user_id uuid not null references auth.users (id) on delete cascade,
        size_hint text not null default 'large', -- 'small' | 'large'
        created_at timestamptz not null default now ()
    );

create index plans_user_idx on public.plans (user_id, created_at desc);

-- 3 · milestones ------------------------------------------------------------
create table
    public.milestones (
        id uuid primary key default gen_random_uuid (),
        plan_id uuid not null references public.plans (id) on delete cascade,
        position int not null, -- 0-based order
        title text not null,
        description text not null,
        resource_url text,
        can_generate_image boolean not null default false,
        created_at timestamptz not null default now ()
    );

create index milestones_plan_idx on public.milestones (plan_id, position);

-- 4 · quizzes ---------------------------------------------------------------
create table
    public.quizzes (
        id uuid primary key default gen_random_uuid (),
        milestone_id uuid not null references public.milestones (id) on delete cascade,
        question text not null,
        correct_answer_index smallint not null,
        created_at timestamptz not null default now ()
    );

-- quiz choices as child rows
create table
    public.quiz_choices (
        quiz_id uuid not null references public.quizzes (id) on delete cascade,
        choice_index smallint not null,
        choice_text text not null,
        primary key (quiz_id, choice_index)
    );

-- 5 · substeps --------------------------------------------------------------
create table
    public.substeps (
        id uuid primary key default gen_random_uuid (),
        milestone_id uuid not null references public.milestones (id) on delete cascade,
        position int not null,
        title text not null,
        detail_url text,
        download_url text,
        estimated_minutes int,
        created_at timestamptz not null default now ()
    );

create index substeps_milestone_idx on public.substeps (milestone_id, position);

-- 6 · action_hints ----------------------------------------------------------
create table
    public.action_hints (
        substep_id uuid primary key references public.substeps (id) on delete cascade,
        icon text not null, -- Material Symbols name
        value text not null
    );

-- 7 · sanity: enforce positions >=0 ----------------------------------------
alter table public.milestones add constraint milestones_position_ck check (position >= 0);

alter table public.substeps add constraint substeps_position_ck check (position >= 0);