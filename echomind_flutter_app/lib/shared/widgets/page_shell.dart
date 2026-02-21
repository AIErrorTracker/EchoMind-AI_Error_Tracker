import 'package:flutter/material.dart';

import '../../features/specs/page_spec.dart';
import 'main_bottom_nav.dart';

class AppPageShell extends StatelessWidget {
  const AppPageShell({
    super.key,
    required this.title,
    required this.children,
    required this.onNavigate,
    this.backRoute,
    this.topSwitches = const <NavTarget>[],
    this.stageSteps = const <String>[],
    this.currentStageIndex = 0,
    this.onSelectStage,
    this.showBottomTabs = false,
    this.activeTab,
    this.showChatInput = false,
    this.showFab = false,
  });

  final String title;
  final String? backRoute;
  final List<Widget> children;
  final void Function(String route) onNavigate;
  final List<NavTarget> topSwitches;
  final List<String> stageSteps;
  final int currentStageIndex;
  final void Function(int index)? onSelectStage;
  final bool showBottomTabs;
  final MainTab? activeTab;
  final bool showChatInput;
  final bool showFab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _TopBar(title: title, backRoute: backRoute, onNavigate: onNavigate),
            if (topSwitches.isNotEmpty)
              _TopSwitches(
                items: topSwitches,
                currentRouteName: ModalRoute.of(context)?.settings.name,
                onNavigate: onNavigate,
              ),
            if (stageSteps.isNotEmpty)
              _StageNav(
                steps: stageSteps,
                currentIndex: currentStageIndex,
                onSelectStage: onSelectStage,
              ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  14,
                  12,
                  14,
                  showChatInput ? 90 : 16,
                ),
                itemBuilder: (context, index) => children[index],
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: children.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomTabs && activeTab != null
          ? MainBottomNav(activeTab: activeTab!, onNavigate: onNavigate)
          : null,
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: () => _showUploadSheet(context),
              child: const Icon(Icons.add_rounded),
            )
          : null,
      bottomSheet: showChatInput
          ? Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: '输入你的思路...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Icon(Icons.send_rounded, size: 18),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('拍照上传'),
              onTap: () {
                Navigator.pop(ctx);
                onNavigate('/upload-menu');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('相册导入'),
              onTap: () {
                Navigator.pop(ctx);
                onNavigate('/upload-menu');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description_rounded),
              title: const Text('文本录入'),
              onTap: () {
                Navigator.pop(ctx);
                onNavigate('/upload-menu');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.backRoute,
    required this.onNavigate,
  });

  final String title;
  final String? backRoute;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
      child: Row(
        children: <Widget>[
          if (backRoute != null)
            TextButton.icon(
              onPressed: () => onNavigate(backRoute!),
              icon: const Icon(Icons.chevron_left_rounded),
              label: const Text('返回'),
            )
          else
            const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          const SizedBox(width: 68),
        ],
      ),
    );
  }
}

class _TopSwitches extends StatelessWidget {
  const _TopSwitches({
    required this.items,
    required this.currentRouteName,
    required this.onNavigate,
  });

  final List<NavTarget> items;
  final String? currentRouteName;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemBuilder: (context, i) {
          final item = items[i];
          final selected = item.route == currentRouteName;
          return ChoiceChip(
            label: Text(item.label),
            selected: selected,
            onSelected: (_) => onNavigate(item.route),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: items.length,
      ),
    );
  }
}

class _StageNav extends StatelessWidget {
  const _StageNav({
    required this.steps,
    required this.currentIndex,
    required this.onSelectStage,
  });

  final List<String> steps;
  final int currentIndex;
  final void Function(int index)? onSelectStage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selected = index == currentIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onSelectStage == null ? null : () => onSelectStage!(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: selected
                    ? const Color(0xFF1677FF)
                    : const Color(0xFFF3F4F6),
              ),
              child: Center(
                child: Text(
                  steps[index],
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF374151),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: steps.length,
      ),
    );
  }
}
