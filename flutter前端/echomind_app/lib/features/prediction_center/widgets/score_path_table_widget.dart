import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class ScorePathTableWidget extends StatelessWidget {
  const ScorePathTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('提分路径',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [
                _headerRow(),
                const SizedBox(height: 8),
                _dataRow(context, '第5题', 'MUST', '板块运动训练', '+3', true),
                _divider(),
                _dataRow(context, '第7题', 'MUST', '电场综合训练', '+3', true),
                _divider(),
                _dataRow(context, '大题1', 'MUST', '力学大题训练', '+4', true),
                _divider(),
                _dataRow(context, '大题2', 'TRY', '前两问拿分', '+2', false),
                _divider(),
                _skipRow('大题3', '暂不投入'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _headerRow() {
    return const Row(
      children: [
        Expanded(flex: 2, child: Text('题号',
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
        Expanded(flex: 2, child: Text('现状',
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
        Expanded(flex: 3, child: Text('动作',
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
        Expanded(flex: 2, child: Text('预计提分', textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
      ],
    );
  }

  static Widget _divider() {
    return const Divider(height: 1, color: AppTheme.divider);
  }

  Widget _dataRow(BuildContext context, String id, String attitude,
      String action, String score, bool isMust) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.questionAggregate),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(id,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: _attitudeBadge(attitude)),
            Expanded(flex: 3, child: Text(action,
                style: const TextStyle(fontSize: 12))),
            Expanded(flex: 2, child: Text(score, textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                    color: isMust ? AppTheme.accent : const Color(0xFF8E8E93)))),
          ],
        ),
      ),
    );
  }

  static Widget _skipRow(String id, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(id,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                  color: Color(0xFF636366)))),
          Expanded(flex: 2, child: _attitudeBadge('SKIP')),
          Expanded(flex: 3, child: Text(action,
              style: const TextStyle(fontSize: 12, color: Color(0xFF636366)))),
          const Expanded(flex: 2, child: Text('--', textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13, color: Color(0xFF636366)))),
        ],
      ),
    );
  }

  static Widget _attitudeBadge(String label) {
    Color bg;
    Color fg;
    switch (label) {
      case 'MUST':
        bg = AppTheme.danger;
        fg = Colors.white;
        break;
      case 'TRY':
        bg = const Color(0xFFFF9500);
        fg = Colors.white;
        break;
      default: // SKIP
        bg = const Color(0xFF636366);
        fg = Colors.white;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                color: fg)),
      ),
    );
  }
}