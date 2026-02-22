import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/weekly_review_provider.dart';

class ScoreChangeWidget extends ConsumerWidget {
  const ScoreChangeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(weeklyReviewProvider);

    return asyncData.when(
      loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (data) => _buildContent(data.lastWeekScore, data.thisWeekScore),
    );
  }

  Widget _buildContent(double lastWeek, double thisWeek) {
    final diff = thisWeek - lastWeek;
    final diffStr = diff >= 0 ? '+${diff.toInt()}' : '${diff.toInt()}';
    final isUp = diff >= 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('分数变化', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('上周', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      const SizedBox(height: 4),
                      Text('${lastWeek.toInt()}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: AppTheme.textSecondary),
                Expanded(
                  child: Column(
                    children: [
                      const Text('本周', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      const SizedBox(height: 4),
                      Text('${thisWeek.toInt()}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isUp ? AppTheme.success : AppTheme.danger).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(diffStr, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isUp ? AppTheme.success : AppTheme.danger)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
