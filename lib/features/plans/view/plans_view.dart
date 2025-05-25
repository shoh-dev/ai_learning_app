import 'dart:developer';

import 'package:ai_learning_app/core/data/models/plan.dart';
import 'package:ai_learning_app/features/plans/vm/plans_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PlansVm>();
    return Scaffold(
      appBar: AppBar(title: Text('Plans')),
      body: CommandWrapper(
        command: vm.getPlansCommand,
        builder: (context, child) {
          final command = vm.getPlansCommand;
          if (command.isRunning) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return child!;
        },
        child: VmSelector<PlansVm, List<Plan>>(
          selector: (ctx, vm) => vm.plans,
          builder: (context, plans, child) {
            return RefreshIndicator.adaptive(
              onRefresh: vm.getPlansCommand.execute,
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return ListTile(
                    title: Text(plan.topic),
                    onTap: () {
                      context.push("/plans/${plan.id}");
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
