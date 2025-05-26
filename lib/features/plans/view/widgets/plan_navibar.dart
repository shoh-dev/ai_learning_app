import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PlanNavbar extends StatelessWidget {
  const PlanNavbar({
    super.key,
    required this.canMoveNext,
    required this.canMovePrevious,
    required this.onNext,
    required this.onPrevious,
  });

  final bool canMovePrevious;
  final bool canMoveNext;
  final void Function() onNext;
  final void Function() onPrevious;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.theme.scaffoldBackgroundColor,
      elevation: 0,
      height: canMovePrevious && canMoveNext ? 120 : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (canMovePrevious)
            ButtonComponent.outlined(
              text: 'Back',
              icon: Icons.arrow_back,
              onPressed: onPrevious,
            ),
          if (canMoveNext)
            ButtonComponent.primary(
              text: 'Next',
              icon: Icons.arrow_forward,
              onPressed: onNext,
            ),
        ],
      ),
    );
  }
}
