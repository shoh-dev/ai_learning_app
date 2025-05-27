// plan_types.ts  (all snake_case)

export interface ActionHint {
  icon: string; // Material Symbol name
  value: string; // detail text
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
  id: string;
  topic: string;
  mode: "milestones";
  milestones: Milestone[];
}
