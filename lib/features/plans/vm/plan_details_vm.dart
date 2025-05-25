import 'package:ai_learning_app/core/data/models/plan.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:myspace_core/myspace_core.dart';

class PlanDetailsVm extends Vm {
  final String _planId;
  final PlansRepo _plansRepo;

  PlanDetailsVm(this._plansRepo, this._planId) {
    getPlanCommand = CommandNoParam(_getPlan)..execute();
  }

  Plan? _plan;
  Plan? get plan => _plan;

  List<Milestone> get milestones => _plan?.milestones ?? [];
  Milestone? get currentMilestone => milestones[0];

  //milestone progress START
  double _milestoneProgress = 0;
  double get milestoneProgress => _milestoneProgress;

  void _nextMilestone() {
    if (_milestoneProgress < 1) {
      _milestoneProgress = _milestoneProgress + 0.1;
      notifyListeners();
    }
  }

  void _previousMilestone() {
    if (_milestoneProgress > 0) {
      _milestoneProgress = _milestoneProgress - 0.1;
      notifyListeners();
    }
  }

  //milestone progress END
  late final CommandNoParam<void> getPlanCommand;

  Future<Result<void>> _getPlan() async {
    final result = await _plansRepo.getPlan(id: _planId);
    result.fold((ok) {
      _plan = ok;
      notifyListeners();
    }, (p0) {});
    return result;
  }
}
