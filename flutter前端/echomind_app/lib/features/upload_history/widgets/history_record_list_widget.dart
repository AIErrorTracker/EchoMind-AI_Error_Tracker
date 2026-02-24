import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class HistoryRecordListWidget extends StatelessWidget {
  const HistoryRecordListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: [
        _dateHeader('今天'),
        _group(context, [
          _Record('HW', const Color(0xFF1C1C1E), '作业 -- 力学练习',
              '3道错题 -- 1道已诊断, 2道待诊断', '14:30', '2待诊断', true),
        ]),
        _dateHeader('2月8日'),
        _group(context, [
          _Record('EX', AppTheme.accent, '2025天津模拟卷(一)',
              '6道错题 -- 3道待诊断', '10:15', '3待诊断', true),
        ]),
        _dateHeader('2月5日'),
        _group(context, [
          _Record('HW', const Color(0xFF1C1C1E), '作业 -- 电场练习',
              '2道错题 -- 全部已诊断', '16:42', '已完成', false),
        ]),
        _dateHeader('2月3日'),
        _group(context, [
          _Record('EX', AppTheme.accent, '2024天津高考真题',
              '8道错题 -- 全部已诊断', '09:30', '已完成', false),
          _Record('QK', const Color(0xFF636366), '极简上传 -- 5道题',
              '1道错题 -- 已诊断', '20:10', '已完成', false),
        ]),
      ],
    );
  }

  static Widget _dateHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(label,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary)),
    );
  }

  Widget _group(BuildContext context, List<_Record> records) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          children: [
            for (var i = 0; i < records.length; i++) ...[
              if (i > 0)
                const Divider(height: 1, indent: 50, color: AppTheme.divider),
              _buildItem(context, records[i]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, _Record r) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.questionDetail),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: r.iconBg,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(r.iconLabel,
                  style: const TextStyle(fontSize: 10,
                      fontWeight: FontWeight.w700, color: Colors.white)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.title, style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(r.desc, style: const TextStyle(
                      fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(r.time, style: const TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary)),
                const SizedBox(height: 2),
                _statusTag(r.status, r.isPending),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statusTag(String label, bool isPending) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isPending ? const Color(0xFF3A3A3C) : const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 9,
              color: isPending ? Colors.white : AppTheme.textSecondary)),
    );
  }
}

class _Record {
  final String iconLabel;
  final Color iconBg;
  final String title;
  final String desc;
  final String time;
  final String status;
  final bool isPending;

  const _Record(this.iconLabel, this.iconBg, this.title,
      this.desc, this.time, this.status, this.isPending);
}