import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

AppTheme appTheme(BuildContext context) {
  return MySpaceTheme(
    borderRadius: 12,
    // colorSchemeLight: ColorScheme.light().copyWith(
    // primary: const Color(0xFF008C8E),
    // secondary: const Color(0xFF004E50),
    // surface: const Color(0xFFFFFFFF),
    // ),
    // colorSchemeLight: ColorScheme.fromSeed(seedColor: const Color(0xFF004E50)),
    // colorSchemeLight: ColorScheme.light().copyWith(
    //   outline: Colors.grey.shade300,
    // ),
    colorSchemeLight: ColorScheme.fromSeed(
      seedColor: Colors.black, //teal
      surfaceContainerLow: Colors.white,
    ),
    scaffoldBackgroundColorLight: const Color(0xFFF5F7F8),
  );
}
