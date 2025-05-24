// import 'dart:convert';
// import 'dart:developer';

// import 'package:ai_learning_app/core/data/models/models.dart';
// import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
// import 'package:ai_learning_app/core/data/utils.dart';
// import 'package:ai_learning_app/core/utils/generate_id.dart';
// import 'package:hive/hive.dart';

// class PlansLocalRepo extends PlansRepo {
//   final Box<String> _plansBox;

//   PlansLocalRepo(this._plansBox);

//   @override
//   Future<Plan> createPlan({
//     required String topic,
//     required PlanSize size,
//     required int retryAttempt,
//   }) async {
//     final plan = Plan(
//       id: generateId('plan'),
//       topic: topic,
//       milestones: [],
//       mode: 'milestones',
//     );
//     await _plansBox.put(plan.id, jsonEncode(plan.toJson()));
//     return plan;
//   }

//   @override
//   Stream<Plan> watchPlans() {
//     return _plansBox.watch().map((event) {
//       log('LOG: ${event.value}');
//       return Plan.fromJsonString(event.value);
//     });
//   }
// }
