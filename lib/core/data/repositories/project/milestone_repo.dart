import 'package:myspace_core/myspace_core.dart';

abstract class MilestoneRepo extends Dependency {
  const MilestoneRepo();

  Future<Result<void>> onMarkQuizDone({required String milestoneId});
}
