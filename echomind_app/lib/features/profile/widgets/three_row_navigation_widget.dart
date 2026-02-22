import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class ThreeRowNavigationWidget extends StatelessWidget {
  const ThreeRowNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: Column(
          children: [
            _NavRow(icon: 'UL', label: '上传历史', bgColor: AppTheme.textPrimary, textColor: Colors.white, trailing: '32条', onTap: () => context.push(AppRoutes.uploadHistory)),
            const Divider(height: 1, indent: 52, color: AppTheme.divider),
            _NavRow(icon: 'WK', label: '周复盘', bgColor: AppTheme.primary, textColor: Colors.white, onTap: () => context.push(AppRoutes.weeklyReview)),
            const Divider(height: 1, indent: 52, color: AppTheme.divider),
            _NavRow(icon: 'EP', label: '卷面策略', bgColor: const Color(0xFFBFDBFE), textColor: const Color(0xFF1E40AF), onTap: () => context.push(AppRoutes.registerStrategy)),
          ],
        ),
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  final String icon, label;
  final Color bgColor, textColor;
  final String? trailing;
  final VoidCallback? onTap;
  const _NavRow({required this.icon, required this.label, required this.bgColor, required this.textColor, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(icon, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
            if (trailing != null) ...[
              Text(trailing!, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
              const SizedBox(width: 4),
            ],
            const Icon(Icons.chevron_right, size: 18, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
