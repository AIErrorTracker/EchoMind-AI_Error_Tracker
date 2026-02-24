import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class LearningStatsWidget extends StatelessWidget {
  const LearningStatsWidget({super.key});

  static const _stats = [
    ('28', '累计天数'),
    ('142', '总闭环数'),
    ('48h', '总学习时长'),
    ('+8', '预测提升'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('学习统计', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final s in _stats)
                  Column(
                    children: [
                      Text(s.$1, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(s.$2, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
