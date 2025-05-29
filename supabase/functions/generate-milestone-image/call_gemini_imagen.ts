const GEMINI_URL =
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-preview-image-generation:generateContent";

export async function callGeminiImagen(
  prompt: string,
  apiKey: string
): Promise<any> {
  const url = GEMINI_URL;

  const response = await fetch(`${url}?key=${apiKey}`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: { responseModalities: ["TEXT", "IMAGE"] },
      // generationConfig: {
      //   temperature: 0.7,
      //   topP: 0.9,
      //   topK: 40,
      // },
    }),
  });

  if (!response.ok) {
    throw new Error(await response.text());
  }

  const body = await response.json();

  console.info(body.candidates);

  for (const part of body.candidates?.[0]?.content?.parts) {
    if (part.inlineData) {
      return part.inlineData;
    }
  }

  throw new Error("No image found");
}
