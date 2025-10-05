import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebLayOut extends StatelessWidget {
  const WebLayOut({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1152),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return child;
      },
    );
  }
}
