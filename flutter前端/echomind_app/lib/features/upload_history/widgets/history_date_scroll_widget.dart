import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class HistoryDateScrollWidget extends StatelessWidget {
  const HistoryDateScrollWidget({super.key});

  static const _dates = ['1月15日', '1月14日', '1月12日', '1月10日', '1月8日'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _dates.length,
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
            child: Text(_dates[i],
                style: TextStyle(fontSize: 13, color: selected ? AppTheme.primary : AppTheme.textSecondary)),
          );
        },
      ),
    );
  }
}
