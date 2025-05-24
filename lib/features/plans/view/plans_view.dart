import 'package:ai_learning_app/features/plans/vm/plans_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plans')),
      body: VmWatcher<PlansVm>(
        builder: (context, vm, child) {
          final command = vm.getPlansCommand;
          if (command.isRunning) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return RefreshIndicator.adaptive(
            onRefresh: vm.getPlansCommand.execute,
            child: ListView.builder(
              itemCount: vm.plans.length,
              itemBuilder: (context, index) {
                final plan = vm.plans[index];
                return ListTile(title: Text(plan.topic));
              },
            ),
          );
        },
      ),
    );
  }
}
