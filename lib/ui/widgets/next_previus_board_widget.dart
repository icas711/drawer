import 'package:drawer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextPreviusBoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16),
      child: SizedBox(
        width: 359.w,
        height: 31.h,
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 80.23.w,
            height: 31.h,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.31.w),
                  color: kBackgroundNextPreviusColor,
                ),
                child: Stack(children: [
                  Center(
                    child: Image.asset("assets/png/delimeter_opacity.png",
                    fit: BoxFit.cover,
                    width: 2.w,
                    height: 11.96.h,),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        InkWell(
                          child: SizedBox(
                            width: 19.49.w,
                            height: 16.83.w,
                            child: DecoratedBox(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0, right: 0.63,bottom: 0, left: 0.26),
                                child: Image.asset(
                                  "assets/png/back_opacity.png",
                                  fit: BoxFit.cover,
                                  width: 18.6.w,
                                  height: 16.83.w,
                                ),

                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: SizedBox(
                            width: 19.49.w,
                            height: 16.83.w,
                            child: DecoratedBox(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0, right: 0.63,bottom: 0, left: 0.26),
                                child: Image.asset(
                                  "assets/png/next_opacity.png",
                                  fit: BoxFit.cover,
                                width: 18.6.w,
                                height: 16.83.w,
                                  ),

                              ),
                            ),
                          ),
                        ),

                        //Center(child: Image.asset("assets/png/next_opacity.png"),)),
                      ],
                    ),
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}
