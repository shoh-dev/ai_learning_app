import 'dart:developer';

import 'package:ai_learning_app/features/plans/views/plan_details_view/plan_details_view.dart';
import 'package:ai_learning_app/features/plans/views/plans_view/plans_view.dart';
import 'package:ai_learning_app/features/plans/vm/plan_details_vm.dart';
import 'package:ai_learning_app/features/plans/vm/plans_vm.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

// final plansLayout = UILayout(branches: [_plansBranch]);

final plansBranch = UIBranch(pages: [_plansPage]);

final _plansPage = UIPage(
  path: '/plans',
  transitionType: TransitionType.cupertino,
  pages: [_planDetailsPage],
  builder:
      (context, state) => ChangeNotifierProvider(
        create: (context) => PlansVm(context.read()),
        builder: (context, child) => const PlansView(),
      ),
);

final _planDetailsPage = UIPage(
  path: '/:id',
  redirect: (context, state) {
    final planId = state.pathParameters['id'];
    if (planId == null) {
      log('Redirecting to /plans, no plan id provided');
      return '/plans';
    }
    return null;
  },
  transitionType: TransitionType.cupertino,
  builder:
      (context, state) => ChangeNotifierProvider(
        create:
            (context) => PlanDetailsVm(
              planId: state.pathParameters['id']!,
              urlLauncherService: context.read(),
              plansRepo: context.read(),
              milestoneRepo: context.read(),
            ),
        builder: (context, child) => const PlanDetailsView(),
      ),
);
