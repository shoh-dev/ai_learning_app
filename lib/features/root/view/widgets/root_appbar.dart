import 'package:ai_learning_app/widgets/leading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:myspace_ui/myspace_ui.dart';

class RootAppbar extends CupertinoNavigationBar {
  const RootAppbar({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return AppBar(
  //     backgroundColor: context.theme.scaffoldBackgroundColor,
  //     title: const Text('Home'),
  //     // centerTitle: true,
  //     actions: [
  //       LeadingButton(text: 'History', onPressed: () => context.push('/plans')),
  //       const SizedBox(width: 8),
  //     ],
  //   );
  // }

  // @override
  // Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget? get middle => Text('Home');

  @override
  Widget? get trailing => Builder(
    builder: (context) {
      return LeadingButton(
        text: 'History',
        onPressed: () => context.push('/plans'),
      );
    },
  );
}
