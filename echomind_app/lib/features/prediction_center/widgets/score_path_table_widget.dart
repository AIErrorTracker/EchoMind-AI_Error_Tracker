import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class ScorePathTableWidget extends StatelessWidget {
  const ScorePathTableWidget({super.key});

  static const _items = [
    ('第5题', '6分', '受力分析', '高'),
    ('第12题', '4分', '运动学', '中'),
    ('第8题', '3分', '能量守恒', '中'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('提分路径', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 2, child: Text('题号', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                      Expanded(flex: 2, child: Text('可提分', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                      Expanded(flex: 3, child: Text('关联模型', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                      Expanded(flex: 1, child: Text('优先级', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                    ],
                  ),
                ),
                ...List.generate(_items.length, (i) {
                  final (id, score, model, priority) = _items[i];
                  return GestureDetector(
                    onTap: () => context.push(AppRoutes.questionAggregate),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: i < _items.length - 1
                          ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)))
                          : null,
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text(id, style: const TextStyle(fontSize: 13))),
                          Expanded(flex: 2, child: Text(score, style: const TextStyle(fontSize: 13, color: AppTheme.primary))),
                          Expanded(flex: 3, child: Text(model, style: const TextStyle(fontSize: 13))),
                          Expanded(
                            flex: 1,
                            child: Text(priority,
                                style: TextStyle(fontSize: 12, color: priority == '高' ? AppTheme.danger : AppTheme.textSecondary)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
