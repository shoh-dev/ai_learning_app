import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveBoxes {
  static const plansBox = 'plans_box';
}

class HiveInitializer {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Only one generic box for JSON strings
    await Hive.openBox<String>(HiveBoxes.plansBox);

    log('Hive initialized');
  }
}
