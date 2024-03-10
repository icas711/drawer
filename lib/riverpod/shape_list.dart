import 'package:drawer/riverpod/dots_on_grid.dart';
import 'package:drawer/riverpod/models/draw_line.dart';
import 'package:drawer/riverpod/position_points.dart';
import 'package:drawer/riverpod/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//As a controller lines from <DrawLines>

class ShapeList extends Notifier<List<DrawLines>> {
  @override
  List<DrawLines> build() => [];

static const double distance=15;

  void add(DrawLines value) {
    state = [
      ...state,
      value,
    ];
  }

  void removeLast() {
    state = [state.removeLast()];
  }

  bool addOne() {
    double minDistance = distance;
    bool isPathed = false;
    final end = toLocal(ref.read(positionProvider).endPositionPoint);
    Offset newEnd = end;
    Offset startPath = Offset(-100, -100);
    if (state.isNotEmpty) {
      startPath = state.first.point;
    }

    if ((newEnd - startPath).distance < minDistance) {
      minDistance = 0;
      newEnd = startPath;
      isPathed = true;
    }

    //if need to move nodes to grid
    /*
    else {
      for (var item in ref.watch(onGridProvider)) {
        if ((item - end).distance < minDistance) {
          minDistance = (item - end).distance;
          newEnd = item;
        }
      }
    }*/
    final newStart = ref.read(positionProvider).startPostionPoint;
    List<Offset> check = state.map((e) => e.point).toList();
    if (check.length > 1) {
      for (int i = 0; i < check.length - 1; i++) {
        if (checkCross(check[i], check[i + 1], newStart, newEnd, i == 0)) {
          if (kDebugMode) {
            print('isCrossing!!!');
          }

          isPathed = false;
          return false;
        }
      }
    }

    if (isPathed) {
      ref.read(isPathProvider.notifier).update((state) => true);
      return true;
    }

    DrawLines value = DrawLines(
      key: UniqueKey(),
      point: minDistance < 10 ? newEnd : end,
    );
    state = state..add(value);
    return true;
  }

  void update(Offset delta, String id) {
    state = [
      for (final item in state)
        if (item.id == id)
          DrawLines(
            key: item.key,
            point: item.point + delta,
          )
        else
          item,
    ];
  }

  void getOnGrid(String id) {
    state = [
      for (final item in state)
        if (item.id == id)
          DrawLines(
            key: item.key,
            point: checkOnGrid(item.point),
          )
        else
          item,
    ];
  }

  Offset checkOnGrid(Offset end) {
    double minDistance = distance;
    Offset newEnd = end;
    for (var item in ref.watch(onGridProvider)) {
      if ((item - end).distance < minDistance) {
        minDistance = (item - end).distance;
        newEnd = item;
      }
    }
    return newEnd;
  }

  Offset getPointById(String id) {
    for (final item in state) {
      if (item.id == id) return item.point;
    }
    return state.first.point;
  }

  /*bool checkIntersection(){
    List<DrawLines> listNodes=state;
    listNodes.add(state.first);
    final length = listNodes.length;
    for(int i=0; i<length-2;i++){
      for(int j=i+1; j<length-1;j++){
            if(checkCross(listNodes[i].point, listNodes[i+1].point, listNodes[j].point, listNodes[j+1].point, false)){
              return false;
    }
      }
    }
    return true;
  }*/
  bool checkCross(
      Offset start1, Offset end1, Offset start2, Offset end2, bool isFirst) {
    //algorithm a-la kramer
    final dir1 = end1 - start1;
    final dir2 = end2 - start2;

    final a1 = -dir1.dy;
    final b1 = dir1.dx;
    final d1 = -(a1 * start1.dx + b1 * start1.dy);

    final a2 = -dir2.dy;
    final b2 = dir2.dx;
    final d2 = -(a2 * start2.dx + b2 * start2.dy);

    final seg1_line2_start = a2 * start1.dx + b2 * start1.dy + d2;
    final seg1_line2_end = a2 * end1.dx + b2 * end1.dy + d2;

    final seg2_line1_start = a1 * start2.dx + b1 * start2.dy + d1;
    final seg2_line1_end = a1 * end2.dx + b1 * end2.dy + d1;

    if (seg1_line2_start * seg1_line2_end > 0 ||
        seg2_line1_start * seg2_line1_end > 0) return false;

    final u = seg1_line2_start / (seg1_line2_start - seg1_line2_end);
    final out_intersection = start1 + Offset(u * dir1.dx, u * dir1.dy);
    if ((out_intersection - start2).distance < 1) {
      //if crossing in start when angle is small
      return false;
    }

    if (seg1_line2_start * seg1_line2_end == 0 ||
        seg2_line1_start * seg2_line1_end == 0) {
      if (isFirst) {
        if ((out_intersection - start1).distance < 1) {
          //pathing shape
          print('Замкнуто');
          return false;
        }
      }
    }

    return true;
  }

  Offset toLocal(Offset global) {
    final transform = ref.watch(transformProvider);
    return transform.toScene(global);
  }
}
