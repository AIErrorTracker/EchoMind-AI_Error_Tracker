import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class TrendCardWidget extends StatelessWidget {
  const TrendCardWidget({super.key});

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
            const Text('预测分数趋势',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: CustomPaint(
                size: const Size(double.infinity, 120),
                painter: _TrendPainter(),
              ),
            ),
            const SizedBox(height: 4),
            _dateLabels(),
          ],
        ),
      ),
    );
  }

  static Widget _dateLabels() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('1月20日',
            style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
        Text('1月27日',
            style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
        Text('2月3日',
            style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
        Text('2月10日',
            style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
      ],
    );
  }
}

class _TrendPainter extends CustomPainter {
  static const _points = [55.0, 57.0, 59.0, 61.0, 60.0, 63.0];

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppTheme.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..color = AppTheme.primary;

    const minY = 50.0;
    const maxY = 70.0;
    final h = size.height;
    final w = size.width;
    final step = w / (_points.length - 1);

    final path = Path();
    for (var i = 0; i < _points.length; i++) {
      final x = i * step;
      final y = h - ((_points[i] - minY) / (maxY - minY)) * h;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 3.5, dotPaint);
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}