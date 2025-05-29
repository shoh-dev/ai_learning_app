import 'package:ai_learning_app/widgets/leading_button.dart';
import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class RootAppbar extends StatelessWidget implements PreferredSizeWidget {
  const RootAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: const Text('Home'),
      // centerTitle: true,
      actions: [
        LeadingButton(
          onPressed: () => context.push('/plans'),
          text: 'View History',
          // icon: Icons.history_rounded,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
