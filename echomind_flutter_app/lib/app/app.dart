import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_routes.dart';
import '../shared/theme/app_theme.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class EchoMindApp extends StatelessWidget {
  const EchoMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    const configuredInitialRoute = String.fromEnvironment(
      'INITIAL_ROUTE',
      defaultValue: AppRoutes.home,
    );
    final initial = AppRoutes.all.contains(configuredInitialRoute)
        ? configuredInitialRoute
        : AppRoutes.home;

    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      title: 'EchoMind Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
