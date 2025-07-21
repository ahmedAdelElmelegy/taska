import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  const ShadowContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 5 / 100),
            blurRadius: 60,
          ),
        ],
      ),
      child: child,
    );
  }
}
