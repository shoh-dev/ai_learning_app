import 'package:ai_learning_app/core/data/models/plan.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:ai_learning_app/core/services/url_launcher_service.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class PlanDetailsVm extends Vm {
  final String _planId;
  final PlansRepo _plansRepo;
  final UrlLauncherService _urlLauncherService;

  PlanDetailsVm({
    required String planId,
    required PlansRepo plansRepo,
    required UrlLauncherService urlLauncherService,
  }) : _planId = planId,
       _plansRepo = plansRepo,
       _urlLauncherService = urlLauncherService {
    getPlanCommand = CommandNoParam(_getPlan)..execute();
  }

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  int get currentPage =>
      _pageController.hasClients ? _pageController.page?.round() ?? 0 : 0;

  Plan? _plan;
  Plan? get plan => _plan;

  List<Milestone> get milestones => _plan?.milestones ?? [];
  Milestone? get currentMilestone {
    try {
      return milestones[currentPage];
    } catch (e) {
      return null;
    }
  }

  int get currentMilestoneIndex => currentPage;

  double get milestoneProgress =>
      currentPage == 0 ? 0 : currentPage / milestones.length;

  bool get canGoToNextMilestone => currentPage < milestones.length - 1;
  bool get canGoToPreviousMilestone => currentPage > 0;

  void goToNextMilestone() {
    if (canGoToNextMilestone) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void goToPreviousMilestone() {
    if (canGoToPreviousMilestone) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  Future<Result<void>> launchUrl(String url) {
    return _urlLauncherService.laurnchUrl(url);
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
