import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class FinshedBtn extends StatelessWidget {
  const FinshedBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000.r),
        gradient: LinearGradient(
          colors: [
            ColorManager.white,
            ColorManager.primary,
            ColorManager.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Text(
        '80/90',
        style: TextStyles.f14Regular.copyWith(color: Colors.white),
      ),
    );
  }
}
