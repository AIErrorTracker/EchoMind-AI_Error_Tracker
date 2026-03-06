import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/providers/weekly_review_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class NextWeekFocusWidget extends ConsumerWidget {
  const NextWeekFocusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(weeklyReviewProvider);

    return asyncData.when(
      loading: () => const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => _buildStatus('下周重点加载失败，请检查后端接口与鉴权状态'),
      data: (data) {
        if (data.focusItems.isEmpty) {
          return _buildStatus('暂无下周重点数据');
        }
        return _buildContent(data.focusItems);
      },
    );
  }

  Widget _buildStatus(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClayCard(
        padding: const EdgeInsets.all(14),
        child: Text(
          message,
          style: AppTheme.body(size: 13, weight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildContent(List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('下周重点',
              style: AppTheme.heading(size: 18, weight: FontWeight.w900)),
          const SizedBox(height: 12),
          ClayCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${i + 1}.',
                        style: AppTheme.body(
                          size: 14,
                          weight: FontWeight.w800,
                          color: AppTheme.accent,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          items[i],
                          style:
                              AppTheme.body(size: 14, weight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  if (i < items.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
