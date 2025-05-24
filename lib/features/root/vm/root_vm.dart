import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:ai_learning_app/core/data/utils.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class RootVm extends Vm {
  final PlansRepo _plansRepo;

  RootVm(this._plansRepo) {
    generatePlanCommand = CommandNoParam(_generatePlan);
  }

  final topicController = TextEditingController(
    text: 'Learn python from scratch',
  );

  late final CommandNoParam<void> generatePlanCommand;

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  Future<Result<void>> _generatePlan() async {
    final topic = topicController.text;
    final size = PlanSize.full;
    final attempt = 1;
    final plan = await _plansRepo.createPlan(
      topic: topic,
      size: size,
      retryAttempt: attempt,
    );
    return plan;
  }
}
