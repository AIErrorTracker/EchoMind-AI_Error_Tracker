import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class Step1IdentificationTrainingWidget extends StatelessWidget {
  final int stepIndex;
  const Step1IdentificationTrainingWidget({super.key, required this.stepIndex});

  static const _total = 6;
  static const _titles = ['识别训练', '决策训练', '列式训练', '陷阱辨析', '完整求解', '变式训练'];
  static const _headlines = [
    '这道题属于什么模型?',
    '识别了板块运动, 接下来怎么分析?',
    '如何列出正确的方程组?',
    '这类题常见的陷阱有哪些?',
    '从头到尾完整求解一遍',
    '换个条件, 你还会做吗?',
  ];
  static const _descs = [
    '观察题目中的关键信息, 判断这道题属于哪种物理模型。',
    '你已经知道这是一道板块运动题。现在需要决定: 对这类题目, 分析时的关键步骤和顺序是什么?',
    '根据受力分析和运动状态, 列出完整的方程组。注意每个方程对应的物理规律。',
    '板块运动题中有几个经典陷阱, 很多同学会在这里丢分。来辨析一下。',
    '综合前面所有步骤, 独立完成一道完整的板块运动题。',
    '改变题目中的某些条件, 看看你能否灵活应对变化。',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STEP ${stepIndex + 1} / $_total · ${_titles[stepIndex]}',
              style: const TextStyle(
                fontSize: 12, color: AppTheme.primary,
                fontWeight: FontWeight.w600, letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _headlines[stepIndex],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              _descs[stepIndex],
              style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
