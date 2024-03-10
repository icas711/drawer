import 'dart:math';
import 'dart:ui';

import 'package:drawer/riverpod/models/position_ponts.dart';
import 'package:drawer/main.dart';
import 'package:drawer/riverpod/position_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Rect canvasMaxSize(CanvasMaxSizeRef ref) {

  Rect rect = Rect.zero;
  final shapeList=ref.watch(shapeListProvider);
  List<Rect> rectList=[];

  for(int i=0;i<shapeList.length-1;i++){
    rectList.add(Rect.fromPoints(shapeList[i+1].point, shapeList[i].point));
  }
if(shapeList.length>2)
  rectList.add(Rect.fromPoints(shapeList.first.point, shapeList.last.point));

  for (final child in rectList) {
    rect = Rect.fromLTRB(
      min(rect.left, child.left),
      min(rect.top, child.top),
      max(rect.right, child.right),
      max(rect.bottom, child.bottom),
    );
  }
  return rect;
}

final transformProvider = Provider((ref) => TransformationController());

final isPathProvider = StateProvider<bool>((ref) => false);

final panEnableProvider = StateProvider<bool>((ref) {
if (ref.watch(isPathProvider)) {
    return true;
  }
  return false;
});

final nodeUpdateAvailableProvider = StateProvider<List<String>>((ref) {

  Offset _toLocal(Offset global) {
    final transform = ref.watch(transformProvider);
    return transform.toScene(global);
  }

  for (final node in ref.watch(shapeListProvider)) {
    if ((node.point - _toLocal(ref.watch(positionProvider).startPostionPoint))
            .distance <
        30/ref.watch(transformProvider).value.getMaxScaleOnAxis()) {
      return [node.id];
    }
  }
  return [];
});

@riverpod
Offset toLocal(ToLocalRef ref, Offset global) {
  final transform = ref.watch(transformProvider);
  return transform.toScene(global);
}

@riverpod
void pan(PanRef ref, Offset delta) {
  final matrix = ref.watch(transformProvider).value.clone();
  matrix.translate(delta.dx, delta.dy);
  ref.watch(transformProvider).value = matrix;
}



