import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class HistoryFilterWidget extends StatelessWidget {
  const HistoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _chip('全部', true),
          const SizedBox(width: 8),
          _chip('已处理', false),
          const SizedBox(width: 8),
          _chip('待处理', false),
        ],
      ),
    );
  }

  static Widget _chip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? AppTheme.primary : AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 13, color: selected ? Colors.white : AppTheme.textSecondary)),
    );
  }
}
