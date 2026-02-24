import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class WeeklyProgressWidget extends StatelessWidget {
  const WeeklyProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('本周进展',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _listGroup(),
        ],
      ),
    );
  }

  static Widget _listGroup() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        children: [
          _item('匀变速直线运动', 'L3 --> L4 -- 做对过',
              const Color(0xFF34C759), 'UP', true),
          const Divider(height: 1, indent: 28,
              color: AppTheme.divider),
          _item('牛顿第二定律应用', 'L2 --> L3 -- 执行正确一次',
              const Color(0xFFFFCC00), 'UP', true),
          const Divider(height: 1, indent: 28,
              color: AppTheme.divider),
          _item('板块运动', 'L1 --> L1 -- 仍在建模层卡住',
              const Color(0xFFFF3B30), '--', false),
        ],
      ),
    );
  }

  static Widget _item(String name, String desc, Color dotColor,
      String status, bool isUp) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              color: dotColor, shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(desc, style: const TextStyle(
                    fontSize: 12, color: AppTheme.textSecondary)),
              ],
            ),
          ),
          Text(status,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600,
                  color: isUp
                      ? AppTheme.accent
                      : const Color(0xFF636366))),
        ],
      ),
    );
  }
}