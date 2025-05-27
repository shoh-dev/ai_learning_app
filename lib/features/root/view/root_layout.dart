import 'package:ai_learning_app/features/plans/view/plans_layout.dart';
import 'package:ai_learning_app/features/root/view/root_view.dart';
import 'package:ai_learning_app/features/root/vm/root_vm.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

final rootLayout = UILayout(branches: [_rootBranch, ...plansLayout.branches]);

final _rootBranch = UIBranch(pages: [_rootPage]);

final _rootPage = UIPage(
  path: '/',
  builder:
      (context, state) => ChangeNotifierProvider(
        create:
            (context) => RootVm(context.read(), (result) {
              if (result != null) {
                result.fold((_) {}, (error) {
                  ErrorDialog.show(error.toString());
                });
              }
            }),
        builder: (context, child) => const RootView(),
      ),
);
