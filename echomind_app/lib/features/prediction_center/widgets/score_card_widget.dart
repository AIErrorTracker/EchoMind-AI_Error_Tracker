import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text('预测得分', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('72', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                SizedBox(width: 4),
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('/ 100', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('距目标 85 分还差 13 分', style: TextStyle(fontSize: 12, color: AppTheme.danger)),
            ),
          ],
        ),
      ),
    );
  }
}
