import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class CommunityDetailPage extends StatelessWidget {
  const CommunityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('需求详情')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('希望增加错题导出PDF功能', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('可以把错题按模型分组导出打印，方便线下复习使用。', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 18, color: AppTheme.primary),
                    SizedBox(width: 4),
                    Text('23票', style: TextStyle(fontSize: 14, color: AppTheme.primary, fontWeight: FontWeight.w600)),
                    SizedBox(width: 16),
                    Text('功能请求 · 3天前', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
