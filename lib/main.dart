import 'package:ai_learning_app/core/data/repositories/project/milestone_repo.dart';
import 'package:ai_learning_app/core/data/repositories/project/milestone_server.repo.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_repo.dart';
import 'package:ai_learning_app/core/data/repositories/project/plans_server_repo.dart';
import 'package:ai_learning_app/core/data/supabase_initializer.dart';
import 'package:ai_learning_app/core/services/url_launcher_service.dart';
import 'package:ai_learning_app/core/theming/theming.dart';
import 'package:ai_learning_app/features/root/view/root_layout.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class AppStore extends CoreAppStore {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await HiveInitializer.init();
  final supabase = await SupabaseInitializer.init();

  UIRoot root(AppStore store) => UIRoot(layouts: [rootLayout]);
  final appStore = AppStore();
  final uiTheme = UITheme(
    themeMode: (context) => ThemeMode.light,
    theme: appTheme,
  );
  final dependencies = [
    Provider<PlansRepo>(create: (context) => PlansServerRepo(supabase)),
    Provider<MilestoneRepo>(create: (context) => MilestoneServerRepo(supabase)),
    Provider<UrlLauncherService>(create: (context) => UrlLauncherService()),
  ];
  final config = CoreAppConfig(
    root: root,
    appStore: appStore,
    theme: uiTheme,
    dependencies: dependencies,
    // localizationsDelegates: [FluoLocalizations.delegate],
    // builder: (context, child) {
    //   return FluoOnboarding(
    //     apiKey: const String.fromEnvironment('FLUO_API_KEY'),
    //     onUserReady: (fluo) {
    //       print('user ready');
    //     },
    //   );
    // },
    // builder: (context, child) {
    //   print('asas');
    //   return Theme(
    //     data: MaterialTheme(
    //       context.textTheme,
    //     ).theme(MaterialTheme.lightScheme()),
    //     child: child!,
    //   );
    // },
  );
  runMySpaceApp(config);
}
