import 'package:drawer/riverpod/providers.dart';
import 'package:drawer/ui/widgets/canvas/main_canvas.dart';
import 'package:drawer/ui/widgets/canvas/arrow_cursor.widget.dart';
import 'package:drawer/ui/widgets/cancel_button_widget.dart';
import 'package:drawer/ui/widgets/next_previus_board_widget.dart';
import 'package:drawer/ui/widgets/text_bar_widget.dart';
import 'package:drawer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: 1.sw,
            height: 57.h,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: kAppBarColor),
            ),
          ),
          Expanded(
            child: Stack(
                /*fit: StackFit.expand,*/
                clipBehavior: Clip.none,
                children: [
                  const MainCanvas(
                    gridSize: Size.square(10),
                  ),
                  Column(
                    children: [
                      NextPreviusBoardWidget(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              if(!ref.watch(isPathProvider)) TextBarWidget(),
                              CancelButtonWidget(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

//styleName: Caption1;
