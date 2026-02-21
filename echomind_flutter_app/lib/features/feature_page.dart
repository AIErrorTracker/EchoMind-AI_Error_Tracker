import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../shared/widgets/page_shell.dart';
import '../shared/widgets/section_blocks.dart';
import 'specs/page_spec.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key, required this.spec});

  final PageSpec spec;

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  late int _currentStageIndex;

  @override
  void initState() {
    super.initState();
    _currentStageIndex = widget.spec.initialStageIndex;
  }

  @override
  Widget build(BuildContext context) {
    final sectionWidgets = <Widget>[];

    if (widget.spec.stageSteps.isNotEmpty) {
      sectionWidgets.add(
        SectionCard(
          section: SectionSpec(
            id: 'stage-card',
            title: '当前步骤：${widget.spec.stageSteps[_currentStageIndex]}',
            subtitle: '只切换顶部步骤模块，下方对话区保持不变。',
            type: SectionType.dashboard,
            items: <String>[
              'Step ${_currentStageIndex + 1} / ${widget.spec.stageSteps.length}',
              '该步骤已按 Flutter 组件化方式拆分。',
            ],
          ),
          onNavigate: _navigate,
        ),
      );
    }

    for (final section in widget.spec.sections) {
      sectionWidgets.add(SectionCard(section: section, onNavigate: _navigate));
    }

    return AppPageShell(
      title: widget.spec.title,
      backRoute: widget.spec.backRoute,
      topSwitches: widget.spec.topSwitches,
      stageSteps: widget.spec.stageSteps,
      currentStageIndex: _currentStageIndex,
      onSelectStage: widget.spec.stageSteps.isEmpty
          ? null
          : (index) => setState(() => _currentStageIndex = index),
      showBottomTabs: widget.spec.showBottomTabs,
      activeTab: widget.spec.activeTab,
      showChatInput: widget.spec.showChatInput,
      showFab: widget.spec.showFab,
      onNavigate: _navigate,
      children: sectionWidgets,
    );
  }

  void _navigate(String route) {
    if (!AppRoutes.all.contains(route) || route == widget.spec.route) return;

    final rootTabs = <String>{
      AppRoutes.home,
      AppRoutes.globalKnowledge,
      AppRoutes.memory,
      AppRoutes.community,
      AppRoutes.profile,
    };

    if (rootTabs.contains(route)) {
      Navigator.of(context).pushNamedAndRemoveUntil(route, (r) => false);
      return;
    }

    Navigator.of(context).pushNamed(route);
  }
}
