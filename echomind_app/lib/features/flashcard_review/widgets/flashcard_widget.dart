import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class FlashcardWidget extends StatefulWidget {
  const FlashcardWidget({super.key});

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _flipped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _flipped = !_flipped),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _flipped ? _back() : _front(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_flipped) _feedbackButtons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _front() {
    return const Column(
      key: ValueKey('front'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('库仑定律的适用条件是什么？',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        SizedBox(height: 12),
        Text('点击卡片查看答案',
            style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget _back() {
    return const Column(
      key: ValueKey('back'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('答案', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
        SizedBox(height: 8),
        Text('库仑定律适用于真空中两个静止点电荷之间的相互作用力。'
            '要求：①点电荷 ②真空 ③静止',
            style: TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _feedbackButtons() {
    return Row(
      children: [
        _btn('忘了', AppTheme.danger),
        const SizedBox(width: 12),
        _btn('记得', AppTheme.primary),
        const SizedBox(width: 12),
        _btn('简单', AppTheme.success),
      ],
    );
  }

  Widget _btn(String label, Color color) {
    return Expanded(
      child: SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: () => setState(() => _flipped = false),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
            elevation: 0,
          ),
          child: Text(label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
