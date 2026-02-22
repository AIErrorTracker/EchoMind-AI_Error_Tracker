import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class PrerequisiteKnowledgeListWidget extends StatelessWidget {
  const PrerequisiteKnowledgeListWidget({super.key});

  static const _items = [
    ('牛顿第三定律', '需要补强', true),
    ('力的合成与分解', '已掌握', false),
    ('摩擦力分类', '需要补强', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('前置知识点', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          ...List.generate(_items.length, (i) {
            final (name, status, needFix) = _items[i];
            return GestureDetector(
              onTap: () => context.push(AppRoutes.knowledgeDetail),
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
                      child: Text(name, style: const TextStyle(fontSize: 14)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: needFix
                            ? AppTheme.danger.withValues(alpha: 0.1)
                            : AppTheme.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: needFix ? AppTheme.danger : AppTheme.success,
                        ),
                      ),
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
