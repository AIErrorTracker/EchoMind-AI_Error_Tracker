import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class UserInfoCardWidget extends StatelessWidget {
  const UserInfoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: Row(
          children: [
            Container(
              width: 68, height: 68,
              decoration: const BoxDecoration(color: AppTheme.background, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const Text('S', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.textSecondary)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('同学 S', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text('天津 -- 高三 -- 物理+数学', style: TextStyle(fontSize: 15, color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: [
                      _tag('完整订阅', dark: true),
                      _tag('2026.3.15到期'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tag(String text, {bool dark = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: dark ? AppTheme.textPrimary : AppTheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 13, color: dark ? Colors.white : AppTheme.textSecondary)),
    );
  }
}
