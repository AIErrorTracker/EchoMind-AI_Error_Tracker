import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/dashboard_provider.dart';

class CardCategoryListWidget extends ConsumerWidget {
  const CardCategoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dashboardProvider);

    return asyncData.when(
      loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (data) {
        final total = data.totalQuestions.clamp(1, 9999);
        final categories = [
          (color: const Color(0xFFFF3B30), name: '薄弱项', count: data.weakCount, progress: data.weakCount / total),
          (color: const Color(0xFFFF9500), name: '错题数', count: data.errorCount, progress: data.errorCount / total),
          (color: const Color(0xFF34C759), name: '已掌握', count: data.masteryCount, progress: data.masteryCount / total),
          (color: const Color(0xFF007AFF), name: '总题数', count: data.totalQuestions, progress: 1.0),
        ];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('卡片分类', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              for (final c in categories)
                _CategoryItem(color: c.color, name: c.name, count: c.count, progress: c.progress),
            ],
          ),
        );
      },
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
      child: Column(children: [
        Row(children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis)),
          Text('$count', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(value: progress, minHeight: 4, backgroundColor: AppTheme.background, color: color),
        ),
      ]),
    );
  }
}
