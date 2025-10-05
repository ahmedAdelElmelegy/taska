import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdaptiveLayout extends StatelessWidget {
  final WidgetBuilder mobileLayout;
  final WidgetBuilder tabletLayout;
  final WidgetBuilder webLayout;

  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.webLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size designSize;

        if (constraints.maxWidth < 600) {
          designSize = const Size(375, 812); // Mobile size
        } else if (constraints.maxWidth < 900) {
          designSize = const Size(1024, 1366); // Tablet size
        } else {
          designSize = const Size(1920, 1080); // Web size
        }

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            if (constraints.maxWidth < 600) {
              return mobileLayout(context);
            } else if (constraints.maxWidth < 900) {
              return tabletLayout(context);
            } else {
              return webLayout(context);
            }
          },
        );
      },
    );
  }
}
