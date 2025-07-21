import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class AddCoverTask extends StatelessWidget {
  const AddCoverTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(width: 1.w, color: ColorManager.lightGrey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 24.sp, color: ColorManager.grey),
          verticalSpace(8),
          Text('Add Cover', style: TextStyles.f14Regular),
        ],
      ),
    );
  }
}
