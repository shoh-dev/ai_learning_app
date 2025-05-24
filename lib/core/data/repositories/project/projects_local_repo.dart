import 'dart:convert';

import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:ai_learning_app/core/data/repositories/project/projects_repo.dart';
import 'package:ai_learning_app/core/utils/generate_id.dart';
import 'package:hive/hive.dart';

class ProjectsLocalRepo extends ProjectsRepo {
  final Box<String> _projectsBox;

  ProjectsLocalRepo(this._projectsBox);

  @override
  Future<Project> createProject({
    required String topic,
    required String size,
  }) async {
    final project = Project(
      id: generateId('prj'),
      topic: topic,
      size: size,
      createdAt: DateTime.now(),
      tasks: <Task>[],
    );
    await _projectsBox.put(project.id, jsonEncode(project.toJson()));
    return project;
  }

  @override
  Future<void> deleteProject(String id) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Project? getProject(String id) {
    // TODO: implement getProject
    throw UnimplementedError();
  }
}
