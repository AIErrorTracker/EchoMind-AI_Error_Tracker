import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/upload_history_provider.dart';

class HistoryDateScrollWidget extends ConsumerWidget {
  const HistoryDateScrollWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(uploadHistoryProvider);

    return historyAsync.when(
      loading: () => const SizedBox(height: 36),
      error: (_, __) => const SizedBox(height: 36),
      data: (groups) {
        final dates = groups.map((g) => g.date).toList();
        if (dates.isEmpty) return const SizedBox(height: 36);
        return SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: dates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final selected = i == 0;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? AppTheme.primary.withValues(alpha: 0.1) : AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(dates[i],
                    style: TextStyle(fontSize: 13, color: selected ? AppTheme.primary : AppTheme.textSecondary)),
              );
            },
          ),
        );
      },
    );
  }
}
