import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/weekly_review_provider.dart';

class WeeklyProgressWidget extends ConsumerWidget {
  const WeeklyProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(weeklyReviewProvider);

    return asyncData.when(
      loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (data) => _buildContent(data.progressItems),
    );
  }

  Widget _buildContent(List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('本周进展', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(items.length, (i) {
            return Container(
              margin: EdgeInsets.only(bottom: i < items.length - 1 ? 8 : 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 18, color: AppTheme.primary),
                  const SizedBox(width: 10),
                  Expanded(child: Text(items[i], style: const TextStyle(fontSize: 14))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
