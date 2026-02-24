import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class PrerequisiteKnowledgeListWidget extends StatelessWidget {
  const PrerequisiteKnowledgeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('前置知识点',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          // List group
          _listGroup(context),
          const SizedBox(height: 10),
          // Suggestion tip
          _suggestionTip(),
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
          _item(context, '牛顿第二定律', 'L3 · 使用出错',
              const Color(0xFFFF9500)),
          const Divider(height: 1, indent: 36,
              color: AppTheme.divider),
          _item(context, '摩擦力分析', 'L2 · 理解不深',
              AppTheme.danger),
        ],
      ),
    );
  }

  Widget _item(BuildContext ctx, String name, String desc, Color dotColor) {
    return GestureDetector(
      onTap: () => ctx.push(AppRoutes.knowledgeDetail),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 10, height: 10,
              decoration: BoxDecoration(
                color: dotColor, shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(desc, style: const TextStyle(
                    fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                size: 18, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }

  static Widget _suggestionTip() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: const Text(
        '建议先学习 "摩擦力分析" (当前L2), 掌握后训练效果更好',
        style: TextStyle(fontSize: 13, color: Color(0xFF1D4ED8)),
      ),
    );
  }
}