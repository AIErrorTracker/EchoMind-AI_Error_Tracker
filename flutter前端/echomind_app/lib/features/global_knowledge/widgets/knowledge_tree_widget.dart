import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

// Level colors: L0=red, L1=orange, L2=yellow, L3=blue, L4=green, L5=deep green
Color _levelColor(int level) => switch (level) {
  0 => const Color(0xFFFF3B30),
  1 => const Color(0xFFFF9500),
  2 => const Color(0xFFFFCC00),
  3 => const Color(0xFF007AFF),
  4 => const Color(0xFF34C759),
  _ => const Color(0xFF00875A),
};

class KnowledgeTreeWidget extends StatefulWidget {
  const KnowledgeTreeWidget({super.key});

  @override
  State<KnowledgeTreeWidget> createState() => _KnowledgeTreeWidgetState();
}

class _KnowledgeTreeWidgetState extends State<KnowledgeTreeWidget> {
  int _subject = 0;
  final _expandedL1 = <int>{0}; // 力学 default open
  final _expandedL2 = <String>{'0-0'}; // 力的概念 default open

  // Tree data: chapters > sections > knowledge points
  static const _tree = [
    (
      title: '力学', level: 4,
      sections: [
        (title: '力的概念', level: 5, count: '3/3', items: [
          (title: '力的定义', level: 5),
          (title: '力的三要素', level: 4),
          (title: '力的单位', level: 5),
        ]),
        (title: '牛顿运动定律', level: 3, count: '2/3', items: [
          (title: '牛顿第一定律', level: 4),
          (title: '牛顿第二定律', level: 3),
          (title: '牛顿第三定律', level: 5),
        ]),
        (title: '摩擦力', level: 2, count: '0/2', items: [
          (title: '静摩擦力', level: 2),
          (title: '滑动摩擦力', level: 3),
        ]),
      ],
    ),
    (
      title: '静电场', level: 3,
      sections: [
        (title: '电荷', level: 4, count: '3/3', items: [
          (title: '电荷量', level: 4),
          (title: '元电荷', level: 4),
          (title: '起电方式', level: 5),
        ]),
        (title: '库仑定律', level: 2, count: '0/2', items: [
          (title: '库仑定律公式', level: 3),
          (title: '适用条件', level: 2),
        ]),
      ],
    ),
    (
      title: '电磁感应', level: 0,
      sections: [
        (title: '法拉第电磁感应定律', level: 1, count: '0/2', items: [
          (title: '感应电动势', level: 1),
          (title: '磁通量变化率', level: 0),
        ]),
        (title: '楞次定律', level: 0, count: '0/2', items: [
          (title: '楞次定律内容', level: 1),
          (title: '应用方法', level: 0),
        ]),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Subject filter
          Row(children: [
            _FilterChip(label: '物理', active: _subject == 0, onTap: () => setState(() => _subject = 0)),
            const SizedBox(width: 8),
            _FilterChip(label: '数学', active: _subject == 1, onTap: () => setState(() => _subject = 1)),
          ]),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [for (var ci = 0; ci < _tree.length; ci++) _buildChapter(ci)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapter(int ci) {
    final ch = _tree[ci];
    final open = _expandedL1.contains(ci);
    return Column(children: [
      if (ci > 0) const _DashedDivider(),
      GestureDetector(
        onTap: () => setState(() => open ? _expandedL1.remove(ci) : _expandedL1.add(ci)),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Row(children: [
            Icon(open ? Icons.expand_more : Icons.chevron_right, size: 22, color: AppTheme.textSecondary),
            const SizedBox(width: 6),
            Expanded(child: Text(ch.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
            _LevelBadge(ch.level),
          ]),
        ),
      ),
      if (open)
        for (var si = 0; si < ch.sections.length; si++) _buildSection(ci, si),
    ]);
  }

  Widget _buildSection(int ci, int si) {
    final sec = _tree[ci].sections[si];
    final key = '$ci-$si';
    final open = _expandedL2.contains(key);
    return Column(children: [
      if (si > 0) const Padding(padding: EdgeInsets.only(left: 28, right: 14), child: _DashedDivider()),
      GestureDetector(
        onTap: () => setState(() => open ? _expandedL2.remove(key) : _expandedL2.add(key)),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 12, 14, 12),
          child: Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: _levelColor(sec.level), shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Expanded(child: Text(sec.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
            Text(sec.count, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(width: 4),
            Icon(open ? Icons.expand_more : Icons.chevron_right, size: 16, color: AppTheme.textSecondary),
          ]),
        ),
      ),
      if (open)
        for (final item in sec.items)
          GestureDetector(
            onTap: () => context.push(AppRoutes.knowledgeDetail),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppTheme.primary : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: active ? Colors.white : AppTheme.textSecondary)),
      ),
    );
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
