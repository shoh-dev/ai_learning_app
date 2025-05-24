import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:myspace_core/myspace_core.dart';

abstract class ProjectsRepo extends Dependency {
  Future<Project> createProject({required String topic, required String size});
  Project? getProject(String id);
  Future<void> deleteProject(String id);
}
