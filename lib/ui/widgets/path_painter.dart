import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final List<Offset> points;

  PathPainter({super.repaint, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kShapeBackgroundColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(points.last.dx, points.last.dy);
    for(var point in points){
      path.lineTo(point.dx, point.dy);
    }


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}