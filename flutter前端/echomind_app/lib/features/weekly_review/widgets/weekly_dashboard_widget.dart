import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class WeeklyDashboardWidget extends StatelessWidget {
  const WeeklyDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          children: [
            const Text('本周 (2月3日 - 2月9日)',
                style: TextStyle(
                    fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 12),
            _statsRow(),
          ],
        ),
      ),
    );
  }

  static Widget _statsRow() {
    return Row(
      children: [
        _stat('12', '闭环数', null),
        _stat('2h25m', '学习时长', null),
        _stat('+3', '预测分变化', AppTheme.accent),
      ],
    );
  }

  static Widget _stat(String value, String label, Color? valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700,
                    color: valueColor ?? AppTheme.textPrimary)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}