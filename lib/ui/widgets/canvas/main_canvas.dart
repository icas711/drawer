import 'dart:async';
import 'dart:ui';

import 'package:drawer/riverpod/position_points.dart';
import 'package:drawer/ui/widgets/canvas/arrow_update_indicator_widget.dart';
import 'package:drawer/ui/widgets/canvas/grid_background.dart';
import 'package:drawer/ui/widgets/canvas/canvas_painter.dart';
import 'package:drawer/main.dart';
import 'package:drawer/riverpod/providers.dart';
import 'package:drawer/ui/widgets/canvas/arrow_cursor.widget.dart';
import 'package:drawer/ui/widgets/canvas/shape_draw.dart';
import 'package:drawer/ui/widgets/path_painter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class MainCanvas extends ConsumerStatefulWidget {
  const MainCanvas({
    super.key,
    this.gridSize = const Size.square(10),
  });

  final Size gridSize;

  @override
  InfiniteCanvasState createState() => InfiniteCanvasState();
}

class InfiniteCanvasState extends ConsumerState<MainCanvas> {
  late Timer _showDialogTimer;
  late Offset startPosition;
  late Offset endPosition;
  bool startShapeDrawing = false;
  bool continueShapeDraw = false;
  bool crossLine = false;
  double scaleSize = 1;
  bool startShapeUpdate = false;
  bool panEnable = false;
  String id = '';

  Offset toLocal(Offset global) {
    final transform = ref.watch(transformProvider);
    return transform.toScene(global);
  }

  Rect axisAlignedBoundingBox(Quad quad) {
    double xMin = quad.point0.x;
    double xMax = quad.point0.x;
    double yMin = quad.point0.y;
    double yMax = quad.point0.y;

    for (final point in <Vector3>[
      quad.point1,
      quad.point2,
      quad.point3,
    ]) {
      if (point.x < xMin) {
        xMin = point.x;
      } else if (point.x > xMax) {
        xMax = point.x;
      }

      if (point.y < yMin) {
        yMin = point.y;
      } else if (point.y > yMax) {
        yMax = point.y;
      }
    }

    return Rect.fromLTRB(xMin, yMin, xMax, yMax);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildBackground(BuildContext context, Quad quad) {
    final viewport = axisAlignedBoundingBox(quad);
    return GridBackgroundBuilder(
      cellWidth: widget.gridSize.width,
      cellHeight: widget.gridSize.height,
      viewport: viewport,
    );
  }

  @override
  void dispose() {
    _showDialogTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        //begin new shape
        if (!continueShapeDraw && !ref.watch(isPathProvider)) {
          _showDialogTimer = Timer(const Duration(milliseconds: 100), () async {
            ref
                .read(positionProvider.notifier)
                .updateAll(details.localPosition, details.localPosition);
            ref.read(shapeListProvider.notifier).addOne();
            setState(() {
              startShapeDrawing = true;
            });
          });
        }
        //continue shape
        else if (!ref.watch(isPathProvider)) {
          final start = ref.watch(shapeListProvider).last.point;
          ref
              .read(positionProvider.notifier)
              .updateAll(start, details.localPosition);
          setState(() {
            startShapeDrawing = true;
          });
        }
        //shape is done
        else {
          startShapeDrawing = false;
          //check on edge tapping
          ref
              .read(positionProvider.notifier)
              .updateAll(details.localPosition, details.localPosition);
          if (ref.watch(nodeUpdateAvailableProvider).isNotEmpty) {
            setState(() {
              id = ref.watch(nodeUpdateAvailableProvider)[0];
              startShapeUpdate = true;
              panEnable = false;
            });
          } else {
            setState(() {
              panEnable = true;
            });
          }
        }
      },
      onPointerUp: (details) {
        _showDialogTimer.cancel();
        if (startShapeDrawing) {
          (ref.read(shapeListProvider.notifier).addOne())
              ? startShapeDrawing = false
              : startShapeDrawing = true;
        }
        (ref.watch(isPathProvider))
            ? continueShapeDraw = false
            : continueShapeDraw = true;
        (ref.watch(isPathProvider)) ? panEnable = true : panEnable = false;
        //setState(() {
          startShapeUpdate = false;
        //});
      },
      onPointerMove: (details) {
        if (startShapeDrawing) {
          ref.read(positionProvider).endPositionPoint = details.localPosition;
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return InteractiveViewer.builder(
            panEnabled: panEnable,
            transformationController: ref.read(transformProvider),
            onInteractionUpdate: (details) {
              if (details.pointerCount > 1) {
                startShapeDrawing = false;
                _showDialogTimer.cancel();
              }
              if (panEnable) {
                ref.watch(panProvider(details.focalPointDelta));
              }
              if (startShapeUpdate) {
                ref
                    .watch(shapeListProvider.notifier)
                    .update(details.focalPointDelta / scaleSize, id);
              }
              setState(() {});
            },
            onInteractionEnd: (scaleEndDetails) {
              scaleSize =
                  ref.watch(transformProvider).value.getMaxScaleOnAxis();
              if(panEnable){
              ref.watch(shapeListProvider.notifier).getOnGrid(id);
               }

              setState(() {
                (ref.watch(isPathProvider))
                    ? panEnable = true
                    : panEnable = false;
                startShapeDrawing = false;
              });
            },
            minScale: 1,
            maxScale: 8,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            builder: (context, quad) {
              final lines = ref.watch(shapeListProvider);
              return SizedBox.fromSize(
                size: ref.watch(canvasMaxSizeProvider).size,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: buildBackground(context, quad),
                    ),
                    //Draw the background of result shape
                    if (ref.watch(isPathProvider)&&!startShapeUpdate)
                      CustomPaint(
                        painter: PathPainter(
                            points: lines.map((e) => e.point).toList()),
                      ),
                    //Draw lines from provider
                    if (lines.isNotEmpty)
                      ShapeDraw(nodes: lines.map((e) => e.point).toList()),
                    //Draw new lines and arrows
                    if (startShapeDrawing)
                      Positioned.fill(
                        child: Stack(
                          children: [
                            LinesWidget(
                              start:
                                  ref.watch(positionProvider).startPostionPoint,
                              end: toLocal(
                                  ref.watch(positionProvider).endPositionPoint),
                              scaleSize: scaleSize,
                            ),
                            ArrowCursorWidget(
                                position: ref
                                    .watch(positionProvider)
                                    .endPositionPoint,
                                scaleSize: scaleSize),
                          ],
                        ),
                      ),
                    if (startShapeUpdate)
                      ArrowUpdateIndicatorWidget(
                          point: lines
                              .firstWhere((element) => element.id == id)
                              .point),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
