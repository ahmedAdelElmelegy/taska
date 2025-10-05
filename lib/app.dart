import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/bloc.dart';
import 'package:taska/features/splash/splash_screen.dart';
import 'package:taska/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),

      builder:
          (context, child) => GenerateMultipleBloc(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Taska',

              navigatorKey: navigator,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
              ),
              home: const SplashScreen(),
            ),
          ),
    );
  }
}
// 