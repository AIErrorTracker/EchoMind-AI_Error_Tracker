import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class CardCategoryListWidget extends StatelessWidget {
  const CardCategoryListWidget({super.key});

  static const _categories = [
    (color: Color(0xFFFF3B30), name: '紧急复习', count: 8, progress: 0.15),
    (color: Color(0xFFFF9500), name: '今日到期', count: 12, progress: 0.35),
    (color: Color(0xFF34C759), name: '巩固中', count: 18, progress: 0.65),
    (color: Color(0xFF007AFF), name: '已掌握', count: 42, progress: 0.90),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('卡片分类', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          for (final c in _categories)
            _CategoryItem(color: c.color, name: c.name, count: c.count, progress: c.progress),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Color color;
  final String name;
  final int count;
  final double progress;
  const _CategoryItem({required this.color, required this.name, required this.count, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Expanded(child: Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis)),
              Text('$count', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(value: progress, minHeight: 4, backgroundColor: AppTheme.background, color: color),
          ),
        ],
      ),
    );
  }
}
