interface YouTubeVideo {
  id: string;
  title: string;
  url: string;
  thumbnail_url: string;
  duration_seconds?: number;
}

export async function youtubeSearch(
  query: string,
  apiKey: string,
  maxResults: number = 2
): Promise<YouTubeVideo[]> {
  const base = "https://www.googleapis.com/youtube/v3/search";
  const params = new URLSearchParams({
    part: "snippet",
    q: query,
    type: "video",
    videoEmbeddable: "true",
    videoSyndicated: "true",
    videoLicense: "creativeCommon", // filter for CC videos
    maxResults: String(maxResults),
    key: apiKey,
  });

  const searchUrl = `${base}?${params.toString()}`;
  const res = await fetch(searchUrl);
  const data = await res.json();

  const items = data?.items ?? [];
  return items.map((item: any) => {
    const videoId = item.id.videoId;
    const title = item.snippet.title;
    const url = `https://www.youtube.com/watch?v=${videoId}`;
    const thumbnail_url = item.snippet.thumbnails?.high?.url ?? "";
    return {
      id: videoId,
      title,
      url,
      thumbnail_url,
    };
  });
}
