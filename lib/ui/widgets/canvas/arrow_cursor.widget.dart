import 'dart:math' as math;
import 'dart:math';
import 'package:drawer/riverpod/providers.dart';
import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowCursorWidget extends ConsumerWidget {
  const ArrowCursorWidget({
    super.key,
    required this.position,
    required this.scaleSize,
  });

  final double scaleSize;
  final Offset position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transform = ref.watch(transformProvider);
    return CustomPaint(
      painter: ArrowCursorPainter(position: position, scaleSize: scaleSize, transform: transform),
    );
  }
}

class ArrowCursorPainter extends CustomPainter {
  const ArrowCursorPainter({
    required this.position,
    required this.scaleSize,
  required this.transform,
  });
  final double scaleSize;
  final Offset position;
final TransformationController transform;


  @override
  void paint(Canvas canvas, Size size) {
    for(double i=1/2; i<2.1; i+=1/2) {
      canvas.save();
      canvas.translate(transform
          .toScene(position)
          .dx, transform
          .toScene(position)
          .dy);
      canvas.rotate(math.pi*i);
      canvas.translate(-transform
          .toScene(position)
          .dx, -transform
          .toScene(position)
          .dy);

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
    final painter = Paint()..color = Colors.blue.shade600;

    canvas.drawCircle(
        transform.toScene(position),
      circleRadius/2.w / scaleSize,
      painter,
    );
  }
  void _drawWhiteCircle(Canvas canvas) {
    final painter = Paint()..color = Colors.white;

    canvas.drawCircle(
        transform.toScene(position),
      circleSmallRadius/2.w / scaleSize,
      painter,
    );
  }
  void _drawArrow(Canvas canvas, Size size){
    final painter = Paint()..color = Colors.blue.shade600
    ..strokeWidth=arrowBorderWidth/scaleSize;


    double x2= position.dx+circleRadius+arrowLength;
    double y2= position.dy;

    canvas.drawLine(transform.toScene(position),transform.toScene(Offset(x2,y2)),painter);

    //Draw upper line using (x2,y2) and (x3,y3)
    double x3 =x2-vectorWidth;
    double y3 = y2-vectorHeight;
    final painterVector = Paint()..color = Colors.blue.shade600
      ..strokeWidth=vectorBorderWidth/scaleSize;
    canvas.drawLine(transform.toScene(Offset(x2,y2)),transform.toScene(Offset(x3,y3)),painterVector);

    //Draw lower line using (x2,y2) and (x4,y4)
    double x4 = x3;
    double y4 = y2+vectorHeight;

    canvas.drawLine(transform.toScene(Offset(x2,y2)),transform.toScene(Offset(x4,y4)),painterVector);

  }
}

/*
class ArrowCursorWidget extends StatelessWidget{
  const ArrowCursorWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: 40.65.w,
      height: 40.97.w,
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(top: 0, right: 0.63,bottom: 0, left: 0.26),
          child: Image.asset(
            "assets/png/arrow_cursor.png",
            fit: BoxFit.cover,
            width: 18.6.w,
            height: 16.83.w,
          ),

        ),
      ),
    );
  }
}*/
