import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class CancelButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.w,
      height: 70.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.w),
          color: kHelpTagColor,
        ),
        child: InkWell(
          child: Center(
            child: SizedBox(
              width: 336.w,
              height: 46.5.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(11.w),
                  color: kBackgroundColor,
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 13.5.w,
                        height: 13.5.h,
                        child: const Icon(
                            SFSymbols.xmark_circle_fill,
                            color: kIconsColor)),
                    const Text(
                      'Отменить действие',
                      style: TextStyle(
                          fontFamily:
                          'SF Pro Text Regular',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 4 / 3,
                          color: kIconsColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}