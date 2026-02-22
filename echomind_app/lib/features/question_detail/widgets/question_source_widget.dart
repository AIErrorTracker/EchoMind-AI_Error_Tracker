import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class QuestionSourceWidget extends StatelessWidget {
  const QuestionSourceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('来源信息', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            _Row(label: '来源卷子', value: '2025天津模拟卷'),
            SizedBox(height: 6),
            _Row(label: '题号', value: '第5题'),
            SizedBox(height: 6),
            _Row(label: '分值', value: '6分'),
            SizedBox(height: 6),
            _Row(label: '态度', value: '粗心失误'),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary))),
      Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
    ]);
  }
}
