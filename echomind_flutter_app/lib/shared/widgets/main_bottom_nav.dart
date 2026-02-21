import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../features/specs/page_spec.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({
    super.key,
    required this.activeTab,
    required this.onNavigate,
  });

  final MainTab activeTab;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    final tabs = <(MainTab, String, IconData, String)>[
      (MainTab.home, '主页', Icons.home_rounded, AppRoutes.home),
      (MainTab.global, '全局', Icons.hub_rounded, AppRoutes.globalKnowledge),
      (MainTab.memory, '记忆', Icons.style_rounded, AppRoutes.memory),
      (MainTab.community, '社区', Icons.groups_rounded, AppRoutes.community),
      (MainTab.profile, '我的', Icons.person_rounded, AppRoutes.profile),
    ];

    return NavigationBar(
      selectedIndex: tabs.indexWhere((t) => t.$1 == activeTab),
      onDestinationSelected: (index) => onNavigate(tabs[index].$4),
      destinations: tabs
          .map((t) => NavigationDestination(icon: Icon(t.$3), label: t.$2))
          .toList(growable: false),
    );
  }
}
