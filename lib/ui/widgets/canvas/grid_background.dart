import 'package:drawer/riverpod/dots_on_grid.dart';
import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridBackgroundBuilder extends ConsumerWidget {
  const GridBackgroundBuilder({
    super.key,
    required this.cellWidth,
    required this.cellHeight,
    required this.viewport,
  });

  final double cellWidth;
  final double cellHeight;
  final Rect viewport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int firstRow = (viewport.top / cellHeight).floor();
    final int lastRow = (viewport.bottom / cellHeight).ceil();
    final int firstCol = (viewport.left / cellWidth).floor();
    final int lastCol = (viewport.right / cellWidth).ceil();
    List<Offset> dots = [];
    for (int row = firstRow; row < lastRow; row++)
      for (int col = firstCol; col < lastCol; col++) {
        dots.add(Offset(col * cellWidth - cellWidth / 2,
            row * cellHeight - cellHeight / 2));
      }
    ref.read(onGridProvider).clear();
    ref.read(onGridProvider).addAll(dots);

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        for (int row = firstRow; row < lastRow; row++)
          for (int col = firstCol; col < lastCol; col++)
            Positioned(
              left: col * cellWidth,
              top: row * cellHeight,
              child: SizedBox(
                height: cellHeight,
                width: cellWidth,
                child: (viewport.top / viewport.bottom < 0.25)
                    ? null
                    : const Center(
                        child: SizedBox(
                          width: 1,
                          height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kDotsColor,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
      ],
    );
  }
}
