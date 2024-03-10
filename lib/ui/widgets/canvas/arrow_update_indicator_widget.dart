import 'dart:math' as math;
import 'dart:math';
import 'package:drawer/riverpod/providers.dart';
import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowUpdateIndicatorWidget extends ConsumerWidget {
  const ArrowUpdateIndicatorWidget({
    super.key,
    required this.point,
  });

  final Offset point;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transform = ref.watch(transformProvider);
    return CustomPaint(
      painter: ArrowUpdaterPainter(
          position: point,
          scaleSize: ref.watch(transformProvider).value.getMaxScaleOnAxis(),
          transform: transform),
    );
  }
}

class ArrowUpdaterPainter extends CustomPainter {
  const ArrowUpdaterPainter({
    required this.position,
    required this.scaleSize,
    required this.transform,
  });

  final double scaleSize;
  final Offset position;
  final TransformationController transform;

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 1 / 2; i < 2.1; i += 1 / 2) {
      canvas.save();
      canvas.translate(
          position.dx, position.dy);
      canvas.rotate(math.pi * i);
      canvas.translate(
          -position.dx, -position.dy);

      _drawArrow(canvas, size);

      canvas.restore();
    }
    // _drawArrow(canvas, size);
    _drawBlueCircle(canvas);
    _drawWhiteCircle(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawBlueCircle(Canvas canvas) {
    final painter = Paint()..color = Colors.green.shade600;

    canvas.drawCircle(
      position,
      circleRadius / 1.3.w / scaleSize,
      painter,
    );
  }

  void _drawWhiteCircle(Canvas canvas) {
    final painter = Paint()..color = Colors.white;

    canvas.drawCircle(
      position,
      circleSmallRadius / 1.4.w / scaleSize,
      painter,
    );
  }

  void _drawArrow(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = arrowBorderWidth * 1.3 / scaleSize;

    double x2 = position.dx + circleRadius * 2/ scaleSize + arrowLength/ scaleSize;
    double y2 = position.dy;

    canvas.drawLine(position,
        Offset(x2, y2), painter);

    //Draw upper line using (x2,y2) and (x3,y3)
    double x3 = x2 - vectorWidth * 1.2;
    double y3 = y2 - vectorHeight * 1.2;
    final painterVector = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = vectorBorderWidth * 1.2 / scaleSize;
    canvas.drawLine(Offset(x2, y2),
       Offset(x2 +(x3-x2)/ scaleSize, y2+(y3-y2)/ scaleSize), painterVector);

    //Draw lower line using (x2,y2) and (x4,y4)
    double x4 = x3;
    double y4 = y2 + vectorHeight;

    canvas.drawLine(Offset(x2, y2),
       Offset(x2 +(x4-x2)/ scaleSize, y2+(y4-y2)/ scaleSize), painterVector);
  }
}
