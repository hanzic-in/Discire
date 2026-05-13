import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatBackgroundPainter extends CustomPainter {
  final Color color;

  ChatBackgroundPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.055)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final random = Random(12);

    for (int i = 0; i < 140; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      final type = random.nextInt(5);

      switch (type) {

        // circle
        case 0:
          canvas.drawCircle(
            Offset(x, y),
            random.nextDouble() * 16 + 6,
            paint,
          );
          break;

        // x
        case 1:
          canvas.drawLine(
            Offset(x - 7, y - 7),
            Offset(x + 7, y + 7),
            paint,
          );

          canvas.drawLine(
            Offset(x + 7, y - 7),
            Offset(x - 7, y + 7),
            paint,
          );
          break;

        // rounded rect
        case 2:
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset(x, y),
                width: 22,
                height: 22,
              ),
              const Radius.circular(6),
            ),
            paint,
          );
          break;

        // triangle
        case 3:
          final path = Path()
            ..moveTo(x, y - 10)
            ..lineTo(x - 10, y + 10)
            ..lineTo(x + 10, y + 10)
            ..close();

          canvas.drawPath(path, paint);
          break;

        // plus
        case 4:
          canvas.drawLine(
            Offset(x - 8, y),
            Offset(x + 8, y),
            paint,
          );

          canvas.drawLine(
            Offset(x, y - 8),
            Offset(x, y + 8),
            paint,
          );
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
