import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/models/model_item.dart';
import 'package:echomind_app/providers/model_tree_provider.dart';
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

class ModelTreeWidget extends ConsumerStatefulWidget {
  const ModelTreeWidget({super.key});

  @override
  ConsumerState<ModelTreeWidget> createState() => _ModelTreeWidgetState();
}

class _ModelTreeWidgetState extends ConsumerState<ModelTreeWidget> {
  final _expanded = <int>{0};

  @override
  Widget build(BuildContext context) {
    final asyncTree = ref.watch(modelTreeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: asyncTree.when(
        loading: () => _statusCard('模型树加载中...'),
        error: (_, __) => _statusCard('模型树加载失败，请检查后端接口与鉴权状态'),
        data: (chapters) {
          if (chapters.isEmpty) {
            return _statusCard('暂无模型树数据');
          }
          return _buildApiTree(chapters);
        },
      ),
    );
  }

  Widget _buildApiTree(List<ModelChapterNode> chapters) {
    final categories =
        List<_ApiCategory>.generate(chapters.length, (chapterIdx) {
      final chapter = chapters[chapterIdx];
      final leaves = <_ApiLeaf>[];

      for (final section in chapter.sections) {
        for (final item in section.items) {
          final level = _guessLevel(
            '${chapter.chapter}|${section.section}|${item.id}|${item.name}',
          );
          leaves.add(
            _ApiLeaf(
              id: item.id.trim(),
              title: item.name,
              level: level,
            ),
          );
        }
      }

      final total = leaves.length;
      final mastered = leaves.where((e) => e.level >= 3).length;
      final chapterLevel = total == 0
          ? 0
          : (leaves.fold<int>(0, (sum, e) => sum + e.level) / total)
              .round()
              .clamp(0, 5);

      return _ApiCategory(
        title: chapter.chapter,
        level: chapterLevel,
        count: '$mastered/$total',
        items: leaves,
      );
    });

    return Column(
      children: [
        for (var i = 0; i < categories.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          _buildApiCategory(i, categories[i]),
        ],
      ],
    );
  }

  Widget _buildApiCategory(int index, _ApiCategory category) {
    final open = _expanded.contains(index);
    final color = _levelColor(category.level);

    return ClayCard(
      radius: AppTheme.radiusCard,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              if (open) {
                _expanded.remove(index);
              } else {
                _expanded.add(index);
              }
            }),
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
                        Text(
                          category.title,
                          style: AppTheme.heading(
                              size: 22, weight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '掌握 ${category.count}',
                          style:
                              AppTheme.label(size: 13, color: AppTheme.muted),
                        ),
                      ],
                    ),
                  ),
                  _LevelPill(category.level),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: open ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: AppTheme.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (open)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: [
                  for (final item in category.items) _buildApiItem(item),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildApiItem(_ApiLeaf item) {
    final color = _levelColor(item.level);
    final canNavigate = item.id.isNotEmpty;

    return GestureDetector(
      onTap: canNavigate
          ? () => context.push(AppRoutes.modelDetailPath(item.id))
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.canvas,
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
              child: Text(
                item.title,
                style: AppTheme.body(size: 16, weight: FontWeight.w600),
              ),
            ),
            _LevelPill(item.level),
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

  int _guessLevel(String seed) {
    var hash = 0;
    for (final unit in seed.codeUnits) {
      hash = (hash * 131 + unit) & 0x7fffffff;
    }
    return hash % 6;
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

class _ApiCategory {
  final String title;
  final int level;
  final String count;
  final List<_ApiLeaf> items;

  const _ApiCategory({
    required this.title,
    required this.level,
    required this.count,
    required this.items,
  });
}

class _ApiLeaf {
  final String id;
  final String title;
  final int level;

  const _ApiLeaf({
    required this.id,
    required this.title,
    required this.level,
  });
}
