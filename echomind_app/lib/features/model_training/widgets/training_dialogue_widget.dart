import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TrainingDialogueWidget extends StatelessWidget {
  const TrainingDialogueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        _bubble('上一步你成功识别了板块运动模型。现在, 面对板块运动题, 你的第一步分析是什么?', true),
        const SizedBox(height: 8),
        _bubble('先分析两个物体各自受力', false),
        const SizedBox(height: 8),
        _bubble('对! 分别对物块和木板进行受力分析。那么物块受几个力? 分别是什么?', true),
        const SizedBox(height: 8),
        _bubble('物块受重力、支持力和摩擦力, 三个力', false),
        const SizedBox(height: 8),
        _bubble('正确。接下来关键的一步: 你怎么判断物块和木板之间的相对运动状态? 以及什么时候两者达到共速?', true),
        const SizedBox(height: 12),
        // Quick options
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _optionChip('比较两个物体的加速度'),
            _optionChip('用相对速度判断'),
            _optionChip('不确定'),
          ],
        ),
        const SizedBox(height: 12),
        // Summary card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text('Step 1 识别训练',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('已通过', style: TextStyle(fontSize: 9, color: AppTheme.primary, fontWeight: FontWeight.w600)),
                ),
              ]),
              const SizedBox(height: 4),
              const Text('耗时 1分30秒 -- 正确识别板块运动模型',
                  style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
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
