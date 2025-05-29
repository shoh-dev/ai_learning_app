import 'package:ai_learning_app/core/data/utils.dart';
import 'package:ai_learning_app/features/root/view/widgets/lottie_circle_avatar.dart';
import 'package:ai_learning_app/features/root/view/widgets/lottie_loading.dart';
import 'package:ai_learning_app/features/root/view/widgets/prompt_widget.dart';
import 'package:ai_learning_app/features/root/view/widgets/quote_text.dart';
import 'package:ai_learning_app/features/root/view/widgets/root_appbar.dart';
import 'package:ai_learning_app/features/root/vm/root_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<RootVm>();
    return Scaffold(
      appBar: const RootAppbar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CommandWrapper(
            command: vm.generatePlanCommand,
            builder: (context, child) {
              final command = vm.generatePlanCommand;
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                firstChild: const LottieCircleAvatar(),
                secondChild: const LottieLoading(),
                crossFadeState:
                    command.isRunning
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
              );
            },
          ),
          //Center text
          Expanded(child: const QuoteText()),

          //Bottom sheet
          CommandWrapper(
            command: vm.generatePlanCommand,
            builder: (context, _) {
              return VmSelector<RootVm, PlanSize>(
                selector: (context, vm) => vm.planSize,
                builder: (context, value, child) {
                  return PromptWidget(
                    planSize: value,
                    topicController: vm.topicController,
                    isLoading: vm.generatePlanCommand.isRunning,
                    onPlanSizeChanged: (v) => vm.planSize = v,
                    onGeneratePlan: vm.generatePlanCommand.execute,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
