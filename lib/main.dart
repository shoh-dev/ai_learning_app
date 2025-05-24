import 'package:ai_learning_app/core/data/hive_initializer.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_local_repo.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_server_repo.dart';
import 'package:ai_learning_app/core/data/supabase_initializer.dart';
import 'package:ai_learning_app/core/theming/theming.dart';
import 'package:ai_learning_app/features/plans/view/plans_layout.dart';
import 'package:ai_learning_app/features/root/view/root_layout.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class AppStore extends CoreAppStore {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await HiveInitializer.init();
  final supabase = await SupabaseInitializer.init();

  UIRoot root(AppStore store) => UIRoot(layouts: [rootLayout, plansLayout]);
  final appStore = AppStore();
  final uiTheme = UITheme(
    themeMode: (context) => ThemeMode.light,
    theme: appTheme,
  );
  final dependencies = [
    Provider<PlansRepo>(create: (context) => PlansServerRepo(supabase)),
  ];
  final config = CoreAppConfig(
    root: root,
    appStore: appStore,
    theme: uiTheme,
    dependencies: dependencies,
  );
  runMySpaceApp(config);
}
