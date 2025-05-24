import 'task.dart';

class Project {
  Project({
    required this.id,
    required this.topic,
    required this.size, // "small" | "medium" | "large"
    required this.createdAt,
    required this.tasks,
  });

  final String id;
  final String topic;
  final String size;
  final DateTime createdAt;
  final List<Task> tasks;

  // ---------- JSON helpers ----------
  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'],
    topic: json['topic'],
    size: json['size'],
    createdAt: DateTime.parse(json['createdAt']),
    tasks:
        (json['tasks'] as List)
            .map((t) => Task.fromJson(t as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'topic': topic,
    'size': size,
    'createdAt': createdAt.toIso8601String(),
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };
}
