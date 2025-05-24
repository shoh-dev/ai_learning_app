import 'package:flutter/material.dart';

enum PlanSize { quick, full }

extension PlanSizeX on PlanSize {
  String get name => switch (this) {
    PlanSize.quick => 'Quick',
    PlanSize.full => 'Full Course',
  };

  IconData get icon => switch (this) {
    PlanSize.quick => Icons.bolt_rounded,
    PlanSize.full => Icons.menu_book_rounded,
  };

  String get apiName => switch (this) {
    PlanSize.quick => 'small',
    PlanSize.full => 'large',
  };
}
