import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TrainingRecordListWidget extends StatelessWidget {
  const TrainingRecordListWidget({super.key});

  static const _items = [
    ('2025-01-15', '专项训练', '8/10', '80%'),
    ('2025-01-12', '错题重练', '5/8', '62%'),
    ('2025-01-08', '专项训练', '6/10', '60%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('训练记录', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(_items.length, (i) {
            final (date, type, score, rate) = _items[i];
            return Container(
              margin: EdgeInsets.only(bottom: i < _items.length - 1 ? 8 : 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type, style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        Text(date, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      ],
                    ),
                  ),
                  Text('$score  $rate', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
