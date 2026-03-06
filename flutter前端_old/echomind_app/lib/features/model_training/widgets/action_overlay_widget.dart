import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ActionOverlayWidget extends StatelessWidget {
  const ActionOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.divider, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.centerLeft,
              child: const Text('输入你的答案...', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
            child: const Icon(Icons.send, size: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
