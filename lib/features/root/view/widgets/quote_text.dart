import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:myspace_ui/myspace_ui.dart';

class QuoteText extends StatelessWidget {
  const QuoteText({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) return const SizedBox.shrink();
        return GestureDetector(
          onTap: context.unfocus,
          child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: isKeyboardVisible ? 12 : null,
                  color: context.colorScheme.onSurface,
                ),
                child: Text(
                  "Every goal starts with a question. Let's build your path.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
