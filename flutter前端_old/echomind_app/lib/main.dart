import 'package:flutter/material.dart';
import 'package:echomind_app/app/app_router.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

void main() => runApp(const EchoMindApp());

class EchoMindApp extends StatelessWidget {
  const EchoMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EchoMind',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
