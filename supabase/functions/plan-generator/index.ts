import { buildPrompt } from "./build_prompt.ts";
import { callGemini } from "./call_gemini.ts";
import { PlanResponse } from "./types.ts";
import { MOCK_PLAN } from "./mock_debug.ts";

const isDebugMode = true; // ← set true to skip Gemini & use MOCK_PLAN
const JSON_HEADER = { "Content-Type": "application/json" };

// ────────────────────────────────────────────────────────────
// ENV
// ────────────────────────────────────────────────────────────
const GEMINI_API_KEY =
  Deno.env.get("GEMINI_API_KEY") ?? "";

// Main entrypoint
Deno.serve(async (req) => {
  // ── 1 · method guard
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: JSON_HEADER,
    });
  }

  // ── 2 · parse body
  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return new Response(JSON.stringify({ error: "Invalid JSON body" }), {
      status: 400,
      headers: JSON_HEADER,
    });
  }

  const topic = (body as any)?.topic?.trim?.() ?? "";
  const size_hint = (body as any)?.size_hint ?? "small";
  const attempt = Number((body as any)?.attempt ?? 1);

  if (!topic) {
    return new Response(JSON.stringify({ error: "Missing topic" }), {
      status: 400,
      headers: JSON_HEADER,
    });
  }

  // ── 3 · produce plan (debug or live)
  let plan: PlanResponse;

  if (isDebugMode) {
    plan = MOCK_PLAN;
  } else {
    try {
      const prompt = buildPrompt(topic, attempt, size_hint);
      plan = (await callGemini(prompt, GEMINI_API_KEY)) as PlanResponse;
    } catch (err) {
      console.error("[Gemini] failure:", err);
      return new Response(JSON.stringify({ error: "Gemini API failed" }), {
        status: 502,
        headers: JSON_HEADER,
      });
    }
  }

  // ── 4 · return JSON
  return new Response(JSON.stringify(plan), {
    status: 200,
    headers: JSON_HEADER,
  });
});
