// supabase/functions/plan-generator/save_plan.ts
// -----------------------------------------------------------
// Simpler version: plain `insert()` calls, no RPC, no transaction.
// Generates UUIDs client-side so FK links are resolved before insert.
// -----------------------------------------------------------

import { supabase } from "./supabase_client.ts";
import { PlanResponse, Milestone, Substep } from "./types.ts";

/**
 * Persist a full plan and its children.
 * Throws on any Supabase error.
 */
export async function savePlan(
  userId: string,
  sizeHint: string,
  originalTopic: string,
  plan: PlanResponse
): Promise<string> {
  // ---------- 1 · insert into plans ----------
  const { data: planRow, error: planErr } = await supabase
    .from("plans")
    .insert({
      user_id: userId,
      topic: plan.topic,
      original_topic: originalTopic,
      size_hint: sizeHint,
    })
    .select("id")
    .single();

  if (planErr) throw planErr;
  const planId = planRow.id as string;

  // ---------- 2 · prepare bulk arrays ----------
  const milestoneRows: any[] = [];
  const substepRows: any[] = [];
  const quizRows: any[] = [];
  const choiceRows: any[] = [];
  const hintRows: any[] = [];

  plan.milestones.forEach((m: Milestone, mi: number) => {
    const milestoneId = crypto.randomUUID();
    milestoneRows.push({
      id: milestoneId,
      plan_id: planId,
      position: mi,
      title: m.title,
      description: m.description,
      resource_url: m.resource_url,
      can_generate_image: m.can_generate_image,
    });

    if (m.quiz != null) {
      const quizId = crypto.randomUUID();
      quizRows.push({
        id: quizId,
        milestone_id: milestoneId,
        question: m.quiz.question,
        correct_answer_index: m.quiz.correct_answer_index,
      });
      m.quiz.choices.forEach((c: string, ci: number) =>
        choiceRows.push({
          quiz_id: quizId,
          choice_index: ci,
          choice_text: c,
        })
      );
    }

    m.substeps.forEach((s: Substep, si: number) => {
      const subId = crypto.randomUUID();
      substepRows.push({
        id: subId,
        milestone_id: milestoneId,
        position: si,
        title: s.title,
        detail_url: s.detail_url,
        download_url: s.download_url,
        estimated_minutes: s.estimated_minutes,
      });
      if (s.action_hint != null) {
        hintRows.push({
          substep_id: subId,
          icon: s.action_hint.icon,
          value: s.action_hint.value,
        });
      }
    });
  });

  // ---------- 3 · bulk inserts ----------
  // Order matters for FK constraints.
  const { error: mErr } = await supabase
    .from("milestones")
    .insert(milestoneRows);
  if (mErr) throw mErr;

  if (substepRows.isNotEmpty) {
    const { error: sErr } = await supabase.from("substeps").insert(substepRows);
    if (sErr) throw sErr;
  }

  if (hintRows.isNotEmpty) {
    const { error: hErr } = await supabase
      .from("action_hints")
      .insert(hintRows);
    if (hErr) throw hErr;
  }

  if (quizRows.isNotEmpty) {
    const { error: qErr } = await supabase.from("quizzes").insert(quizRows);
    if (qErr) throw qErr;

    if (choiceRows.isNotEmpty) {
      const { error: cErr } = await supabase
        .from("quiz_choices")
        .insert(choiceRows);
      if (cErr) throw cErr;
    }
  }

  return planId;
}

/* -------- small helper -------- */
declare global {
  interface Array<T> {
    get isNotEmpty(): boolean;
  }
}
Object.defineProperty(Array.prototype, "isNotEmpty", {
  get() {
    return (this as Array<unknown>).length > 0;
  },
});
