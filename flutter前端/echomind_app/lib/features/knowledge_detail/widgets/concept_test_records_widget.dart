import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class ConceptTestRecordsWidget extends StatelessWidget {
  const ConceptTestRecordsWidget({super.key});

  static const _items = [
    (name: '检测 #3', desc: '2月9日 · 未通过 · 条件判断错误', passed: false),
    (name: '检测 #2', desc: '2月5日 · 通过 · 全部正确', passed: true),
    (name: '检测 #1', desc: '1月28日 · 通过 · 2/3正确', passed: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('概念检测记录',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
          for (var i = 0; i < _items.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, indent: 14, color: AppTheme.divider),
            _buildItem(_items[i]),
          ],
        ],
      ),
    );
  }

  static Widget _buildItem(dynamic item) {
    final bool passed = item.passed as bool;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name as String,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(item.desc as String,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ],
            ),
          ),
          Text(
            passed ? 'OK' : 'X',
            style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700,
              color: passed ? AppTheme.accent : const Color(0xFF636366),
            ),
          ),
        ],
      ),
    );
  }
}