import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class RootVm extends Vm {
  final topicController = TextEditingController();
  bool _isGeneratingPlan = false;
  bool get isGeneratingPlan => _isGeneratingPlan;

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  void onGeneratePlan() {
    _isGeneratingPlan = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      _isGeneratingPlan = false;
      notifyListeners();
    });
  }
}
