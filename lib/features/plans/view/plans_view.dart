import 'package:ai_learning_app/core/data/models/plan.dart';
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
      child: CommandWrapper(
        command: vm.getPlansCommand,
        builder: (context, child) {
          final command = vm.getPlansCommand;
          if (command.isRunning) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return child!;
        },
        child: VmSelector<PlansVm, List<Plan>>(
          selector: (ctx, vm) => vm.getPlans,
          builder: (context, plans, child) {
            return CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar.search(
                  largeTitle: Text('My Plans'),
                  searchField: CupertinoSearchTextField(
                    autofocus: true,
                    controller: vm.searchController,
                  ),
                  leading: LeadingButton(
                    text: 'Home',
                    icon: CupertinoIcons.chevron_back,
                    onPressed: context.pop,
                  ),
                ),
                SliverList.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final plan = plans[index];
                    return CupertinoListTile(
                      title: Text(plan.topic),
                      trailing: CupertinoListTileChevron(),
                      subtitle: Text(timeago.format(plan.createdAt)),
                      onTap: () {
                        context.push("/plans/${plan.id}");
                      },
                    );
                  },
                  // child: RefreshIndicator.adaptive(
                  //   onRefresh: vm.getPlansCommand.execute,
                  //   child: ListView.builder(
                  //     // itemCount: plans.length,
                  //     itemCount: 100,
                  //     itemBuilder: (context, index) {
                  //       return CupertinoListTile(title: Text(index.toString()));
                  //       // final plan = plans[index];
                  //       // return CupertinoListTile(
                  //       //   title: Text(
                  //       //     plan.topic,
                  //       //     maxLines: 1,
                  //       //     overflow: TextOverflow.ellipsis,
                  //       //     style: context.textTheme.titleSmall,
                  //       //   ),
                  //       //   subtitle: Text(timeago.format(plan.createdAt)),
                  //       //   onTap: () {
                  //       //     context.push("/plans/${plan.id}");
                  //       //   },
                  //       // );
                  //     },
                  //   ),
                  // ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
