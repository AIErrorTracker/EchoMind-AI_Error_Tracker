import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class SingleQuestionDashboardWidget extends StatelessWidget {
  const SingleQuestionDashboardWidget({super.key});

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
        child: const Row(
          children: [
            Expanded(child: _Stat(value: '6', label: '做题次数')),
            Expanded(child: _Stat(value: '33%', label: '正确率')),
            Expanded(child: _Stat(value: '2', label: '预测得分')),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ],
    );
  }
}
