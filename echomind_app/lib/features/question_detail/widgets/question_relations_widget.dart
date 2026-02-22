import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class QuestionRelationsWidget extends StatelessWidget {
  const QuestionRelationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('关联信息', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            _link(context, '归属模型', '电场力分析模型', () => context.push(AppRoutes.modelDetail)),
            const SizedBox(height: 6),
            _link(context, '关联知识点', '库仑定律 · 电场强度', () => context.push(AppRoutes.knowledgeDetail)),
          ],
        ),
      ),
    );
  }

  Widget _link(BuildContext context, String label, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13, color: AppTheme.primary))),
        const Icon(Icons.chevron_right, size: 16, color: AppTheme.textSecondary),
      ]),
    );
  }
}
