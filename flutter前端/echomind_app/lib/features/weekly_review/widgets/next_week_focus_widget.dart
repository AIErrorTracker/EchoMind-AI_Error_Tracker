import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class NextWeekFocusWidget extends StatelessWidget {
  const NextWeekFocusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('下周重点',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _card(),
        ],
      ),
    );
  }

  static Widget _card() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line('1.', '板块运动 -- 完成 Step 1-3 训练'),
          const SizedBox(height: 8),
          _line('2.', '摩擦力知识点 -- 补强到 L3 以上'),
          const SizedBox(height: 8),
          _line('3.', '完成 3 张待诊断题目'),
        ],
      ),
    );
  }

  static Widget _line(String num, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(num,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: const TextStyle(fontSize: 14, height: 1.7)),
        ),
      ],
    );
  }
}