import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class BoardFeedbackWidget extends StatelessWidget {
  const BoardFeedbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: const Column(
          children: [
            Text('--', style: TextStyle(fontSize: 48, color: AppTheme.divider)),
            SizedBox(height: 12),
            Text('改版建议', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text('提交你对现有功能的改进建议',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
