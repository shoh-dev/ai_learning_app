# AI-Learning-Coach — 2025 MVP Playbook  

> **Purpose**  A mobile-first companion that converts any user request into a structured learning path (milestones → sub-steps), with optional quizzes and AI-generated images.  

---

## 1 ·  Wire-Format (spec)  

```ts
// plan_types.ts  (all snake_case)
export interface ActionHint {
  icon: string;          // Material Symbols name  e.g. "terminal", "timer"
  value: string;         // the actionable detail
}

export interface Substep {
  title: string;
  detail_url: string | null;
  download_url: string | null;
  action_hint?: ActionHint;
  estimated_minutes?: number;
}

export interface Quiz {
  question: string;
  choices: string[];
  correct_answer_index: number;
}

export interface Milestone {
  title: string;
  description: string;
  resource_url: string | null;
  substeps: Substep[];
  quiz?: Quiz;
  can_generate_image: boolean;
}

export interface PlanResponse {
  topic: string;
  mode: "milestones";
  milestones: Milestone[];
}

{
  "topic": "Learn Basic Mindfulness Meditation",
  "mode": "milestones",
  "milestones": [
    {
      "title": "Prepare a Quiet Space",
      "description": "Choose a calm spot, silence devices, and sit comfortably with good posture.",
      "resource_url": "https://www.mindful.org/meditation/mindfulness-getting-started/",
      "substeps": [
        {
          "title": "Silence phone notifications",
          "detail_url": null,
          "download_url": null,
          "action_hint": { "icon": "notifications_off", "value": "Enable Do-Not-Disturb" },
          "estimated_minutes": 1
        },
        {
          "title": "Set a 5-minute timer",
          "detail_url": null,
          "download_url": null,
          "action_hint": { "icon": "timer", "value": "5 min" },
          "estimated_minutes": 1
        }
      ],
      "quiz": null,
      "can_generate_image": false
    },
    {
      "title": "Practise Focused Breathing",
      "description": "Pay attention to inhaling and exhaling; gently return when the mind wanders.",
      "resource_url": "https://www.healthline.com/health/breathing-exercise",
      "substeps": [
        {
          "title": "Inhale through the nose for 4 counts",
          "detail_url": null,
          "download_url": null,
          "action_hint": { "icon": "timer", "value": "4 s" },
          "estimated_minutes": 0
        },
        {
          "title": "Exhale through the mouth for 6 counts",
          "detail_url": null,
          "download_url": null,
          "action_hint": { "icon": "timer", "value": "6 s" },
          "estimated_minutes": 0
        }
      ],
      "quiz": {
        "question": "If your thoughts wander, what should you do?",
        "choices": [
          "Analyse the thought",
          "Gently notice and refocus",
          "Stop the session",
          "Forcefully block the thought"
        ],
        "correct_answer_index": 1
      },
      "can_generate_image": true
    }
  ]
}

supabase/functions/plan-generator/
├─ index.ts                  # http entry – validation, premium checks
├─ build_prompt.ts           # creates Gemini prompt
├─ call_gemini.ts            # calls Gemini, returns JSON
├─ plan_types.ts             # ↑ ts interface (see above)
├─ mock_debug.ts             # offline fake response
└─ image_gen.ts              # hits OpenAI image API (premium)


You are an AI learning coach.

User goal:
  "${topic}"

Return ONE JSON object exactly in this shape  (snake_case keys):

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
          "action_hint": {            // OPTIONAL
            "icon": "<Material Symbol>",
            "value": "..."
          },
          "estimated_minutes": 5      // OPTIONAL integer
        }
      ],
      "quiz": {                       // OPTIONAL
        "question": "...",
        "choices": ["...", "..."],
        "correct_answer_index": 0
      },
      "can_generate_image": true | false
    }
  ]
}

Rules
• 5–10 milestones, beginner → advanced.
• Add substeps when a milestone contains multiple distinct actions (2–6 max).
• action_hint.icon must be a valid Material Symbols name (e.g. terminal, timer, thermostat, build, notifications_off, keyboard_alt, download).
• can_generate_image = true if milestone outcome is visual (diagram, cooked dish, UI mock-up…).
• Use null for unavailable URLs.
• If no quiz is suitable, omit the key.
• Respond with JSON only – no markdown, no comments.

(random_seed: ${uuid})

