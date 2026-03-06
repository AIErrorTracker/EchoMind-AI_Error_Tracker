import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/models/knowledge_point.dart';
import 'package:echomind_app/providers/knowledge_tree_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

Color _levelColor(int level) => switch (level) {
      0 => const Color(0xFFEF4444),
      1 => const Color(0xFFF59E0B),
      2 => const Color(0xFFEAB308),
      3 => const Color(0xFF0EA5E9),
      4 => const Color(0xFF10B981),
      _ => const Color(0xFF059669),
    };

String _levelLabel(int level) => switch (level) {
      0 => '未掌握',
      1 => '薄弱',
      2 => '一般',
      3 => '良好',
      4 => '熟练',
      _ => '精通',
    };

class KnowledgeTreeWidget extends ConsumerStatefulWidget {
  const KnowledgeTreeWidget({super.key});

  @override
  ConsumerState<KnowledgeTreeWidget> createState() =>
      _KnowledgeTreeWidgetState();
}

class _KnowledgeTreeWidgetState extends ConsumerState<KnowledgeTreeWidget> {
  int _subject = 0;
  final _expandedChapters = <int>{0};
  final _expandedSections = <String>{'0-0'};

  @override
  Widget build(BuildContext context) {
    final tree = ref.watch(knowledgeTreeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              _ClayFilterChip(
                label: '物理',
                active: _subject == 0,
                onTap: () => setState(() => _subject = 0),
              ),
              const SizedBox(width: 10),
              _ClayFilterChip(
                label: '数学',
                active: _subject == 1,
                onTap: () => setState(() => _subject = 1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          tree.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => _statusCard('知识树加载失败，请检查后端接口与鉴权状态'),
            data: (chapters) {
              if (chapters.isEmpty) {
                return _statusCard('暂无知识树数据');
              }
              return _buildApiTree(chapters);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApiTree(List<ChapterNode> chapters) {
    return Column(
      children: [
        for (var ci = 0; ci < chapters.length; ci++) ...[
          if (ci > 0) const SizedBox(height: 14),
          _buildApiChapter(ci, chapters[ci]),
        ],
      ],
    );
  }

  Widget _buildApiChapter(int ci, ChapterNode chapter) {
    final open = _expandedChapters.contains(ci);
    final avgLevel = _calcChapterLevel(chapter);

    return _chapterCard(
      title: chapter.chapter,
      sectionCount: chapter.sections.length,
      level: avgLevel,
      open: open,
      onToggle: () => setState(() {
        if (open) {
          _expandedChapters.remove(ci);
        } else {
          _expandedChapters.add(ci);
        }
      }),
      sections: open
          ? [
              for (var si = 0; si < chapter.sections.length; si++)
                _buildApiSection(ci, si, chapter.sections[si]),
            ]
          : const [],
    );
  }

  Widget _buildApiSection(int ci, int si, SectionNode sec) {
    final key = '$ci-$si';
    final open = _expandedSections.contains(key);
    final avgLevel = _calcSectionLevel(sec);

    return _sectionTile(
      title: sec.section,
      count: '${sec.items.length} 项',
      level: avgLevel,
      open: open,
      onToggle: () => setState(() {
        if (open) {
          _expandedSections.remove(key);
        } else {
          _expandedSections.add(key);
        }
      }),
      items: open
          ? [
              for (final item in sec.items)
                _leafItem(item.id.trim(), item.name, item.conclusionLevel),
            ]
          : const [],
    );
  }

  int _calcChapterLevel(ChapterNode chapter) {
    final allItems = <KnowledgePointItem>[];
    for (final section in chapter.sections) {
      allItems.addAll(section.items);
    }
    if (allItems.isEmpty) return 0;
    final sum = allItems.fold<int>(0, (acc, e) => acc + e.conclusionLevel);
    return (sum / allItems.length).round().clamp(0, 5);
  }

  int _calcSectionLevel(SectionNode sec) {
    if (sec.items.isEmpty) return 0;
    final sum = sec.items.fold<int>(0, (acc, e) => acc + e.conclusionLevel);
    return (sum / sec.items.length).round().clamp(0, 5);
  }

  Widget _chapterCard({
    required String title,
    required int sectionCount,
    required int level,
    required bool open,
    required VoidCallback onToggle,
    required List<Widget> sections,
  }) {
    final color = _levelColor(level);
    return ClayCard(
      radius: AppTheme.radiusCard,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: AppTheme.heading(
                                size: 22, weight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('$sectionCount 个小节',
                            style: AppTheme.label(
                                size: 13, color: AppTheme.muted)),
                      ],
                    ),
                  ),
                  _LevelPill(level),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: open ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.chevron_right_rounded,
                        size: 24, color: AppTheme.muted),
                  ),
                ],
              ),
            ),
          ),
          if (sections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: [
                  for (var i = 0; i < sections.length; i++) ...[
                    if (i > 0) const SizedBox(height: 10),
                    sections[i],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionTile({
    required String title,
    required String count,
    required int level,
    required bool open,
    required VoidCallback onToggle,
    required List<Widget> items,
  }) {
    final color = _levelColor(level);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.canvas,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(title,
                          style: AppTheme.body(
                              size: 18, weight: FontWeight.w600))),
                  Text(count,
                      style: AppTheme.label(size: 14, color: AppTheme.muted)),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: open ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.chevron_right_rounded,
                        size: 20, color: AppTheme.muted),
                  ),
                ],
              ),
            ),
          ),
          if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(children: items),
            ),
        ],
      ),
    );
  }

  Widget _leafItem(String id, String title, int level) {
    final color = _levelColor(level);
    final canNavigate = id.isNotEmpty;

    return GestureDetector(
      onTap: canNavigate
          ? () => context.push(AppRoutes.knowledgeDetailPath(id))
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(title,
                    style: AppTheme.body(size: 16, weight: FontWeight.w500))),
            _LevelPill(level),
          ],
        ),
      ),
    );
  }

  Widget _statusCard(String message) {
    return ClayCard(
      padding: const EdgeInsets.all(14),
      child: Text(
        message,
        style: AppTheme.body(size: 13, weight: FontWeight.w600),
      ),
    );
  }
}

class _LevelPill extends StatelessWidget {
  final int level;
  const _LevelPill(this.level);

  @override
  Widget build(BuildContext context) {
    final color = _levelColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Text(
        _levelLabel(level),
        style: AppTheme.label(size: 13, color: color).copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ClayFilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ClayFilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppTheme.accent : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          boxShadow:
              active ? AppTheme.shadowClayButton : AppTheme.shadowClayStatOrb,
        ),
        child: Text(
          label,
          style: AppTheme.label(
            size: 16,
            color: active ? Colors.white : AppTheme.muted,
          ).copyWith(
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
