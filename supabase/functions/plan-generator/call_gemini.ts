
const GEMINI_URL =
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

export async function callGemini(prompt: string, apiKey: string): Promise<any> {
  const url = GEMINI_URL;

  const response = await fetch(`${url}?key=${apiKey}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        temperature: 0.7,
        topP: 0.9,
        topK: 40,
      },
    }),
  });

  if (!response.ok) {
    throw new Error(await response.text());
  }

  const body = await response.json();
  const raw = body?.candidates?.[0]?.content?.parts?.[0]?.text ?? "";

  // Remove ```json fences if present
const cleaned = raw
  .replace(/^```json\s*/i, "") // ✅ single backslash: \s
  .replace(/^```/, "") // in case it's just ```
  .replace(/```$/, "") // remove ending ```
  .trim();


  try {
    console.log("[DEBUG] Raw Gemini output:\n", raw);
    console.log("[DEBUG] Cleaned JSON string:\n", cleaned);

    return JSON.parse(cleaned);
  } catch (err) {
    console.error("Failed to parse Gemini JSON:", raw);
    throw new Error("Gemini returned invalid JSON");
  }
}
