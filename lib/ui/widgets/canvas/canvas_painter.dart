import 'package:drawer/riverpod/providers.dart';
import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinesWidget extends ConsumerWidget {
   LinesWidget({
    super.key,
    required this.start,
    required this.end,
    required this.scaleSize,
  });

  final scaleSize;
  final Offset start;
  final Offset end;



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    bool isPath = ref.watch(isPathProvider);
    return CustomPaint(
        painter:
            LinePainter(start: start, end: end, scaleSize: scaleSize, isPath: isPath),
      );


  }
}

class LinePainter extends CustomPainter {
  LinePainter({
    required this.start,
    required this.end,
    required this.scaleSize,
    required this.isPath,
  });

  final double scaleSize;
  final Offset start;
  final Offset end;
final bool isPath;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    _line(canvas, size);
    _text(canvas, size);

    canvas.restore();
    _circleStart(canvas, size);
    _circleEnd(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _circleEnd(Canvas canvas, Size size) {
    canvas..drawCircle(
        end, 12.47/2 / scaleSize, Paint()..color = isPath ? kPathEdgeBorderColor :kEdgeBorderColor)
      ..drawCircle(
          end, (12.47-1.77)/2 / scaleSize, Paint()..color = isPath ? kPathEdgeBackgroundColor :kEdgeBackgroundColor);
  }
  void _circleStart(Canvas canvas, Size size) {
    canvas..drawCircle(
        start, 12.47/2 / scaleSize, Paint()..color = isPath ? kPathEdgeBorderColor :kEdgeBorderColor)
      ..drawCircle(
          start, (12.47-1.77)/2 / scaleSize, Paint()..color = isPath ? kPathEdgeBackgroundColor :kEdgeBackgroundColor);
  }
  void _line(Canvas canvas, Size size) {
    canvas.drawLine(
        start,
        end,
        Paint()
          ..strokeWidth = 7 / scaleSize
          ..color = Colors.black
          ..blendMode = BlendMode.darken);
  }

  void _text(Canvas canvas, Size size) {
    final fill = TextPainter(
        text: TextSpan(
            text: (start-end).distance.toStringAsFixed(2),
            style: TextStyle(fontSize: 12 / scaleSize, color: Colors.black)),
        textDirection: TextDirection.rtl);
    fill.layout();
    final Offset offset = Offset(start.dx + (end.dx - start.dx) / 2,
        start.dy + (end.dy - start.dy) / 2); //Offset(0, 0);
    final angle = math.atan((end.dy - start.dy) / (end.dx - start.dx));
    final pivot = Offset((fill.size.width) / 2, (fill.size.height) / 2);
    final double cooficient = angle > 0 ? 1 : -1;
    final delta =
        Offset(10 * cooficient / scaleSize, 20 * cooficient / scaleSize);
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(angle);
    canvas.translate(-offset.dx, -offset.dy);
    fill.paint(canvas, offset - pivot + delta);
  }
}
