import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class WeeklyProgressWidget extends StatelessWidget {
  const WeeklyProgressWidget({super.key});

  static const _items = [
    ('受力分析模型提升至 L3', Icons.trending_up),
    ('完成 3 次专项训练', Icons.fitness_center),
    ('上传 11 道错题', Icons.upload_file),
    ('闪卡复习 36 张', Icons.style),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('本周进展', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(_items.length, (i) {
            final (text, icon) = _items[i];
            return Container(
              margin: EdgeInsets.only(bottom: i < _items.length - 1 ? 8 : 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: AppTheme.primary),
                  const SizedBox(width: 10),
                  Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
