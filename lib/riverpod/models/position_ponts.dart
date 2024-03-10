import 'package:flutter/material.dart';

class PointerPositionPoints {
  Offset startPostionPoint; // = [Offset(0, 0), Offset(0, 0)];
  Offset endPositionPoint;

  PointerPositionPoints({
    required this.startPostionPoint,
    required this.endPositionPoint,
  });

  PointerPositionPoints copyWith({
    Offset? startPostionPoint,
    Offset? endPositionPoint,
  }) {
    return PointerPositionPoints(
      startPostionPoint: startPostionPoint ?? this.startPostionPoint,
      endPositionPoint: endPositionPoint ?? this.endPositionPoint,
    );
  }
}


