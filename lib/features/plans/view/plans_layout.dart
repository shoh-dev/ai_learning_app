import 'package:ai_learning_app/features/plans/view/plans_view.dart';
import 'package:ai_learning_app/features/plans/vm/plans_vm.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

final plansLayout = UILayout(branches: [_plansBranch]);

final _plansBranch = UIBranch(pages: [_plansPage]);

final _plansPage = UIPage(
  path: '/plans',
  builder:
      (context, state) => ChangeNotifierProvider(
        create: (context) => PlansVm(context.read()),
        builder: (context, child) => const PlansView(),
      ),
);
