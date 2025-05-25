import 'package:ai_learning_app/core/data/models/plan.dart';
import 'package:ai_learning_app/features/plans/vm/plan_details_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PlanDetailsView extends StatelessWidget {
  const PlanDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PlanDetailsVm>();
    return CommandWrapper(
      command: vm.getPlanCommand,
      builder: (context, child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Plan Details'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4),
              child: const _MilestoneProgress(),
            ),
          ),
          child: Builder(
            builder: (context) {
              if (vm.getPlanCommand.isRunning) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (vm.getPlanCommand.isError) {
                return Center(child: Text(vm.getPlanCommand.errorMessage));
              }
              return child!;
            },
          ),
        );
      },
      child: SafeArea(
        child: VmWatcher<PlanDetailsVm>(
          builder: (context, vm, child) {
            final plan = vm.plan;
            if (plan == null) {
              return const SizedBox.shrink();
            }
            final milestone = vm.currentMilestone;
            if (milestone == null) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text("Milestones", style: context.textTheme.titleLarge),
                  // const SizedBox(height: 8),
                  _MilestoneWidget(milestone: milestone),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MilestoneWidget extends StatelessWidget {
  const _MilestoneWidget({super.key, required this.milestone});
  final Milestone milestone;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.borderRadius,
        side: BorderSide(color: context.colorScheme.outline),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...[
              _title(context, milestone.title),
              const SizedBox(height: 4),
              Text(milestone.description, style: context.textTheme.bodyMedium),
            ],
            if (milestone.resourceUrl != null) ...[
              const SizedBox(height: 12),
              _title(context, 'Read More'),
              ButtonComponent.text(
                padding: EdgeInsets.all(0),
                text: milestone.resourceUrl!,
                icon: Icons.link_rounded,
                onPressed: () {},
              ),
            ],
            if (milestone.substeps.isNotEmpty) ...[
              const SizedBox(height: 4),
              _title(context, 'Key Notes'),
              //substeps
              for (var substep in milestone.substeps)
                Builder(
                  builder: (context) {
                    final actionHint = substep.actionHint;
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity.compact,
                      leading: Icon(Icons.star_rounded), //todo: use action icon
                      title: Text(substep.title),
                      onTap: substep.detailUrl != null ? () {} : null,
                      trailing:
                          substep.detailUrl != null
                              ? CupertinoListTileChevron()
                              : null,
                      subtitle:
                          actionHint != null ? Text(actionHint.value) : null,
                    );
                  },
                ),
            ],
            if (milestone.quiz != null) ...[
              const SizedBox(height: 12),
              _title(context, 'Quiz'),
              //quiz
              ButtonComponent.primary(
                text: 'Start Quiz',
                icon: Icons.play_arrow_rounded,
                onPressed: () {},
              ).sized(width: double.infinity),
            ],
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context, String title) {
    return Text(title, style: context.textTheme.titleMedium);
  }

  Widget _description(BuildContext context, String description) {
    return Text(description, style: context.textTheme.bodyMedium);
  }
}

class _MilestoneProgress extends StatelessWidget {
  const _MilestoneProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return VmWatcher<PlanDetailsVm>(
      builder: (context, vm, child) {
        return LinearProgressIndicator(
          value: vm.milestoneProgress,
          year2023: false,
        );
      },
    );
  }
}
