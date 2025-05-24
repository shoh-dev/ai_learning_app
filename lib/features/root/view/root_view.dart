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
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
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
              duration: const Duration(milliseconds: 200),
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
      child: VmSelector<RootVm, bool>(
        selector: (context, vm) => vm.isGeneratingPlan,
        builder: (context, isGeneratingPlan, child) {
          return Column(
            spacing: 32,
            children: [
              TextFieldComponent(
                hintText: "Enter Topic",
                enabled: !isGeneratingPlan,
                controller: vm.topicController,
              ),
              ButtonComponent.primary(
                text: 'Generate Plan',
                isLoading: isGeneratingPlan,
                onPressed: vm.onGeneratePlan,
              ).sized(width: context.width, height: 56),
            ],
          );
        },
      ),
    );
  }
}
