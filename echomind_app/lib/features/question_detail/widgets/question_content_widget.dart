import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class QuestionContentWidget extends StatelessWidget {
  const QuestionContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('题干', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              '如图所示，真空中两个等量异种点电荷+Q和-Q固定在x轴上，关于它们连线的中垂线上各点的电场强度和电势，下列说法正确的是（  ）',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
            SizedBox(height: 8),
            Text('A. 中垂线上各点电势相等\nB. 从O点沿中垂线远离，电场强度先增大后减小\nC. 中垂线上各点电场强度方向均沿x轴正方向\nD. 中垂线上O点的电场强度最大',
              style: TextStyle(fontSize: 14, height: 1.6)),
          ],
        ),
      ),
    );
  }
}
