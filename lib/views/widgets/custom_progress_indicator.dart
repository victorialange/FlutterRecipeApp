import 'package:flutter/material.dart';
import 'dart:math' show pi;

class CustomProgressIndicator extends StatelessWidget {
  final double? value;
  final double strokeWidth;
  final double radius;
  final String semanticsLabel;
  final String? semanticsValue;

  const CustomProgressIndicator({
    Key? key,
    required this.value,
    this.strokeWidth = 4.0,
    this.radius = 20.0,
    required this.semanticsLabel,
    required this.semanticsValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      value: semanticsValue ?? 0.0.toString(),
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CustomPaint(
          painter: _CustomProgressPainter(
            value: value ?? 0.0.toDouble(),
            strokeWidth: strokeWidth,
            radius: radius,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}

class _CustomProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final double radius;
  final Color color;

  _CustomProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final progressAngle = 2 * value * pi - pi / 2;

    canvas.drawCircle(center, radius, paint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        progressAngle, false, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(_CustomProgressPainter oldDelegate) =>
      value != oldDelegate.value ||
      strokeWidth != oldDelegate.strokeWidth ||
      radius != oldDelegate.radius ||
      color != oldDelegate.color;
}
