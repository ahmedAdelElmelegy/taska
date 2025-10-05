import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class ProjectBtn extends StatelessWidget {
  final bool? isActive;
  final String title;
  const ProjectBtn({super.key, this.isActive = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive == true ? ColorManager.primary : Colors.transparent,
        border: Border.all(color: ColorManager.primary, width: 2.w),
        borderRadius: BorderRadius.circular(1000.r),
      ),
      child: Text(
        title,
        style: TextStyles.f16SemiBoldWhite.copyWith(
          color: isActive == true ? Colors.white : ColorManager.primary,
        ),
      ),
    );
  }
}
