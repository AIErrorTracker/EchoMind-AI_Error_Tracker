import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ExamAnalysisWidget extends StatelessWidget {
  const ExamAnalysisWidget({super.key});

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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('诊断分析', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            _Row(label: '错误倾向', value: '计算失误、审题不清'),
            SizedBox(height: 6),
            _Row(label: '关联薄弱点', value: '库仑定律适用条件、电场力方向判断'),
            SizedBox(height: 6),
            _Row(label: '建议', value: '加强辨析训练，注意条件限制'),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
