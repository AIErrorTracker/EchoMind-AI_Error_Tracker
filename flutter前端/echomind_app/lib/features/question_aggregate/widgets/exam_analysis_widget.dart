import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ExamAnalysisWidget extends StatelessWidget {
  const ExamAnalysisWidget({super.key});

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
            // Attitude badge + score tag
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _attitudeBadge(),
                _grayTag('满分 3分'),
              ],
            ),
            const SizedBox(height: 14),
            // 高频考点
            const Text('高频考点',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _blueTag('牛顿第二定律'),
                _blueTag('板块运动'),
                _blueTag('摩擦力'),
              ],
            ),
            const SizedBox(height: 14),
            // 薄弱模型
            const Text('薄弱模型',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _darkTag('板块运动 L1'),
                _outlineTag('牛顿第二定律应用 L3'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _attitudeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.danger,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'MUST · 必须拿满',
        style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget _grayTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
    );
  }

  static Widget _blueTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w500)),
    );
  }

  static Widget _darkTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  static Widget _outlineTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.divider),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
    );
  }
}