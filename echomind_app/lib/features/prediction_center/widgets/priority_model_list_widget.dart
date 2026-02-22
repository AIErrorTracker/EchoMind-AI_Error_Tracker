import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class PriorityModelListWidget extends StatelessWidget {
  const PriorityModelListWidget({super.key});

  static const _items = [
    ('受力分析', 'L3', '预计提分 6 分'),
    ('运动学', 'L2', '预计提分 4 分'),
    ('能量守恒', 'L2', '预计提分 3 分'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('优先训练模型', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(_items.length, (i) {
            final (name, level, desc) = _items[i];
            return GestureDetector(
              onTap: () => context.push(AppRoutes.modelDetail),
              child: Container(
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
                          Text(name, style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(desc, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(level, style: const TextStyle(fontSize: 12, color: AppTheme.primary)),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right, size: 18, color: AppTheme.textSecondary),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
