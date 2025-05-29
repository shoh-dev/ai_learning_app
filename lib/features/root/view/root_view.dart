import 'package:ai_learning_app/core/data/utils.dart';
import 'package:ai_learning_app/features/root/view/widgets/lottie_circle_avatar.dart';
import 'package:ai_learning_app/features/root/view/widgets/lottie_loading.dart';
import 'package:ai_learning_app/features/root/vm/root_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) {
              return DrawerButton(
                onPressed: () => context.push('/plans'),
                style: IconButton.styleFrom(
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  foregroundColor: context.colorScheme.onSurface,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CommandWrapper(
            command: context.read<RootVm>().generatePlanCommand,
            builder: (context, child) {
              final command = context.read<RootVm>().generatePlanCommand;
              if (command.isRunning) {
                return LottieLoading();
              }
              return const LottieCircleAvatar();
            },
          ),
          //Center text
          Expanded(
            child: Builder(
              builder: (context) {
                final isKeyboardVisible =
                    !(MediaQuery.viewPaddingOf(context).bottom > 0);
                if (isKeyboardVisible) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: context.unfocus,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: Builder(
                        builder: (context) {
                          return Text(
                            "Every goal starts with a question. Let's build your path.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.headlineSmall!.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //Bottom sheet
          _BottomSheet(),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<RootVm>();
    return Container(
      // height: context.height * .25,
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(42),
      //     topRight: Radius.circular(42),
      //   ),
      //   color: context.colorScheme.surface,
      // ),
      child: CommandWrapper(
        command: vm.generatePlanCommand,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              VmSelector<RootVm, PlanSize>(
                selector: (context, vm) => vm.planSize,
                builder: (context, planSize, _) {
                  return CupertinoSlidingSegmentedControl<PlanSize>(
                    groupValue: planSize,
                    children: {
                      PlanSize.quick: Text('Quick Guide ⚡️'),
                      PlanSize.full: Text('Full Course 📚'),
                    },
                    onValueChanged: (value) {
                      if (value == null) return;
                      vm.planSize = value;
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final br = BorderRadius.circular(18);
                        return PhysicalModel(
                          elevation: 1,
                          shadowColor: context.colorScheme.onSurface,
                          color: context.theme.scaffoldBackgroundColor,
                          borderRadius: br,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "e.g. Learn Python from scratch",
                              hintStyle: context.textTheme.titleSmall!.copyWith(
                                color: context.theme.disabledColor,
                              ),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: br,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: br,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: br,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: br,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: br,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: br,
                              ),
                            ),
                            enabled: !vm.generatePlanCommand.isRunning,
                            controller: vm.topicController,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: context.textTheme.titleSmall,
                          ),
                        );
                      },
                    ),
                  ),
                  ListenableBuilder(
                    listenable: vm.topicController,
                    builder: (context, _) {
                      return ButtonComponent.iconOutlined(
                        icon: Icons.arrow_upward_rounded,
                        onPressed:
                            vm.topicController.text.trim().isEmpty
                                ? null
                                : () {
                                  context.unfocus();
                                  vm.generatePlanCommand.execute();
                                },
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
