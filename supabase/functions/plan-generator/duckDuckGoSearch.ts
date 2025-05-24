export interface VideoResult {
  id: string;
  title: string;
  url: string;
  thumbnail_url: string;
}

function extractYouTubeVideoIds(html: string): string[] {
  const links = html.match(/\/watch\?v=[\w-]{11}/g) || [];
  const seen = new Set<string>();
  const ids: string[] = [];

  for (const link of links) {
    const videoId = link.split("v=")[1];
    if (videoId && !seen.has(videoId)) {
      seen.add(videoId);
      ids.push(videoId);
    }
    if (ids.length >= 2) break; // Limit to 2
  }

  return ids;
}


async function fetchYouTubeMetadata(
  videoId: string
): Promise<VideoResult | null> {
  try {
    const res = await fetch(
      `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=${videoId}&format=json`
    );

    if (!res.ok) return null;
    const data = await res.json();

    return {
      id: videoId,
      title: data.title,
      url: `https://www.youtube.com/watch?v=${videoId}`,
      thumbnail_url: data.thumbnail_url,
    };
  } catch (_) {
    return null;
  }
}

export async function searchYouTubeViaDuckDuckGo(
  query: string
): Promise<VideoResult[]> {
  console.log(`[DuckDuckGo] Searching for: ${query}`);

  const url = `https://html.duckduckgo.com/html/?q=${encodeURIComponent(
    query + " site:youtube.com"
  )}`;
  const html = await fetch(url)
    .then((res) => res.text())
    .catch((err) => {
      console.error("[DuckDuckGo] Failed to fetch:", err);
      return "";
    });

  const videoIds = extractYouTubeVideoIds(html);
  console.log(`[DuckDuckGo] Found video IDs:`, videoIds);

  const videos = await Promise.all(videoIds.map(fetchYouTubeMetadata));
  const filtered = videos.filter((v): v is VideoResult => v !== null);

  console.log(
    `[DuckDuckGo] Final video results for query "${query}":`,
    filtered
  );
  return filtered;
}
