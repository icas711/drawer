import 'dart:math';

import 'package:drawer/riverpod/models/draw_line.dart';
import 'package:drawer/riverpod/shape_list.dart';
import 'package:drawer/ui/home_page.dart';
import 'package:drawer/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final shapeListProvider = NotifierProvider<ShapeList, List<DrawLines>>(ShapeList.new);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light
  ));
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(backgroundColor:kAppBarColor),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.grey,
              background: kBackgroundColor,
            ),
          ),
          home: child,
        );
      },
      child: const HomePage(),
    );
  }
}