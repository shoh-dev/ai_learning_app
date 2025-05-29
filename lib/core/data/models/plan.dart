// lib/data/models/plan.dart
// ----------------------------------------------
// Plain-Dart model classes (no code-gen)
// ----------------------------------------------

import 'dart:convert';

class Plan {
  final String id;
  final String topic;
  final String originalTopic;
  final List<Milestone> milestones;
  final DateTime createdAt;

  Plan({
    required this.id,
    required this.topic,
    required this.originalTopic,
    required this.milestones,
    required this.createdAt,
  });

  /// Fallback factory – tolerates missing / null keys
  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      topic: json['topic'] ?? '',
      originalTopic: json['original_topic'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      milestones:
          (json['milestones'] as List<dynamic>? ?? [])
              .map((e) => Milestone.fromJson(e as Map))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'topic': topic,
    'milestones': milestones.map((e) => e.toJson()).toList(),
  };

  /// Convenience helper if you get the raw string
  static Plan fromJsonString(String src) =>
      Plan.fromJson(jsonDecode(src) as Map<String, dynamic>);

  //replace plan milestone
  Plan replaceMilestone(Milestone milestone) {
    return Plan(
      id: id,
      topic: topic,
      originalTopic: originalTopic,
      createdAt: createdAt,
      milestones:
          milestones.map((e) => e.id == milestone.id ? milestone : e).toList(),
    );
  }
}

class Milestone {
  final String id;
  final String title;
  final String description;
  final String? resourceUrl;
  final List<Substep> substeps;
  final Quiz? quiz;
  final bool canGenerateImage;
  final String generatedImageUrl;

  Milestone({
    required this.id,
    required this.title,
    required this.description,
    this.resourceUrl,
    required this.substeps,
    this.quiz,
    required this.canGenerateImage,
    required this.generatedImageUrl,
  });

  factory Milestone.fromJson(Map json) {
    return Milestone(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      resourceUrl: json['resource_url'] as String?,
      substeps:
          (json['substeps'] as List<dynamic>? ?? [])
              .map((e) => Substep.fromJson(e as Map))
              .toList(),
      quiz:
          json['quiz'] != null
              ? Quiz.fromJson(((json['quiz'] as List).firstOrNull ?? {}) as Map)
              : null,
      canGenerateImage: json['can_generate_image'] ?? false,
      generatedImageUrl: json['generated_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'resource_url': resourceUrl,
    'substeps': substeps.map((e) => e.toJson()).toList(),
    if (quiz != null) 'quiz': quiz!.toJson(),
    'can_generate_image': canGenerateImage,
  };

  Milestone copyWith({String? generatedImageUrl}) {
    return Milestone(
      id: id,
      title: title,
      description: description,
      resourceUrl: resourceUrl,
      substeps: substeps,
      quiz: quiz,
      canGenerateImage: canGenerateImage,
      generatedImageUrl: generatedImageUrl ?? this.generatedImageUrl,
    );
  }
}

class Substep {
  final String title;
  final String? detailUrl;
  final String? downloadUrl;
  final ActionHint? actionHint;
  final int? estimatedMinutes;

  Substep({
    required this.title,
    this.detailUrl,
    this.downloadUrl,
    this.actionHint,
    this.estimatedMinutes,
  });

  factory Substep.fromJson(Map json) {
    return Substep(
      title: json['title'] ?? '',
      detailUrl: json['detail_url'] as String?,
      downloadUrl: json['download_url'] as String?,
      actionHint:
          json['action_hints'] != null
              ? ActionHint.fromJson(json['action_hints'] as Map)
              : null,
      estimatedMinutes: json['estimated_minutes'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'detail_url': detailUrl,
    'download_url': downloadUrl,
    if (actionHint != null) 'action_hint': actionHint!.toJson(),
    if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
  };
}

class ActionHint {
  final String icon; // Material Symbol name
  final String value;

  ActionHint({required this.icon, required this.value});

  factory ActionHint.fromJson(Map json) =>
      ActionHint(icon: json['icon'] ?? '', value: json['value'] ?? '');

  Map<String, dynamic> toJson() => {'icon': icon, 'value': value};
}

class Quiz {
  final String question;
  final List<String> choices;
  final int correctAnswerIndex;

  Quiz({
    required this.question,
    required this.choices,
    required this.correctAnswerIndex,
  });

  factory Quiz.fromJson(Map json) {
    return Quiz(
      question: json['question'] ?? '',
      choices:
          (json['quiz_choices'] as List? ?? [])
              .map((e) => e['choice_text'] as String)
              .toList(),
      correctAnswerIndex: json['correct_answer_index'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'choices': choices,
    'correct_answer_index': correctAnswerIndex,
  };
}
