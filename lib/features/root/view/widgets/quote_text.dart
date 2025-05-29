import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class QuoteText extends StatelessWidget {
  const QuoteText({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = !(MediaQuery.viewPaddingOf(context).bottom > 0);
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
  }
}
