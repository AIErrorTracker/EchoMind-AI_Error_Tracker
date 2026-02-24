import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class SingleQuestionDashboardWidget extends StatelessWidget {
  const SingleQuestionDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: const Row(
          children: [
            Expanded(child: _Stat(value: '6', label: '累计做题')),
            Expanded(child: _Stat(value: '33%', label: '正确率')),
            Expanded(child: _Stat(value: '2/3', label: '预测得分', valueColor: AppTheme.accent)),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  final Color? valueColor;
  const _Stat({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.w900,
          color: valueColor,
        )),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ],
    );
  }
}
