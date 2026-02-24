import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TargetScoreCardWidget extends StatelessWidget {
  const TargetScoreCardWidget({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('目标分数', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('70', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
                        SizedBox(width: 4),
                        Text('分 (物理)', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                      ],
                    ),
                  ],
                ),
                TextButton(onPressed: () {}, child: const Text('修改')),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '卷面策略: 选择题最多错2个, 大题前两道拿满',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
