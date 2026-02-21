import 'package:flutter/material.dart';

enum SectionType {
  dashboard,
  list,
  tags,
  tree,
  heatmap,
  timeline,
  table,
  chat,
  flashcard,
  placeholder,
}

enum MainTab { home, global, memory, community, profile }

class NavTarget {
  const NavTarget({required this.label, required this.route, this.icon});

  final String label;
  final String route;
  final IconData? icon;
}

class SectionSpec {
  const SectionSpec({
    required this.id,
    required this.title,
    required this.type,
    this.subtitle,
    this.items = const <String>[],
    this.tags = const <String>[],
    this.matrix = const <List<String>>[],
    this.tableHeaders = const <String>[],
    this.tableRows = const <List<String>>[],
    this.primaryRoute,
    this.secondaryRoute,
  });

  final String id;
  final String title;
  final SectionType type;
  final String? subtitle;
  final List<String> items;
  final List<String> tags;
  final List<List<String>> matrix;
  final List<String> tableHeaders;
  final List<List<String>> tableRows;
  final String? primaryRoute;
  final String? secondaryRoute;
}

class PageSpec {
  const PageSpec({
    required this.route,
    required this.title,
    required this.sections,
    this.backRoute,
    this.topSwitches = const <NavTarget>[],
    this.showBottomTabs = false,
    this.activeTab,
    this.stageSteps = const <String>[],
    this.initialStageIndex = 0,
    this.showChatInput = false,
    this.showFab = false,
  });

  final String route;
  final String title;
  final String? backRoute;
  final List<NavTarget> topSwitches;
  final bool showBottomTabs;
  final MainTab? activeTab;
  final List<String> stageSteps;
  final int initialStageIndex;
  final bool showChatInput;
  final bool showFab;
  final List<SectionSpec> sections;
}
