import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class OutlineContainer extends StatelessWidget {
  final String? text;
  const OutlineContainer({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorManager.primary, width: 2.w),
      ),
      child: Center(
        child: Text(text ?? '6', style: TextStyles.f16SemiBoldBlack),
      ),
    );
  }
}
