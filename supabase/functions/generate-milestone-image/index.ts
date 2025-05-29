import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { supabase } from "../_utils/supabase_client.ts";
import { callGeminiImagen } from "./call_gemini_imagen.ts";

import { decode } from "npm:base64-arraybuffer";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY") ?? "";

Deno.serve(async (req) => {
  const { milestone_id } = await req.json();

  console.log("milestoneId", milestone_id);

  // 1. Fetch milestone
  const { data: milestone, error } = await supabase
    .from("milestones")
    .select("*")
    .eq("id", milestone_id)
    .single();

  if (error || !milestone) {
    return new Response(JSON.stringify({ error: "Milestone not found." }), {
      status: 404,
    });
  }

  if (!milestone.can_generate_image) {
    return new Response(
      JSON.stringify({ error: "Image generation not allowed." }),
      { status: 403 }
    );
  }

  // 2. Construct prompt
  const prompt = `
  Create an illustration that represents: ${milestone.description}.

  The illustration should be a single image that is 1024x1024 pixels.

  Make sure to make it highly detailed and colorful and must highlight the main points of the description.

  It should be a high-quality image that is easy to understand and visually appealing.
  `;

  // 3. Generate image via AI (replace with your actual image API)
  const imageResponse = await callGeminiImagen(prompt, GEMINI_API_KEY);

  //save image to supabase storage
  await supabase.storage
    .from("milestone-images")
    .upload(milestone_id, decode(imageResponse.data), {
      contentType: imageResponse.mimeType,
      upsert: true,
    });

  //get public url
  const { data: imageUrl } = await supabase.storage
    .from("milestone-images")
    .getPublicUrl(milestone_id);

  // 4. Save image URL back to the milestone
  await supabase
    .from("milestones")
    .update({ generated_image_url: imageUrl.publicUrl })
    .eq("id", milestone_id);

  return new Response(imageUrl.publicUrl, {
    status: 200,
  });
});
