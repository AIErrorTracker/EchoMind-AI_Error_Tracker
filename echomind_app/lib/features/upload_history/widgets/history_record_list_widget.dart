import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class HistoryRecordListWidget extends StatelessWidget {
  const HistoryRecordListWidget({super.key});

  static const _items = [
    ('拍照上传', '2025-01-15 14:30', '已处理', '3道题'),
    ('手动录入', '2025-01-15 10:15', '已处理', '1道题'),
    ('拍照上传', '2025-01-14 16:45', '待处理', '5道题'),
    ('拍照上传', '2025-01-12 09:20', '已处理', '2道题'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final (type, time, status, count) = _items[i];
        final done = status == '已处理';
        return GestureDetector(
          onTap: () => context.push(AppRoutes.questionDetail),
          child: Container(
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
                      Text('$time · $count',
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: done
                        ? AppTheme.success.withValues(alpha: 0.1)
                        : AppTheme.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(status,
                      style: TextStyle(fontSize: 12, color: done ? AppTheme.success : AppTheme.danger)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
