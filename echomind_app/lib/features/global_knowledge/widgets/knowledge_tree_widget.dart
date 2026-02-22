import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/knowledge_tree_provider.dart';
import 'package:echomind_app/models/knowledge_point.dart';

Color _levelColor(int level) => switch (level) {
  0 => const Color(0xFFFF3B30),
  1 => const Color(0xFFFF9500),
  2 => const Color(0xFFFFCC00),
  3 => const Color(0xFF007AFF),
  4 => const Color(0xFF34C759),
  _ => const Color(0xFF00875A),
};

class KnowledgeTreeWidget extends ConsumerStatefulWidget {
  const KnowledgeTreeWidget({super.key});

  @override
  ConsumerState<KnowledgeTreeWidget> createState() => _KnowledgeTreeWidgetState();
}

class _KnowledgeTreeWidgetState extends ConsumerState<KnowledgeTreeWidget> {
  final _expandedChapters = <int>{0};
  final _expandedSections = <String>{};

  @override
  Widget build(BuildContext context) {
    final tree = ref.watch(knowledgeTreeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: tree.when(
        loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
        error: (_, __) => _buildMockTree(),
        data: (chapters) => chapters.isEmpty ? _buildMockTree() : _buildApiTree(chapters),
      ),
    );
  }

  Widget _buildApiTree(List<ChapterNode> chapters) {
    return Column(children: [
      for (var ci = 0; ci < chapters.length; ci++) _buildApiChapter(ci, chapters[ci]),
    ]);
  }

  Widget _buildApiChapter(int ci, ChapterNode ch) {
    final open = _expandedChapters.contains(ci);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Column(children: [
        _chapterHeader(ch.chapter, open, () => setState(() => open ? _expandedChapters.remove(ci) : _expandedChapters.add(ci))),
        if (open)
          for (var si = 0; si < ch.sections.length; si++)
            _buildApiSection(ci, si, ch.sections[si]),
      ]),
    );
  }

  Widget _buildApiSection(int ci, int si, SectionNode sec) {
    final key = '$ci-$si';
    final open = _expandedSections.contains(key);
    return Column(children: [
      _sectionHeader(sec.section, '${sec.items.length}项', open,
          () => setState(() => open ? _expandedSections.remove(key) : _expandedSections.add(key))),
      if (open)
        for (final item in sec.items)
          _leafItem(item.id, item.name, item.conclusionLevel),
    ]);
  }

  // --- Mock fallback ---
  static const _mockTree = [
    (title: '力学', sections: [
      (title: '力的概念', count: '3/3', items: [(title: '力的定义', level: 5), (title: '力的三要素', level: 4), (title: '力的单位', level: 5)]),
      (title: '牛顿运动定律', count: '2/3', items: [(title: '牛顿第一定律', level: 4), (title: '牛顿第二定律', level: 3), (title: '牛顿第三定律', level: 5)]),
    ]),
    (title: '静电场', sections: [
      (title: '电荷', count: '3/3', items: [(title: '电荷量', level: 4), (title: '元电荷', level: 4), (title: '起电方式', level: 5)]),
      (title: '库仑定律', count: '0/2', items: [(title: '库仑定律公式', level: 3), (title: '适用条件', level: 2)]),
    ]),
  ];

  Widget _buildMockTree() {
    return Column(children: [
      for (var ci = 0; ci < _mockTree.length; ci++) _buildMockChapter(ci),
    ]);
  }

  Widget _buildMockChapter(int ci) {
    final ch = _mockTree[ci];
    final open = _expandedChapters.contains(ci);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Column(children: [
        _chapterHeader(ch.title, open, () => setState(() => open ? _expandedChapters.remove(ci) : _expandedChapters.add(ci))),
        if (open)
          for (var si = 0; si < ch.sections.length; si++) _buildMockSection(ci, si),
      ]),
    );
  }

  Widget _buildMockSection(int ci, int si) {
    final sec = _mockTree[ci].sections[si];
    final key = '$ci-$si';
    final open = _expandedSections.contains(key);
    return Column(children: [
      _sectionHeader(sec.title, sec.count, open,
          () => setState(() => open ? _expandedSections.remove(key) : _expandedSections.add(key))),
      if (open)
        for (final item in sec.items) _leafItem('mock', item.title, item.level),
    ]);
  }

  // --- Shared UI builders ---
  Widget _chapterHeader(String title, bool open, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Icon(open ? Icons.expand_more : Icons.chevron_right, size: 20, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
        ]),
      ),
    );
  }

  Widget _sectionHeader(String title, String count, bool open, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 10, 14, 10),
        child: Row(children: [
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          Text(count, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          const SizedBox(width: 4),
          Icon(open ? Icons.expand_more : Icons.chevron_right, size: 16, color: AppTheme.textSecondary),
        ]),
      ),
    );
  }

  Widget _leafItem(String id, String title, int level) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.knowledgeDetailPath(id)),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(46, 8, 14, 8),
        child: Row(children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: _levelColor(level), shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 13))),
          _LevelBadge(level),
        ]),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge(this.level);

  @override
  Widget build(BuildContext context) {
    final color = _levelColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
      child: Text('L$level', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
