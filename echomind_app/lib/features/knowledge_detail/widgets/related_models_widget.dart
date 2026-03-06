import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/knowledge_detail_provider.dart';

class RelatedModelsWidget extends ConsumerWidget {
  final String kpId;

  const RelatedModelsWidget({super.key, required this.kpId});

  static const _dotColors = [
    Color(0xFFFF9500),
    Color(0xFFAEAEB2),
    Color(0xFF34C759),
    Color(0xFF007AFF),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(knowledgeDetailProvider(kpId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '关联模型',
                style: AppTheme.heading(size: 20, weight: FontWeight.w900),
              ),
              Text('使用该知识点的模型', style: AppTheme.label(size: 13)),
            ],
          ),
          const SizedBox(height: 10),
          detail.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _statusCard('关联模型加载失败，请检查后端接口与鉴权状态'),
            data: (d) {
              final ids = (d.relatedModelIds ?? const <String>[])
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              if (ids.isEmpty) {
                return _statusCard('暂无关联模型数据');
              }
              return Column(
                children: [
                  for (int i = 0; i < ids.length; i++) ...[
                    if (i > 0) const SizedBox(height: 10),
                    _item(
                      context: context,
                      id: ids[i],
                      name: ids[i],
                      desc: '点击进入模型详情',
                      dotColor: _dotColors[i % _dotColors.length],
                    ),
                  ],
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

  Widget _item({
    required BuildContext context,
    required String id,
    required String name,
    required String desc,
    required Color dotColor,
  }) {
    return ClayCard(
      onTap: () => context.push(AppRoutes.modelDetailPath(id)),
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
                colors: [dotColor.withValues(alpha: 0.8), dotColor],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: dotColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.hub_rounded, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: AppTheme.body(size: 14, weight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(desc, style: AppTheme.label(size: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: AppTheme.muted),
        ],
      ),
    );
  }
}
