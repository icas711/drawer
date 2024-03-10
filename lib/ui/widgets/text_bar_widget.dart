import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBarWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(10),
     child: SizedBox(
       width: 359.w,
       height: 52.h,
       child: DecoratedBox(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(13.w),
           color: kHelpTagColor,
         ),
         child: Center(
           child: SizedBox(
             width: 340.w,
             child: const Text(
               'Нажмите на любую точку экрана, чтобы построить угол',
               style: TextStyle(
                   fontFamily: 'SF Pro Text Regular',
                   fontWeight: FontWeight.w500,
                   fontSize: 12,
                   height: 4 / 3,
                   color: Colors.black),
             ),
           ),
         ),
       ),
     ),
   );
  }

}