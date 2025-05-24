import 'package:ai_learning_app/core/data/hive_initializer.dart';
import 'package:ai_learning_app/core/data/repositories/project/projects_local_repo.dart';
import 'package:ai_learning_app/core/theming/theming.dart';
import 'package:ai_learning_app/features/root/view/root_layout.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class AppStore extends CoreAppStore {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveInitializer.init();

  UIRoot root(AppStore store) => UIRoot(layouts: [rootLayout]);
  final appStore = AppStore();
  final uiTheme = UITheme(
    themeMode: (context) => ThemeMode.light,
    theme: appTheme,
  );
  final dependencies = [
    Provider(
      create:
          (context) =>
              ProjectsLocalRepo(Hive.box<String>(HiveBoxes.projectsBox)),
    ),
  ];
  final config = CoreAppConfig(
    root: root,
    appStore: appStore,
    theme: uiTheme,
    dependencies: dependencies,
  );
  runMySpaceApp(config);
}
