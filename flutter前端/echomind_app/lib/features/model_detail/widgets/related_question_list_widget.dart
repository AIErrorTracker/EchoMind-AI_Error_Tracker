import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class RelatedQuestionListWidget extends StatelessWidget {
  const RelatedQuestionListWidget({super.key});

  static const _items = [
    (correct: false, exam: '2025天津模拟 第5题', desc: '2月8日 · 错误 · 待诊断'),
    (correct: false, exam: '2024天津真题 大题1', desc: '2月3日 · 错误 · 已诊断: 识别错'),
    (correct: true,  exam: '2024天津真题 第4题', desc: '2月3日 · 正确'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('相关题目',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Text('${_items.length}题',
                  style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            ],
          ),
          const SizedBox(height: 10),
          _listGroup(context),
        ],
      ),
    );
  }

  Widget _listGroup(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        children: [
          for (var i = 0; i < _items.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, indent: 14, color: AppTheme.divider),
            _buildItem(context, _items[i]),
          ],
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.exam as String,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(item.desc as String,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Text(
              correct ? 'OK' : 'X',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: correct ? AppTheme.accent : const Color(0xFF636366),
              ),
            ),
          ],
        ),
      ),
    );
  }
}