import 'package:ai_learning_app/core/data/repositories/project/milestone_repo.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MilestoneServerRepo extends MilestoneRepo {
  final SupabaseClient _supabase;

  const MilestoneServerRepo(this._supabase);

  @override
  Future<Result<void>> onMarkQuizDone({required String milestoneId}) async {
    try {
      await _supabase
          .from("milestones")
          .update({"quiz_done": true})
          .eq('id', milestoneId);
      return Result.ok(null);
    } catch (e) {
      return Result.error(e);
    }
  }
}
