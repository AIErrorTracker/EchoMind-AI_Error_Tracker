import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TrainingRecordListWidget extends StatelessWidget {
  const TrainingRecordListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('训练记录',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _listGroup(),
        ],
      ),
    );
  }

  static Widget _listGroup() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Step 1 训练',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  Text('2月5日 · 未通过 · 识别失败',
                      style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Text('X',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                    color: Color(0xFF636366))),
          ],
        ),
      ),
    );
  }
}