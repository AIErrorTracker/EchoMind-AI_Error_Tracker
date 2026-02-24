import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TopFrameAndTabsWidget extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabChanged;
  const TopFrameAndTabsWidget({super.key, required this.activeTab, required this.onTabChanged});

  static const _tabs = ['我的需求', '功能助推', '反馈墙'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text('社区', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (var i = 0; i < _tabs.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(child: _TabChip(label: _tabs[i], active: i == activeTab, onTap: () => onTabChanged(i))),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabChip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppTheme.primary : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: active ? Colors.white : AppTheme.textSecondary),
        ),
      ),
    );
  }
}
