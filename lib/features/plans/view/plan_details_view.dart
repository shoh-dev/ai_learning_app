import 'package:ai_learning_app/features/plans/view/widgets/milestone_progress.dart';
import 'package:ai_learning_app/features/plans/view/widgets/plan_milestone.dart';
import 'package:ai_learning_app/features/plans/view/widgets/plan_navibar.dart';
import 'package:ai_learning_app/features/plans/vm/plan_details_vm.dart';
import 'package:ai_learning_app/widgets/leading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PlanDetailsView extends StatelessWidget {
  const PlanDetailsView({super.key});

  static Future<void> push(BuildContext context, String planId) async {
    await context.push("/plans/$planId");
  }

  @override
  Widget build(BuildContext context) {
    return VmWatcher<PlanDetailsVm>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            middle: Text(vm.plan?.topic ?? "Plan"),
            leading: LeadingButton(
              text: 'Back',
              icon: CupertinoIcons.chevron_back,
              onPressed: context.pop,
            ),
            // leadingWidth: 100,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4),
              child: MilestoneProgress(
                controller: vm.pageController,
                progress: vm.milestoneProgress + .1,
              ),
            ),
          ),
          body: CommandWrapper(
            command: vm.getPlanCommand,
            builder: (context, _) {
              if (vm.getPlanCommand.isRunning) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (vm.getPlanCommand.isError) {
                return Center(child: Text(vm.getPlanCommand.errorMessage));
              }
              return child!;
            },
          ),
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
        child: VmWatcher<PlanDetailsVm>(
          builder: (context, vm, _) {
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
  }
}
