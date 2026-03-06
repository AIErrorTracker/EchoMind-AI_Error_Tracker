import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/recommendations_provider.dart';

class RecommendationListWidget extends ConsumerWidget {
  const RecommendationListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recs = ref.watch(recommendationsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('推荐学习',
              style: AppTheme.heading(size: 20, weight: FontWeight.w800)),
          const SizedBox(height: 12),
          recs.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => _buildStatusCard('推荐数据加载失败，请检查后端接口与鉴权状态'),
            data: (items) => items.isEmpty
                ? _buildStatusCard('暂无推荐数据')
                : _buildApiList(context, items),
          ),
        ],
      ),
    );
  }

  Widget _buildApiList(BuildContext context, List<RecommendationItem> items) {
    final validItems = items.where((item) {
      final id = item.targetId.trim();
      return id.isNotEmpty &&
          (item.targetType == 'knowledge' || item.targetType == 'model');
    }).toList();

    if (validItems.isEmpty) {
      return _buildStatusCard('推荐数据缺少可跳转目标（target_id/target_type）');
    }

    return Column(
      children: [
        for (final item in validItems)
          _RecItem(
            icon: item.targetType == 'knowledge'
                ? Icons.lightbulb_outline_rounded
                : Icons.layers_rounded,
            gradient: item.isUnstable
                ? AppTheme.gradientPink
                : AppTheme.gradientPrimary,
            title: item.targetName,
            tags: [
              if (item.errorCount > 0) '错${item.errorCount}次',
              if (item.isUnstable) '不稳定',
              'L${item.currentLevel}',
            ],
            onTap: () => context.push(
              item.targetType == 'knowledge'
                  ? AppRoutes.knowledgeDetailPath(item.targetId)
                  : AppRoutes.modelDetailPath(item.targetId),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusCard(String message) {
    return ClayCard(
      radius: AppTheme.radiusXl,
      padding: const EdgeInsets.all(14),
      child: Text(
        message,
        style: AppTheme.body(size: 13, weight: FontWeight.w600),
      ),
    );
  }
}

class _RecItem extends StatelessWidget {
  final IconData icon;
  final LinearGradient gradient;
  final String title;
  final List<String> tags;
  final VoidCallback onTap;

  const _RecItem({
    required this.icon,
    required this.gradient,
    required this.title,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClayCard(
        radius: AppTheme.radiusXl,
        padding: const EdgeInsets.all(14),
        onTap: onTap,
        child: Row(
          children: [
            _GradientIconOrb(icon: icon, gradient: gradient, size: 44),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.body(size: 15)
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Wrap(spacing: 6, children: [for (final t in tags) _Tag(t)]),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 22, color: AppTheme.muted),
          ],
        ),
      ),
    );
  }
}

class _GradientIconOrb extends StatelessWidget {
  final IconData icon;
  final LinearGradient gradient;
  final double size;

  const _GradientIconOrb({
    required this.icon,
    required this.gradient,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: gradient.colors.last.withValues(alpha: 0.3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: size * 0.5),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppTheme.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child:
          Text(text, style: AppTheme.label(size: 11, color: AppTheme.accent)),
    );
  }
}
