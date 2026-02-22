import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class LearningDialogueWidget extends StatelessWidget {
  const LearningDialogueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        _bubble('库仑定律和万有引力定律都是平方反比定律。我来考考你, 这两个公式有什么关键区别?', true),
        const SizedBox(height: 8),
        _bubble('库仑定律是关于电荷之间的, 万有引力是关于质量之间的', false),
        const SizedBox(height: 8),
        _bubble('对, 这是最基本的区别。现在更关键的一个区别: 库仑定律的适用条件是什么? 它能用于任何带电体之间吗?', true),
        const SizedBox(height: 8),
        _bubble('需要是点电荷, 或者可以看成点电荷的', false),
        const SizedBox(height: 8),
        _bubble('很好! 准确地说, 库仑定律只适用于真空中两个静止点电荷之间的力。那么如果一个带电球壳内部有一个点电荷, 能直接用库仑定律吗?', true),
        const SizedBox(height: 12),
        // Quick options
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _optionChip('能, 球壳可以看成点电荷'),
            _optionChip('不能, 这不满足适用条件'),
            _optionChip('不确定, 再解释一下'),
          ],
        ),
        const SizedBox(height: 12),
        // Compare table card
        _compareCard(),
      ],
    );
  }

  static Widget _compareCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('对比表', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: AppTheme.divider, width: 0.5),
            columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(1.2), 2: FlexColumnWidth(1.2)},
            children: [
              _tableRow(['', '库仑定律', '万有引力'], isHeader: true),
              _tableRow(['作用对象', '带电体', '有质量的物体']),
              _tableRow(['方向', '吸引或排斥', '只有吸引']),
              _tableRow(['适用条件', '真空+点电荷', '任意两物体'], highlight: 1),
            ],
          ),
        ],
      ),
    );
  }

  static TableRow _tableRow(List<String> cells, {bool isHeader = false, int? highlight}) {
    return TableRow(
      decoration: isHeader ? const BoxDecoration(color: AppTheme.background) : null,
      children: [
        for (int i = 0; i < cells.length; i++)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(cells[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isHeader || i == 0 || i == highlight ? FontWeight.w600 : FontWeight.normal,
                  color: i == highlight ? AppTheme.primary : null,
                )),
          ),
      ],
    );
  }

  static Widget _bubble(String text, bool isAi) {
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isAi ? AppTheme.surface : AppTheme.primary,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Text(text,
            style: TextStyle(fontSize: 14, height: 1.5, color: isAi ? null : Colors.white)),
      ),
    );
  }

  static Widget _optionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.divider),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
