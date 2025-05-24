import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

const String _url = String.fromEnvironment('SUPABASE_URL');
const String _anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

abstract class SupabaseConstants {
  static const String planGeneratorMethod = 'plan-generator';
}

class SupabaseInitializer {
  static Future<SupabaseClient> init() async {
    final supabase = await Supabase.initialize(url: _url, anonKey: _anonKey);
    log('Supabase initialized');
    return supabase.client;
  }
}
