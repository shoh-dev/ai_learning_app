import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:ai_learning_app/core/data/utils.dart';
import 'package:myspace_core/myspace_core.dart';

abstract class PlansRepo extends Dependency {
  Future<Result<Plan>> createPlan({
    required String topic,
    required PlanSize size,
    required int retryAttempt,
  });

  Stream<Plan> watchPlans();
}
