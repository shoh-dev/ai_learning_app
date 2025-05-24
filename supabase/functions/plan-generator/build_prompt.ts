// build_prompt.ts
export function buildPrompt(
  topic: string,
  attempt: number = 1,
  size_hint: "small" | "large" = "small"
): string {
  const retryNote =
    attempt > 1
      ? "⚠️ Previous plan wasn't helpful. Try another interpretation.\n"
      : "";

  const seed = crypto.randomUUID().slice(0, 8);

  return `
You are an **AI learning coach**.

User goal:
  "${topic}"

${retryNote}### Response SIZE
The app passes a hint called **"${size_hint}"**  
• "small" → user wants a quick-start / minimal plan.  
• "large" → user wants a full, in-depth curriculum.  

Adjust output length accordingly:

| size_hint | milestones | substeps per milestone |
|-----------|------------|------------------------|
| small     | 3-5        | 1-3 (only key actions) |
| large     | 7-12       | 2-6 (detailed)         |

---

### JSON contract  (snake_case — do **NOT** change keys)

{
  "topic": "...",
  "mode": "milestones",
  "milestones": [
    {
      "title": "...",
      "description": "...",
      "resource_url": "... | null",
      "substeps": [
        {
          "title": "...",
          "detail_url": "... | null",
          "download_url": "... | null",
          "action_hint": {          // OPTIONAL
            "icon": "<Material Symbol>",
            "value": "..."
          },
          "estimated_minutes": 5    // OPTIONAL integer
        }
      ],
      "quiz": {                     // OPTIONAL
        "question": "...",
        "choices": ["..."],
        "correct_answer_index": 0
      },
      "can_generate_image": true | false
    }
  ]
}

Guidelines  
• Respect size table above for counts.  
• Add substeps only when needed (2-6).  
• 'action_hint.icon' must be a valid Material Symbol (terminal, timer, thermostat, build, notifications_off, keyboard_alt, download …).  
• 'can_generate_image' = true when the milestone’s outcome is visual.  
• Omit 'quiz' when not useful.  
• Use **null** for missing URLs.  
• Respond with **JSON only** — no markdown, no commentary.

(random_seed: ${seed})
`;
}