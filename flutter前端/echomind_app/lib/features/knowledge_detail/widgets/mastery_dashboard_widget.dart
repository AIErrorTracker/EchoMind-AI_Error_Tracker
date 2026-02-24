import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class MasteryDashboardWidget extends StatelessWidget {
  const MasteryDashboardWidget({super.key});

  static const _activeLevel = 3;
  static const _levelColors = [
    Color(0xFFAEAEB2), // L0
    Color(0xFFFF3B30), // L1
    Color(0xFFFF9500), // L2
    Color(0xFFFFCC00), // L3
    Color(0xFF34C759), // L4
    Color(0xFF007AFF), // L5
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _mainCard(),
          const SizedBox(height: 12),
          _learnButton(context),
        ],
      ),
    );
  }

  Widget _mainCard() {
    final color = _levelColors[_activeLevel];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        children: [
          const Text('当前掌握度',
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 12),
          // Circle
          _levelCircle(color),
          const SizedBox(height: 12),
          // Level badges row
          _levelBadges(),
          const SizedBox(height: 8),
          const Text('曾到达: L4 (能正确使用)',
              style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
          const SizedBox(height: 10),
          // Tags
          _tags(),
        ],
      ),
    );
  }

  static Widget _levelCircle(Color color) {
    return Container(
      width: 80, height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 4),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('L$_activeLevel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
          const Text('使用出错',
              style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  static Widget _levelBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i <= 5; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          Container(
            width: 32, height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _levelColors[i],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Opacity(
              opacity: i == _activeLevel ? 1.0 : 0.4,
              child: Text('L$i',
                  style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600,
                    color: Colors.white)),
            ),
          ),
        ],
      ],
    );
  }

  static Widget _tags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF3A3A3C),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text('一级结论',
              style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text('需理解',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ),
      ],
    );
  }

  Widget _learnButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: () => context.push(AppRoutes.knowledgeLearning),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          elevation: 0,
        ),
        child: const Text('开始学习',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}