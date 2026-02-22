import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ConceptTestRecordsWidget extends StatelessWidget {
  const ConceptTestRecordsWidget({super.key});

  static const _items = [
    ('2025-01-14', '概念辨析', '3/5', '60%'),
    ('2025-01-10', '公式应用', '4/5', '80%'),
    ('2025-01-06', '概念辨析', '2/5', '40%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('概念检测记录', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
