import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/model_detail_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class RelatedQuestionListWidget extends ConsumerWidget {
  final String modelId;
  const RelatedQuestionListWidget({super.key, required this.modelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(modelDetailProvider(modelId));

    return async.when(
      loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (data) {
        final total = data.errorCount + data.correctCount;
        if (total == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('关联题目', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Center(child: Text('暂无关联题目', style: TextStyle(color: AppTheme.textSecondary))),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('关联题目', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              _buildItem(context, '错题数', '${data.errorCount}', true),
              const SizedBox(height: 8),
              _buildItem(context, '正确数', '${data.correctCount}', false),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, String label, String count, bool isWrong) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isWrong ? AppTheme.danger.withValues(alpha: 0.1) : AppTheme.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(count, style: TextStyle(fontSize: 12, color: isWrong ? AppTheme.danger : AppTheme.success)),
          ),
        ],
      ),
    );
  }
}
