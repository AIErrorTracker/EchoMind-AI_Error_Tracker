import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/providers/weekly_review_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class WeeklyProgressWidget extends ConsumerWidget {
  const WeeklyProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(weeklyReviewProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('本周进展',
              style: AppTheme.heading(size: 18, weight: FontWeight.w900)),
          const SizedBox(height: 12),
          asyncData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _statusCard('本周进展加载失败，请检查后端接口与鉴权状态'),
            data: (data) {
              if (data.progressItems.isEmpty) {
                return _statusCard('暂无本周进展数据');
              }
              final entries = List<_ProgressEntry>.generate(
                data.progressItems.length,
                (i) => _entryFromText(data.progressItems[i], i),
              );
              return Column(
                children: [
                  for (var i = 0; i < entries.length; i++) ...[
                    if (i > 0) const SizedBox(height: 10),
                    _buildItem(entries[i]),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(_ProgressEntry entry) {
    return ClayCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: entry.dotColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: entry.dotColor.withValues(alpha: 0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: AppTheme.body(size: 14, weight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(entry.desc, style: AppTheme.label(size: 12)),
              ],
            ),
          ),
          Text(
            entry.status,
            style: AppTheme.label(
              size: 13,
              color: entry.isUp ? AppTheme.accent : AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(String message) {
    return ClayCard(
      padding: const EdgeInsets.all(14),
      child: Text(
        message,
        style: AppTheme.body(size: 13, weight: FontWeight.w600),
      ),
    );
  }

  _ProgressEntry _entryFromText(String text, int index) {
    final normalized = text.trim();
    final parts = normalized.split(RegExp(r'\s*[-—–]{1,2}\s*'));
    final name = parts.isNotEmpty && parts.first.isNotEmpty
        ? parts.first
        : '学习项${index + 1}';
    final desc = normalized;

    final lower = normalized.toLowerCase();
    final isUp = lower.contains('提升') ||
        lower.contains('完成') ||
        lower.contains('通过') ||
        lower.contains('掌握') ||
        lower.contains('up');

    final dotColor = switch (index % 3) {
      0 => AppTheme.success,
      1 => AppTheme.warning,
      _ => AppTheme.danger,
    };

    return _ProgressEntry(
      name: name,
      desc: desc,
      status: isUp ? 'UP' : '--',
      isUp: isUp,
      dotColor: dotColor,
    );
  }
}

class _ProgressEntry {
  final String name;
  final String desc;
  final String status;
  final bool isUp;
  final Color dotColor;

  const _ProgressEntry({
    required this.name,
    required this.desc,
    required this.status,
    required this.isUp,
    required this.dotColor,
  });
}
