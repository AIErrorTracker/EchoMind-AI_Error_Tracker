import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        // Question reference card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: const Text('引用题目：第5题 — 等量异种点电荷电场分析',
              style: TextStyle(fontSize: 13, color: AppTheme.primary)),
        ),
        const SizedBox(height: 12),
        // AI message
        _bubble('根据你的作答记录，这道题你选了B，正确答案是ACD。\n\n'
            '主要问题：\n1. 对中垂线上电势分布理解有误\n2. 电场强度变化趋势判断错误\n\n'
            '关联薄弱点：库仑定律适用条件、电场叠加原理', true),
        const SizedBox(height: 8),
        // User message
        _bubble('那中垂线上电势为什么相等？', false),
        const SizedBox(height: 8),
        // AI reply
        _bubble('等量异种电荷的中垂线是等势面（电势为零）。'
            '因为中垂线上任意一点到+Q和-Q的距离相等，'
            '而它们产生的电势大小相等、符号相反，叠加后为零。', true),
        const SizedBox(height: 16),
        // Conclusion card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('诊断结论', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('建议加强"电场叠加原理"模型训练',
                  style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => context.push(AppRoutes.modelTraining),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
                    elevation: 0,
                  ),
                  child: const Text('开始训练', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _bubble(String text, bool isAi) {
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAi ? AppTheme.surface : AppTheme.primary,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Text(text,
            style: TextStyle(fontSize: 14, height: 1.5, color: isAi ? null : Colors.white)),
      ),
    );
  }
}
