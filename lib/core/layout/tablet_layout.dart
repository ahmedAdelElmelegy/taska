import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabletLayout extends StatelessWidget {
  final Widget child;
  const TabletLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 1769),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return child;
      },
    );
  }
}
