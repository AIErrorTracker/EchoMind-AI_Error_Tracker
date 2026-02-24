import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class QuestionSourceWidget extends StatelessWidget {
  const QuestionSourceWidget({super.key});

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
          children: [
            _row('来源卷子', '2025天津模拟(一)'),
            const SizedBox(height: 8),
            _row('题号', '选择题 第5题'),
            const SizedBox(height: 8),
            _row('满分', '3 分'),
            const SizedBox(height: 8),
            _attitudeRow(),
          ],
        ),
      ),
    );
  }

  static Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(
          fontSize: 13, color: AppTheme.textSecondary,
        )),
        Text(value, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  static Widget _attitudeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('态度', style: TextStyle(
          fontSize: 13, color: AppTheme.textSecondary,
        )),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppTheme.danger,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text('MUST', style: TextStyle(
            fontSize: 11, color: Colors.white,
            fontWeight: FontWeight.w700,
          )),
        ),
      ],
    );
  }
}