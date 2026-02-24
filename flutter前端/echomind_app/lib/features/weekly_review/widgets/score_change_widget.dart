import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ScoreChangeWidget extends StatelessWidget {
  const ScoreChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('分数变化',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _scoreComparison(),
          ],
        ),
      ),
    );
  }

  static Widget _scoreComparison() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _scoreBlock('上周', '60', null),
        const SizedBox(width: 16),
        const Text('-->',
            style: TextStyle(fontSize: 24, color: AppTheme.accent)),
        const SizedBox(width: 16),
        _scoreBlock('本周', '63', AppTheme.accent),
      ],
    );
  }

  static Widget _scoreBlock(String label, String value, Color? color) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13, color: AppTheme.textSecondary)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w800,
                color: color ?? AppTheme.textPrimary)),
      ],
    );
  }
}