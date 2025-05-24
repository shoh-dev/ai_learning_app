import 'package:ai_learning_app/features/root/vm/root_vm.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(
        title: Text('AI Learning App'),
        // backgroundColor: context.colorScheme.primary,
        // foregroundColor: context.colorScheme.onPrimary,
      ),
      bottomSheet: _BottomSheet(),
      extendBody: true,
      body: GestureDetector(
        onTap: context.unfocus,
        child: Builder(
          builder: (context) {
            final bottom = MediaQuery.paddingOf(context).bottom;
            final isKeyboardVisible = bottom > 0;
            return AnimatedContainer(
              duration: Durations.short4,
              padding: EdgeInsets.symmetric(horizontal: 48),
              color: Colors.transparent,
              height:
                  isKeyboardVisible ? context.height * .6 : context.height * .2,
              alignment: Alignment.center,
              child: Text(
                'How can I help you this afternoon?',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium!.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            );
          },
        ),
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
      height: context.height * .25,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(42),
          topRight: Radius.circular(42),
        ),
        color: context.colorScheme.surface,
      ),
      child: CommandWrapper(
        command: vm.generatePlanCommand,
        builder: (context, _) {
          return Column(
            spacing: 32,
            children: [
              TextFieldComponent(
                hintText: "Enter Topic",
                enabled: !vm.generatePlanCommand.isRunning,
                controller: vm.topicController,
              ),
              if (vm.generatePlanCommand.isError)
                _ErrorWidet(error: vm.generatePlanCommand.errorMessage),
              ButtonComponent.primary(
                text: 'Generate Plan',
                isLoading: vm.generatePlanCommand.isRunning,
                onPressed: vm.generatePlanCommand.execute,
              ).sized(width: context.width, height: 56),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorWidet extends StatelessWidget {
  const _ErrorWidet({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: context.borderRadius,
      ),
      child: Text(error),
    );
  }
}
