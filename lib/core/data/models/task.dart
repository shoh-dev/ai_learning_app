class Task {
  Task({
    required this.id,
    required this.projectId,
    required this.kind, // "video" | "resource" | "image"
    required this.title,
    required this.url,
    this.thumbnailUrl,
    this.durationMinutes,
    this.description,
    required this.position,
  });

  final String id;
  final String projectId;
  final String kind;
  final String title;
  final String url;
  final String? thumbnailUrl;
  final int? durationMinutes;
  final String? description;
  final int position;

  // ---------- JSON helpers ----------
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    projectId: json['projectId'],
    kind: json['kind'],
    title: json['title'],
    url: json['url'],
    thumbnailUrl: json['thumbnailUrl'],
    durationMinutes: json['durationMinutes'],
    description: json['description'],
    position: json['position'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'kind': kind,
    'title': title,
    'url': url,
    'thumbnailUrl': thumbnailUrl,
    'durationMinutes': durationMinutes,
    'description': description,
    'position': position,
  };
}
