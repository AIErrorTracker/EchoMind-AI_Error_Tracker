import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class BoardMyRequestsWidget extends StatelessWidget {
  const BoardMyRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
                elevation: 0,
              ),
              child: const Text('提交新需求'),
            ),
          ),
          const SizedBox(height: 12),
          const _RequestCard(
            title: '希望增加错题导出PDF功能',
            subtitle: '可以把错题按模型分组导出打印',
            votes: 23,
            tags: ['功能请求', '3天前'],
            highlight: true,
          ),
          const _RequestCard(
            title: '数学也需要过程拆分训练',
            subtitle: '解析几何大题特别需要过程拆分',
            votes: 45,
            tags: ['功能请求', '高票', '5天前'],
            highlight: true,
          ),
          const _RequestCard(
            title: '闪卡能不能支持手写公式',
            subtitle: '打字输入公式太麻烦了',
            votes: 8,
            tags: ['体验优化', '1周前'],
            highlight: false,
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String title, subtitle;
  final int votes;
  final List<String> tags;
  final bool highlight;
  const _RequestCard({required this.title, required this.subtitle, required this.votes, required this.tags, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text('$votes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: highlight ? AppTheme.primary : AppTheme.textSecondary)),
                  const Text('票', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: [
              for (final t in tags)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: t == '高票' ? AppTheme.primary.withValues(alpha: 0.1) : AppTheme.background,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(t, style: TextStyle(fontSize: 11, color: t == '高票' ? AppTheme.primary : AppTheme.textSecondary)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
