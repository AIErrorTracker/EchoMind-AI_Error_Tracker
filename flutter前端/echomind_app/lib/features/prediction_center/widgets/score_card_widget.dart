import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          children: [
            const Text('预测分数',
                style: TextStyle(
                    fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            _scoreRow(),
            const SizedBox(height: 10),
            _targetRow(),
            const SizedBox(height: 8),
            const Text('差距: 7分 -- 预计 2-3 周可达成',
                style: TextStyle(
                    fontSize: 12, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }

  static Widget _scoreRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('63',
            style: TextStyle(
                fontSize: 48, fontWeight: FontWeight.w900,
                color: AppTheme.textPrimary)),
        SizedBox(width: 4),
        Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Text('/ 100',
              style: TextStyle(
                  fontSize: 14, color: AppTheme.textSecondary)),
        ),
      ],
    );
  }

  static Widget _targetRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('目标',
            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
        SizedBox(width: 8),
        Text('70',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700,
                color: AppTheme.accent)),
        SizedBox(width: 4),
        Text('分',
            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
      ],
    );
  }
}