import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class MilestoneProgress extends StatelessWidget {
  const MilestoneProgress({
    super.key,
    required this.controller,
    required this.progress,
  });

  final double progress;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return LinearProgressIndicator(
            value: progress,
            borderRadius: context.borderRadius,
            stopIndicatorRadius: context.borderRadius.bottomLeft.x,
          );
        },
      ),
    );
  }
}
