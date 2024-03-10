import 'package:drawer/riverpod/models/position_ponts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final positionProvider =
StateNotifierProvider<PositionNotifier, PointerPositionPoints>(
        (ref) => PositionNotifier());

class PositionNotifier extends StateNotifier<PointerPositionPoints> {
  PositionNotifier()
      : super(PointerPositionPoints(
      startPostionPoint: Offset(-1, -1),
      endPositionPoint: Offset(-1, -1)));

  void updateStart(Offset value) {
    state = state.copyWith(startPostionPoint: value);
  }

  void updateEnd(Offset value) {
    state = state.copyWith(endPositionPoint: value);
  }

  void updateAll(Offset start, Offset end) {
    state = state.copyWith(startPostionPoint: start, endPositionPoint: end);
  }
}