import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class PriorityModelListWidget extends StatelessWidget {
  const PriorityModelListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('优先训练模型',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
          _item(context, 1, '板块运动', '当前L1 -- 解决后预计 +5 分',
              AppTheme.accent),
          const Divider(height: 1, indent: 44, color: AppTheme.divider),
          _item(context, 2, '库仑力平衡', '当前L2 -- 解决后预计 +3 分',
              const Color(0xFF8E8E93)),
          const Divider(height: 1, indent: 44, color: AppTheme.divider),
          _item(context, 3, '牛顿第二定律应用',
              '当前L3 -- 不稳定 -- 稳定后预计 +2 分',
              const Color(0xFF636366)),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, int rank, String name, String desc,
      Color rankColor) {
    return InkWell(
      onTap: () => context.push(AppRoutes.modelDetail),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text('$rank',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800,
                      color: rankColor)),
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
}