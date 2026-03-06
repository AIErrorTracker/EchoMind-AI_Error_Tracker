import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/prediction_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class PriorityModelListWidget extends ConsumerWidget {
  const PriorityModelListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prediction = ref.watch(predictionProvider);

    return prediction.when(
      loading: () => const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => _buildStatus('优先训练模型加载失败，请检查后端接口与鉴权状态'),
      data: (d) => _buildList(context, d.priorityModels),
    );
  }

  Widget _buildList(BuildContext context, List<PriorityModel> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('优先训练模型',
              style: AppTheme.heading(size: 18, weight: FontWeight.w900)),
          const SizedBox(height: 12),
          if (items.isEmpty)
            _buildStatus('上传更多题目后将生成训练建议')
          else
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              _buildItem(context, i + 1, items[i]),
            ],
        ],
      ),
    );
  }

  Widget _buildStatus(String message) {
    return ClayCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 18, color: AppTheme.muted),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTheme.body(size: 13, weight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int rank, PriorityModel model) {
    final modelId = model.modelId.trim();
    final canNavigate = modelId.isNotEmpty;
    final gradient = _rankGradient(rank);

    return ClayCard(
      onTap: canNavigate
          ? () => context.push(AppRoutes.modelDetailPath(modelId))
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.last.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$rank',
                style: AppTheme.heading(size: 18, weight: FontWeight.w900)
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.modelName,
                    style: AppTheme.body(size: 15, weight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(model.description, style: AppTheme.label(size: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Text('等级 ${model.level}',
                style: AppTheme.label(size: 11, color: AppTheme.accent)),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, size: 18, color: AppTheme.muted),
        ],
      ),
    );
  }

  LinearGradient _rankGradient(int rank) {
    switch (rank) {
      case 1:
        return AppTheme.gradientPrimary;
      case 2:
        return AppTheme.gradientBlue;
      default:
        return AppTheme.gradientGreen;
    }
  }
}
