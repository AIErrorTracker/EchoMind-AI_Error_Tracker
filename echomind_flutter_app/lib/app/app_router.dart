import 'package:flutter/material.dart';

import '../features/feature_page.dart';
import '../features/specs/page_specs.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final path = settings.name ?? AppRoutes.home;
    final spec = pageSpecs[path];
    if (spec != null) {
      return MaterialPageRoute<void>(
        builder: (_) => FeaturePage(spec: spec),
        settings: settings,
      );
    }

    return MaterialPageRoute<void>(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('404 - Route Not Found'))),
    );
  }
}
