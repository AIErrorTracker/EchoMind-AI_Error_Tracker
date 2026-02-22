import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ScoreChangeWidget extends StatelessWidget {
  const ScoreChangeWidget({super.key});

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
            const Text('分数变化', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    children: [
                      Text('上周', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      SizedBox(height: 4),
                      Text('65', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: AppTheme.textSecondary),
                const Expanded(
                  child: Column(
                    children: [
                      Text('本周', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      SizedBox(height: 4),
                      Text('72', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('+7', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.success)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
