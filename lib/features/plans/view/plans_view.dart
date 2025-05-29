import 'package:ai_learning_app/core/data/models/plan.dart';
import 'package:ai_learning_app/features/plans/view/plan_details_view.dart';
import 'package:ai_learning_app/features/plans/vm/plans_vm.dart';
import 'package:ai_learning_app/widgets/leading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:timeago/timeago.dart' as timeago;

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PlansVm>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('History'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 9, top: 4),
            child: CupertinoSearchTextField(controller: vm.searchController),
          ),
        ),
        leading: LeadingButton(
          text: 'Home',
          icon: CupertinoIcons.chevron_back,
          onPressed: context.pop,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: CommandWrapper(
          command: vm.getPlansCommand,
          builder: (context, child) {
            final command = vm.getPlansCommand;
            if (command.isRunning) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return child!;
          },
          child: VmSelector<PlansVm, (List<Plan>, bool)>(
            selector: (ctx, vm) => (vm.getPlans, vm.isFilteredButEmpty),
            builder: (context, plans, child) {
              if (plans.$2) {
                return Center(
                  child: DefaultTextStyle(
                    style: context.textTheme.titleMedium!,
                    child: Text('No plans found'),
                  ),
                );
              }
              return RefreshIndicator.adaptive(
                onRefresh: vm.getPlansCommand.execute,
                child: ListView.builder(
                  itemCount: plans.$1.length,
                  padding: EdgeInsets.only(top: 4, bottom: 40),
                  itemBuilder: (context, index) {
                    final plan = plans.$1[index];
                    return CupertinoListTile.notched(
                      title: Text(plan.topic),
                      subtitle: Text(timeago.format(plan.createdAt)),
                      onTap: () => PlanDetailsView.push(context, plan.id),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

   // child: VmSelector<PlansVm, List<Plan>>(
        //   selector: (ctx, vm) => vm.getPlans,
        //   builder: (context, plans, child) {
        //     return CustomScrollView(
        //       slivers: <Widget>[
        //         CupertinoSliverNavigationBar.search(
        //           largeTitle: Text('My Plans'),
        //           searchField: CupertinoSearchTextField(
        //             autofocus: true,
        //             controller: vm.searchController,
        //           ),
        //           leading: LeadingButton(
        //             text: 'Home',
        //             icon: CupertinoIcons.chevron_back,
        //             onPressed: context.pop,
        //           ),
        //         ),
        //         SliverList.builder(
        //           itemCount: plans.length,
        //           itemBuilder: (context, index) {
        //             final plan = plans[index];
        //             return CupertinoListTile.notched(
        //               title: Text(plan.topic),
        //               subtitle: Text(timeago.format(plan.createdAt)),
        //               onTap: () {
        //                 context.push("/plans/${plan.id}");
        //               },
        //             );
        //           },
        //           // child: RefreshIndicator.adaptive(
        //           //   onRefresh: vm.getPlansCommand.execute,
        //           //   child: ListView.builder(
        //           //     // itemCount: plans.length,
        //           //     itemCount: 100,
        //           //     itemBuilder: (context, index) {
        //           //       return CupertinoListTile(title: Text(index.toString()));
        //           //       // final plan = plans[index];
        //           //       // return CupertinoListTile(
        //           //       //   title: Text(
        //           //       //     plan.topic,
        //           //       //     maxLines: 1,
        //           //       //     overflow: TextOverflow.ellipsis,
        //           //       //     style: context.textTheme.titleSmall,
        //           //       //   ),
        //           //       //   subtitle: Text(timeago.format(plan.createdAt)),
        //           //       //   onTap: () {
        //           //       //     context.push("/plans/${plan.id}");
        //           //       //   },
        //           //       // );
        //           //     },
        //           //   ),
        //           // ),
        //         ),
        //       ],
        //     );
        //   },
        // ),
     