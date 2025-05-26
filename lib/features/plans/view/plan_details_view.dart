import 'package:ai_learning_app/features/plans/view/widgets/milestone_progress.dart';
import 'package:ai_learning_app/features/plans/view/widgets/plan_milestone.dart';
import 'package:ai_learning_app/features/plans/view/widgets/plan_navibar.dart';
import 'package:ai_learning_app/features/plans/vm/plan_details_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PlanDetailsView extends StatelessWidget {
  const PlanDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return VmWatcher<PlanDetailsVm>(
      builder: (context, vm, child) {
        return CommandWrapper(
          command: vm.getPlanCommand,
          builder: (context, child) {
            if (vm.getPlanCommand.isRunning) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (vm.getPlanCommand.isError) {
              return Center(child: Text(vm.getPlanCommand.errorMessage));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: context.theme.scaffoldBackgroundColor,
                title: Text(vm.plan?.topic ?? ""),
                leading: ButtonComponent.text(
                  text: 'Back',
                  style: context.textTheme.titleMedium,
                  icon: Icons.chevron_left_rounded,
                  onPressed: context.pop,
                ),
                leadingWidth: 100,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: MilestoneProgress(
                    controller: vm.pageController,
                    progress: vm.milestoneProgress + .1,
                  ),
                ),
              ),
              body: child!,
              bottomNavigationBar: ListenableBuilder(
                listenable: vm.pageController,
                builder: (context, _) {
                  final milestone = vm.currentMilestone;
                  if (milestone == null) {
                    return const SizedBox.shrink();
                  }
                  return PlanNavbar(
                    canMoveNext: vm.canGoToNextMilestone,
                    canMovePrevious: vm.canGoToPreviousMilestone,
                    onNext: vm.goToNextMilestone,
                    onPrevious: vm.goToPreviousMilestone,
                  );
                },
              ),
            );
          },
          child: SafeArea(
            child: Builder(
              builder: (context) {
                final plan = vm.plan;
                if (plan == null) {
                  return const SizedBox.shrink();
                }
                return PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: vm.pageController,
                  itemCount: vm.milestones.length,
                  itemBuilder: (context, index) {
                    final milestone = vm.milestones[index];
                    return PlanMilestone(
                      key: Key(milestone.title),
                      milestone: milestone,
                      onLaunchUrl: vm.launchUrl,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
