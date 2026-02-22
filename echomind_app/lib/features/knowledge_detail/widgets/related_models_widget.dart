import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class RelatedModelsWidget extends StatelessWidget {
  const RelatedModelsWidget({super.key});

  static const _items = [
    ('受力分析', 'L3'),
    ('电场叠加', 'L1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('关联模型', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(_items.length, (i) {
            final (name, level) = _items[i];
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
                    Expanded(child: Text(name, style: const TextStyle(fontSize: 14))),
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
