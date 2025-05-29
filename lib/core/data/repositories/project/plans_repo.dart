import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:ai_learning_app/core/data/utils.dart';
import 'package:myspace_core/myspace_core.dart';

abstract class PlansRepo extends Dependency {
  const PlansRepo();
  Future<Result<String>> createPlan({
    required String topic,
    required PlanSize size,
    required int retryAttempt,
  });

  Future<Result<List<Plan>>> getPlans();

  Future<Result<Plan>> getPlan({required String id});

  Future<Result<String>> generateImage({required String milestoneId});
}
