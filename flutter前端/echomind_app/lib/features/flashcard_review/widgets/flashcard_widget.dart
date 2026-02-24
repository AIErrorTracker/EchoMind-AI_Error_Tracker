import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class FlashcardWidget extends StatefulWidget {
  const FlashcardWidget({super.key});

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _flipped = false;
  int _index = 0;
  double _dragOffset = 0;

  static const _cards = [
    (
      q: '库仑定律的适用条件是什么？',
      a: '库仑定律适用于真空中两个静止点电荷之间的相互作用力。\n要求：①点电荷 ②真空 ③静止',
      detail: '库仑定律 F = kQ₁Q₂/r² 只在满足上述三个条件时才严格成立。对于均匀带电球壳，可以等效为点电荷处理，但必须在球壳外部。球壳内部电场为零（静电屏蔽）。',
      tag: '概念卡',
    ),
    (
      q: '万有引力定律与库仑定律的核心区别？',
      a: '万有引力只有吸引力，库仑力可吸引可排斥。\n万有引力适用于任意两物体，库仑定律要求点电荷+真空。',
      detail: '虽然两者都是平方反比定律，但物理本质不同。引力常量 G 极小（6.67×10⁻¹¹），而静电力常量 k 很大（9×10⁹），所以微观世界中电磁力远大于引力。',
      tag: '辨析卡',
    ),
    (
      q: '板块运动中如何判断相对滑动方向？',
      a: '比较两个物体的加速度大小，加速度大的相对向前运动。\n摩擦力方向与相对运动方向相反。',
      detail: '关键步骤：①分别对两物体受力分析 ②分别列牛顿第二定律 ③比较加速度 ④判断相对运动趋势 ⑤确定摩擦力方向。注意：共速后可能一起运动，也可能再次分离。',
      tag: '决策卡',
    ),
  ];

  void _goTo(int i) {
    if (i < 0 || i >= _cards.length) return;
    setState(() { _flipped = false; _index = i; });
  }

  void _onFeedback() {
    if (_index < _cards.length - 1) {
      _goTo(_index + 1);
    } else {
      setState(() => _flipped = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = _cards[_index];
    return Column(
      children: [
        // Card area
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: GestureDetector(
            onTap: () => setState(() => _flipped = !_flipped),
            onHorizontalDragUpdate: (d) => setState(() => _dragOffset += d.delta.dx),
            onHorizontalDragEnd: (d) {
              if (_dragOffset > 60) _goTo(_index - 1);
              if (_dragOffset < -60) _goTo(_index + 1);
              setState(() => _dragOffset = 0);
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  // Card with shadow
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.translationValues(_dragOffset * 0.3, 0, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4)),
                        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 1)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(anim), child: child),
                        ),
                        child: _flipped ? _backContent(card) : _frontContent(card),
                      ),
                    ),
                  ),
                  // Tag badge top-left
                  Positioned(
                    left: 12, top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        card.tag,
                        style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  // Flip hint top-right
                  Positioned(
                    right: 12, top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _flipped ? '点击翻回' : '点击翻转',
                        style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                      ),
                    ),
                  ),
                  // Left arrow
                  Positioned(
                    left: 0, top: 0, bottom: 0,
                    child: GestureDetector(
                      onTap: _index > 0 ? () => _goTo(_index - 1) : null,
                      child: Container(
                        width: 32, alignment: Alignment.center,
                        child: Icon(Icons.chevron_left, size: 26,
                          color: _index > 0 ? AppTheme.textSecondary : AppTheme.divider),
                      ),
                    ),
                  ),
                  // Right arrow
                  Positioned(
                    right: 0, top: 0, bottom: 0,
                    child: GestureDetector(
                      onTap: _index < _cards.length - 1 ? () => _goTo(_index + 1) : null,
                      child: Container(
                        width: 32, alignment: Alignment.center,
                        child: Icon(Icons.chevron_right, size: 26,
                          color: _index < _cards.length - 1 ? AppTheme.textSecondary : AppTheme.divider),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Hint below card
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 6),
          child: Text(
            _flipped ? '已翻转 · 查看下方解析' : '点击卡片翻转查看答案',
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ),
        // Feedback buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _btn('忘了', AppTheme.danger),
              const SizedBox(width: 10),
              _btn('记得', AppTheme.primary),
              const SizedBox(width: 10),
              _btn('简单', AppTheme.success),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Lower: analysis
        Expanded(
          child: _flipped
              ? _analysisSection(card)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _frontContent(dynamic card) {
    return Column(
      key: const ValueKey('front'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(card.q as String,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.4),
          textAlign: TextAlign.center),
      ],
    );
  }

  Widget _backContent(dynamic card) {
    return Column(
      key: const ValueKey('back'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('答案', style: TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(card.a as String,
          style: const TextStyle(fontSize: 15, height: 1.5),
          textAlign: TextAlign.center),
      ],
    );
  }

  Widget _analysisSection(dynamic card) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('解析', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(card.detail as String,
                style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.6)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _btn(String label, Color color) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: ElevatedButton(
          onPressed: _flipped ? _onFeedback : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            disabledBackgroundColor: color.withValues(alpha: 0.3),
            disabledForegroundColor: Colors.white54,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
            elevation: 0,
          ),
          child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
