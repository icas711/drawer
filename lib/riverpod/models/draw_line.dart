import 'package:flutter/material.dart';

class DrawLines {
  DrawLines({
    required this.key,
    required this.point,

    this.label,
  });

  String get id => key.toString();
  final LocalKey key;
  late Offset point;
  String? label;



  DrawLines copyWith({
    LocalKey? key,
    Offset? point,
    String? label,
  }) {
    return DrawLines(
      key: key ?? this.key,
      point: point ?? this.point,
      label: label ?? this.label,
    );
  }

  static const double minDistance=15;
}
