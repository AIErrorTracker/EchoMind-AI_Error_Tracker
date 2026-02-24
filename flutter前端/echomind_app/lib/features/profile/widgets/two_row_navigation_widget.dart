import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TwoRowNavigationWidget extends StatelessWidget {
  const TwoRowNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: const Column(
          children: [
            _NavRow(icon: 'NF', label: '通知设置', bgColor: AppTheme.background, textColor: AppTheme.textSecondary),
            Divider(height: 1, indent: 52, color: AppTheme.divider),
            _NavRow(icon: 'AB', label: '关于', bgColor: AppTheme.background, textColor: AppTheme.textSecondary),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(icon, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textColor)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            if (trailing != null) ...[
              Text(trailing!, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
              const SizedBox(width: 4),
            ],
            const Icon(Icons.chevron_right, size: 20, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
