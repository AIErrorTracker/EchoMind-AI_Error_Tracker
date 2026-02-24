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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 归属模型
            const Text('归属模型',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: [
                _blueTag(context, '板块运动', AppRoutes.modelDetail),
              ],
            ),
            const SizedBox(height: 14),
            // 关联知识点
            const Text('关联知识点',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _grayTag(context, '牛顿第二定律', AppRoutes.knowledgeDetail),
                _grayTag(context, '摩擦力', AppRoutes.knowledgeDetail),
                _grayTag(context, '动量守恒', AppRoutes.knowledgeDetail),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _blueTag(BuildContext context, String text, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text, style: const TextStyle(
          fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w500,
        )),
      ),
    );
  }

  Widget _grayTag(BuildContext context, String text, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text, style: const TextStyle(
          fontSize: 12, color: AppTheme.textSecondary,
        )),
      ),
    );
  }
}