import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:myspace_core/myspace_core.dart';

class PlansVm extends Vm {
  final PlansRepo _plansRepo;

  PlansVm(this._plansRepo) {
    getPlansCommand = CommandNoParam(_getPlans)..execute();
    searchController.addListener(_onSearch);
  }

  final searchController = TextEditingController();

  late final CommandNoParam<void> getPlansCommand;

  final List<Plan> _plans = [];
  List<Plan> _filteredPlans = [];
  bool _isFiltered = false;

  List<Plan> get getPlans => _isFiltered ? _filteredPlans : _plans;
  bool get isFilteredButEmpty => _isFiltered && _filteredPlans.isEmpty;

  Future<Result<void>> _getPlans() async {
    final result = await _plansRepo.getPlans();
    result.fold<void>((p0) {
      _plans.clear();
      _plans.addAll(p0);
      notifyListeners();
    }, (p0) {});

    return result;
  }

  void _onSearch() {
    _filteredPlans = [];
    if (searchController.text.isEmpty) {
      _isFiltered = false;
    } else {
      final filter = _plans.where(
        (plan) => plan.topic.toLowerCase().contains(
          searchController.text.toLowerCase(),
        ),
      );
      _filteredPlans = filter.toList();
      _isFiltered = true;
    }
    notifyListeners();
  }
}
