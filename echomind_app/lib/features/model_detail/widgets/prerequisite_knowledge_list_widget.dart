import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/model_detail_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class PrerequisiteKnowledgeListWidget extends ConsumerWidget {
  final String modelId;

  const PrerequisiteKnowledgeListWidget({super.key, required this.modelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(modelDetailProvider(modelId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('前置知识点',
              style: AppTheme.heading(size: 18, weight: FontWeight.w900)),
          const SizedBox(height: 10),
          detail.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _statusCard('前置知识点加载失败，请检查后端接口与鉴权状态'),
            data: (d) {
              final ids = (d.prerequisiteKpIds ?? const <String>[])
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              if (ids.isEmpty) {
                return _statusCard('暂无前置知识点数据');
              }
              final items = List<_PrerequisiteItem>.generate(ids.length, (i) {
                return _PrerequisiteItem(
                  id: ids[i],
                  name: ids[i],
                  desc: _descByIndex(i),
                  color: _colorByIndex(i),
                );
              });

              return Column(
                children: [
                  Column(
                    children: [
                      for (var i = 0; i < items.length; i++) ...[
                        _buildItem(context, items[i]),
                        if (i < items.length - 1) const SizedBox(height: 10),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClayCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradientBlue,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusSm),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '建议先学习“${items.first.name}”，掌握后训练效果更好',
                            style: AppTheme.label(
                              size: 13,
                              color: const Color(0xFF1D4ED8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
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

  Widget _buildItem(BuildContext context, _PrerequisiteItem item) {
    return ClayCard(
      onTap: () => context.push(AppRoutes.knowledgeDetailPath(item.id)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [item.color.withValues(alpha: 0.82), item.color],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: item.color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.menu_book_rounded,
                size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTheme.body(size: 14, weight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(item.desc, style: AppTheme.label(size: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: AppTheme.muted),
        ],
      ),
    );
  }

  static Color _colorByIndex(int index) => switch (index % 4) {
        0 => const Color(0xFFFF9500),
        1 => AppTheme.danger,
        2 => AppTheme.accent,
        _ => AppTheme.success,
      };

  static String _descByIndex(int index) => switch (index % 4) {
        0 => 'L3 · 使用出错',
        1 => 'L2 · 理解不深',
        2 => 'L2 · 需强化训练',
        _ => 'L3 · 仍需巩固',
      };
}

class _PrerequisiteItem {
  final String id;
  final String name;
  final String desc;
  final Color color;

  const _PrerequisiteItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.color,
  });
}
