import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

Color _levelColor(int level) => switch (level) {
  0 => const Color(0xFFFF3B30),
  1 => const Color(0xFFFF9500),
  2 => const Color(0xFFFFCC00),
  3 => const Color(0xFF007AFF),
  4 => const Color(0xFF34C759),
  _ => const Color(0xFF00875A),
};

class ModelTreeWidget extends StatefulWidget {
  const ModelTreeWidget({super.key});

  @override
  State<ModelTreeWidget> createState() => _ModelTreeWidgetState();
}

class _ModelTreeWidgetState extends State<ModelTreeWidget> {
  final _expanded = <int>{0};

  static const _tree = [
    (
      title: '受力分析模型', level: 4, count: '4/5',
      items: [
        (title: '整体法与隔离法', level: 5),
        (title: '共点力平衡', level: 4),
        (title: '斜面体模型', level: 3),
        (title: '连接体模型', level: 4),
        (title: '板块运动', level: 2),
      ],
    ),
    (
      title: '运动学模型', level: 3, count: '2/4',
      items: [
        (title: '匀变速直线运动', level: 4),
        (title: '抛体运动', level: 3),
        (title: '圆周运动', level: 2),
        (title: '追及相遇', level: 1),
      ],
    ),
    (
      title: '能量守恒模型', level: 1, count: '1/3',
      items: [
        (title: '动能定理应用', level: 2),
        (title: '机械能守恒', level: 1),
        (title: '功能关系', level: 0),
      ],
    ),
    (
      title: '电磁学模型', level: 0, count: '0/3',
      items: [
        (title: '带电粒子在电场中运动', level: 1),
        (title: '带电粒子在磁场中运动', level: 0),
        (title: '电磁感应综合', level: 0),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          children: [for (var i = 0; i < _tree.length; i++) _buildCategory(i)],
        ),
      ),
    );
  }

  Widget _buildCategory(int ci) {
    final cat = _tree[ci];
    final open = _expanded.contains(ci);
    return Column(children: [
      if (ci > 0) const _DashedDivider(),
      GestureDetector(
        onTap: () => setState(() => open ? _expanded.remove(ci) : _expanded.add(ci)),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Row(children: [
            Icon(open ? Icons.expand_more : Icons.chevron_right, size: 22, color: AppTheme.textSecondary),
            const SizedBox(width: 6),
            Expanded(child: Text(cat.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
            Text(cat.count, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(width: 8),
            _LevelBadge(cat.level),
          ]),
        ),
      ),
      if (open)
        for (final item in cat.items)
          GestureDetector(
            onTap: () => context.push(AppRoutes.modelDetail),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(46, 10, 14, 10),
              child: Row(children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: _levelColor(item.level), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Expanded(child: Text(item.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400))),
                _LevelBadge(item.level),
              ]),
            ),
          ),
    ]);
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge(this.level);

  @override
  Widget build(BuildContext context) {
    final color = _levelColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
      child: Text('L$level', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DashedPainter(),
    );
  }
}

class _DashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.divider
      ..strokeWidth = 0.5;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + 4, 0), paint);
      x += 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
