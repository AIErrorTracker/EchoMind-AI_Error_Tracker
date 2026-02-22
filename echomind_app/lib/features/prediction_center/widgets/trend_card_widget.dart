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
            const Text('预测分趋势', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: CustomPaint(
                size: const Size(double.infinity, 120),
                painter: _TrendPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  static const _points = [58.0, 62.0, 60.0, 65.0, 68.0, 72.0];
  static const _labels = ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..color = AppTheme.primary;

    final minY = 50.0, maxY = 80.0;
    final h = size.height - 24;
    final w = size.width;
    final step = w / (_points.length - 1);

    final path = Path();
    for (var i = 0; i < _points.length; i++) {
      final x = i * step;
      final y = h - ((_points[i] - minY) / (maxY - minY)) * h;
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
      canvas.drawCircle(Offset(x, y), 3, dotPaint);

      final tp = TextPainter(
        text: TextSpan(text: _labels[i], style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - 14));
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
