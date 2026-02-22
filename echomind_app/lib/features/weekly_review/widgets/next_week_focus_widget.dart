import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class NextWeekFocusWidget extends StatelessWidget {
  const NextWeekFocusWidget({super.key});

  static const _items = [
    '继续强化「电场叠加」模型训练',
    '完成库仑定律知识点学习',
    '每日闪卡复习不少于 10 张',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('下周重点', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            ...List.generate(_items.length, (i) => Padding(
              padding: EdgeInsets.only(bottom: i < _items.length - 1 ? 8 : 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(fontSize: 14, color: AppTheme.primary)),
                  Expanded(child: Text(_items[i], style: const TextStyle(fontSize: 14))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
