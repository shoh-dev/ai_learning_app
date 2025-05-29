import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import { supabase } from "../_utils/supabase_client.ts"; // same client setup
const JSON_HEADER = { "Content-Type": "application/json" };

Deno.serve(async (req) => {
  if (req.method !== "GET") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: JSON_HEADER,
    });
  }

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
  console.log("[get-plans] userId", userId);

  //  `
  //   *,
  //   milestones (
  //     *,
  //     substeps (
  //       *,
  //       action_hints (*)
  //     ),
  //     quiz:quizzes (
  //       *,
  //       quiz_choices (*)
  //     )
  //   )
  // `;

  /* ---- fetch with nested relations ---- */
  const { data, error } = await supabase
    .from("plans")
    .select()
    .eq("user_id", userId)
    .order("created_at", { ascending: false });
  // .order("position", { referencedTable: "milestones" });
  // .order("substeps.position", { foreignTable: "milestones" });

  if (error) {
    console.error("[get-plans] DB error", error);
    return new Response(JSON.stringify({ error: "Database fetch failed" }), {
      status: 500,
      headers: JSON_HEADER,
    });
  }

  return new Response(JSON.stringify({ plans: data }), {
    status: 200,
    headers: JSON_HEADER,
  });
});
