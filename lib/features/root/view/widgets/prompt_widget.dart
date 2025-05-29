import 'package:ai_learning_app/core/data/utils.dart';
import 'package:ai_learning_app/features/root/vm/root_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PromptWidget extends StatelessWidget {
  const PromptWidget({
    super.key,
    required this.planSize,
    required this.topicController,
    required this.onPlanSizeChanged,
    required this.isLoading,
    required this.onGeneratePlan,
  });

  final PlanSize planSize;
  final ValueChanged<PlanSize> onPlanSizeChanged;
  final TextEditingController topicController;
  final bool isLoading;
  final VoidCallback onGeneratePlan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoSlidingSegmentedControl<PlanSize>(
            groupValue: planSize,
            children: {
              PlanSize.quick: Text('Quick Guide ⚡️'),
              PlanSize.full: Text('Full Course 📚'),
            },
            onValueChanged: (value) {
              if (value == null) return;
              onPlanSizeChanged(value);
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
                        enabled: !isLoading,
                        controller: topicController,
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
                listenable: topicController,
                builder: (context, _) {
                  return ButtonComponent.iconOutlined(
                    icon: Icons.arrow_upward_rounded,
                    onPressed:
                        topicController.text.trim().isEmpty
                            ? null
                            : () {
                              context.unfocus();
                              onGeneratePlan();
                            },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
