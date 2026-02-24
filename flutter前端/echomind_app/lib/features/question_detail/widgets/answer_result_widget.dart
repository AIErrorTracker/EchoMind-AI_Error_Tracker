import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class AnswerResultWidget extends StatelessWidget {
  const AnswerResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Status card
          _statusCard(),
          const SizedBox(height: 12),
          // Diagnosis button
          _diagnosisButton(context),
        ],
      ),
    );
  }

  Widget _statusCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Row(
        children: [
          // Circle X icon
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF3A3A3C),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text('X', style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14,
            )),
          ),
          const SizedBox(width: 12),
          // Text
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('错误', style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600,
                )),
                SizedBox(height: 2),
                Text('2月8日上传', style: TextStyle(
                  fontSize: 13, color: AppTheme.textSecondary,
                )),
              ],
            ),
          ),
          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3C),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('待诊断', style: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500,
            )),
          ),
        ],
      ),
    );
  }

  Widget _diagnosisButton(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () => context.push(AppRoutes.aiDiagnosis),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              elevation: 0,
            ),
            child: const Text('进入诊断',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'AI将通过对话定位你的错误在哪一层',
          style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}