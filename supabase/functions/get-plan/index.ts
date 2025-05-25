import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import { supabase } from "../plan-generator/supabase_client.ts"; // same client setup
const JSON_HEADER = { "Content-Type": "application/json" };

Deno.serve(async (req) => {
  // ── 1 · method & query guard
  if (req.method !== "GET") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: JSON_HEADER,
    });
  }

  const url = new URL(req.url);
  const planId = url.searchParams.get("id");
  if (!planId) {
    return new Response(JSON.stringify({ error: "Missing id query param" }), {
      status: 400,
      headers: JSON_HEADER,
    });
  }

  // ── 2 · authenticate user via JWT
  const auth = req.headers.get("Authorization") ?? "";
  const jwt = auth.startsWith("Bearer ") ? auth.substring(7) : "";

  const { data: userRes, error: userErr } = await supabase.auth.getUser(jwt);
  if (userErr || !userRes?.user) {
    return new Response(JSON.stringify({ error: "Unauthorized" }), {
      status: 401,
      headers: JSON_HEADER,
    });
  }
  const userId = userRes.user.id;

  // ── 3 · fetch the specific plan with relations
  const { data, error } = await supabase
    .from("plans")
    .select(
      `
      *,
      milestones (
        *,
        substeps (
          *,
          action_hints (*)
        ),
        quiz:quizzes (
          *,
          quiz_choices (*)
        )
      )
    `
    )
    .eq("id", planId)
    .eq("user_id", userId) // RLS guard anyway
    .single(); // expect exactly 1 row

  if (error) {
    const status = error.code === "PGRST116" ? 404 : 500; // not found vs server
    return new Response(JSON.stringify({ error: error.message }), {
      status,
      headers: JSON_HEADER,
    });
  }

  // ── 4 · return JSON
  return new Response(JSON.stringify(data), {
    status: 200,
    headers: JSON_HEADER,
  });
});
