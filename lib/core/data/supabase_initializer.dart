import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

const String _url = String.fromEnvironment('SUPABASE_URL');
const String _anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

abstract class SupabaseConstants {
  static const String planGeneratorMethod = 'plan-generator';
  static const String getPlansMethod = 'get-plans';
  static const String getPlanMethod = 'get-plan';
  static const String plansTable = 'plans';
}

class SupabaseInitializer {
  static Future<SupabaseClient> init() async {
    final supabase = await Supabase.initialize(url: _url, anonKey: _anonKey);
    log('Supabase initialized');
    // await supabase.client.auth.signInAnonymously();
    log('Signed in anonymously as ${supabase.client.auth.currentUser?.id}');
    return supabase.client;
  }
}
