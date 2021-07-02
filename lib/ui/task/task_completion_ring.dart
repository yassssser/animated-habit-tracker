import 'dart:math';

import 'package:flutter/material.dart';

import '../theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  TaskCompletionRing({Key key, @required this.progress}) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
            progress: progress,
            taskNotCompletedColor: themeData.taskRing,
            taskCompletedColor: themeData.accent),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  RingPainter(
      {@required this.progress,
      @required this.taskNotCompletedColor,
      @required this.taskCompletedColor});
  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strockWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        notCompleted ? (size.width - strockWidth) / 2 : size.width / 2;

    if (notCompleted) {
      final backGroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strockWidth
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backGroundPaint);
    }

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strockWidth
      ..color = taskCompletedColor
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
