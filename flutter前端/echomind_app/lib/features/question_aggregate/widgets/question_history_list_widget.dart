import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class QuestionHistoryListWidget extends StatelessWidget {
  const QuestionHistoryListWidget({super.key});

  static const _items = [
    (correct: false, exam: '2025天津模拟(一) 第5题', desc: '2月8日 · 待诊断'),
    (correct: false, exam: '2024天津模拟(三) 第5题', desc: '2月4日 · 已诊断: 建模层出错'),
    (correct: true,  exam: '2024天津真题 第5题',     desc: '2月3日'),
    (correct: false, exam: '2024天津模拟(一) 第5题', desc: '1月28日 · 已诊断: 执行层出错'),
    (correct: false, exam: '2023天津真题 第5题',     desc: '1月25日 · 已诊断: 建模层出错'),
    (correct: true,  exam: '2023天津模拟(二) 第5题', desc: '1月20日'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('做过的题目',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Text('${_items.length}题',
                  style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            ],
          ),
          const SizedBox(height: 10),
          // List
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [
                for (var i = 0; i < _items.length; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, indent: 46, color: AppTheme.divider),
                  _buildItem(context, _items[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, dynamic item) {
    final bool correct = item.correct as bool;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.questionDetail),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // X / OK status icon
            SizedBox(
              width: 28,
              child: Text(
                correct ? 'OK' : 'X',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: correct ? AppTheme.accent : const Color(0xFF636366),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Exam name + date/diagnosis
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.exam as String,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(item.desc as String,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}