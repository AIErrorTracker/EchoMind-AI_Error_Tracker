import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/model_tree_provider.dart';
import 'package:echomind_app/models/model_item.dart';

class ModelTreeWidget extends ConsumerStatefulWidget {
  const ModelTreeWidget({super.key});

  @override
  ConsumerState<ModelTreeWidget> createState() => _ModelTreeWidgetState();
}

class _ModelTreeWidgetState extends ConsumerState<ModelTreeWidget> {
  final _expanded = <int>{0};

  @override
  Widget build(BuildContext context) {
    final tree = ref.watch(modelTreeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: tree.when(
        loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
        error: (_, __) => _buildMockTree(),
        data: (chapters) => chapters.isEmpty ? _buildMockTree() : _buildApiTree(chapters),
      ),
    );
  }

  Widget _buildApiTree(List<ModelChapterNode> chapters) {
    return Column(children: [
      for (var i = 0; i < chapters.length; i++) _buildApiChapter(i, chapters[i]),
    ]);
  }

  Widget _buildApiChapter(int ci, ModelChapterNode ch) {
    final open = _expanded.contains(ci);
    return _chapterCard(
      title: ch.chapter,
      count: '${ch.sections.expand((s) => s.items).length}项',
      open: open,
      onTap: () => setState(() => open ? _expanded.remove(ci) : _expanded.add(ci)),
      children: open
          ? [for (final sec in ch.sections) ...[
              if (ch.sections.length > 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 8, 14, 4),
                  child: Text(sec.section, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
                ),
              for (final item in sec.items) _leafItem(item.id, item.name),
            ]]
          : [],
    );
  }

  // --- Mock fallback ---
  static const _mockTree = [
    (title: '力学建模', items: ['匀变速直线运动', '抛体运动', '圆周运动']),
    (title: '电磁学建模', items: ['带电粒子在电场中运动', '安培力模型']),
  ];

  Widget _buildMockTree() {
    return Column(children: [
      for (var i = 0; i < _mockTree.length; i++) _buildMockChapter(i),
    ]);
  }

  Widget _buildMockChapter(int ci) {
    final ch = _mockTree[ci];
    final open = _expanded.contains(ci);
    return _chapterCard(
      title: ch.title,
      count: '${ch.items.length}项',
      open: open,
      onTap: () => setState(() => open ? _expanded.remove(ci) : _expanded.add(ci)),
      children: open ? [for (final name in ch.items) _leafItem('mock', name)] : [],
    );
  }

  // --- Shared UI builders ---
  Widget _chapterCard({
    required String title, required String count, required bool open,
    required VoidCallback onTap, required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Column(children: [
        GestureDetector(
          onTap: onTap, behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Icon(open ? Icons.expand_more : Icons.chevron_right, size: 20, color: AppTheme.textSecondary),
              const SizedBox(width: 6),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
              Text(count, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            ]),
          ),
        ),
        ...children,
      ]),
    );
  }

  Widget _leafItem(String id, String title) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.modelDetailPath(id)),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 8, 14, 8),
        child: Row(children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 13))),
          const Icon(Icons.chevron_right, size: 16, color: AppTheme.textSecondary),
        ]),
      ),
    );
  }
}