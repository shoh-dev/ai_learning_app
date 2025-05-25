import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:myspace_core/myspace_core.dart';

class PlansVm extends Vm {
  final PlansRepo _plansRepo;

  PlansVm(this._plansRepo) {
    getPlansCommand = CommandNoParam(_getPlans)..execute();
  }

  late final CommandNoParam<void> getPlansCommand;

  final List<Plan> plans = [];

  Future<Result<void>> _getPlans() async {
    final result = await _plansRepo.getPlans();
    result.fold((p0) {
      plans.clear();
      plans.addAll(p0);
      notifyListeners();
    }, (p0) {});

    return result;
  }
}
