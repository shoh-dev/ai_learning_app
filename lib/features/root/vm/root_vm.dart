import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:ai_learning_app/core/data/utils.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class RootVm extends Vm {
  final PlansRepo _plansRepo;
  final void Function(Result? result) onGeneratePlan;

  RootVm(this._plansRepo, this.onGeneratePlan) {
    generatePlanCommand = CommandNoParam(_generatePlan)..addListener(() {
      onGeneratePlan(generatePlanCommand.result);
    });
  }

  final topicController = TextEditingController(
    // text: 'Learn python from scratch',
  );

  PlanSize _planSize = PlanSize.quick;
  PlanSize get planSize => _planSize;
  set planSize(PlanSize value) {
    _planSize = value;
    notifyListeners();
  }

  late final CommandNoParam<void> generatePlanCommand;

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  Future<Result<void>> _generatePlan() async {
    final topic = topicController.text.trim();
    final size = planSize;
    final attempt = 1;
    final plan = await _plansRepo.createPlan(
      topic: topic,
      size: size,
      retryAttempt: attempt,
    );
    await Future.delayed(const Duration(milliseconds: 2000));
    if (plan.isOk) topicController.clear();
    return plan;
  }
}
