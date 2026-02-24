import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class RelatedModelsWidget extends StatelessWidget {
  const RelatedModelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with subtitle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('关联模型',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              Text('使用此知识点的模型',
                  style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
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
          _item(context, '库仑力平衡', 'L2 · 列式卡住',
              const Color(0xFFFF9500)),
          const Divider(height: 1, indent: 36,
              color: AppTheme.divider),
          _item(context, '电场中的功能关系', 'L0 · 未接触',
              const Color(0xFFAEAEB2)),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String name, String desc, Color dotColor) {
    return InkWell(
      onTap: () => context.push(AppRoutes.modelDetail),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(desc,
                      style: const TextStyle(
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
}