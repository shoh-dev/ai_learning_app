import 'dart:developer';

import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:ai_learning_app/core/data/supabase_initializer.dart';
import 'package:ai_learning_app/core/data/utils.dart';
import 'package:myspace_core/myspace_core.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class PlansServerRepo extends PlansRepo {
  final SupabaseClient _supabase;

  PlansServerRepo(this._supabase);

  @override
  Future<Result<Plan>> createPlan({
    required String topic,
    required PlanSize size,
    required int retryAttempt,
  }) async {
    try {
      //1. should call supabase edge function to create plan using 'plan-generator' method
      //body: topic, size, retryAttempt
      final response = await _supabase.functions.invoke(
        SupabaseConstants.planGeneratorMethod,
        body: {
          'topic': topic,
          'size_hint': size.apiName,
          'attempt': retryAttempt,
        },
      );
      final plan = Plan.fromJson(response.data);
      return Result.ok(plan);
    } catch (e) {
      log('Error creating plan: $e');
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Plan>>> getPlans() async {
    try {
      final response = await _supabase.functions.invoke(
        SupabaseConstants.getPlansMethod,
        method: HttpMethod.get,
      );
      final plans =
          (response.data['plans'] as List)
              .map((e) => Plan.fromJson(e))
              .toList();
      return Result.ok(plans);
    } on TypeError catch (e) {
      log('Error getting plans: $e');
      log('Error getting plans stack trace: ${e.stackTrace}');
      return Result.error(e);
    } catch (e) {
      log('Error getting plans: $e');
      return Result.error(e);
    }
  }
}
