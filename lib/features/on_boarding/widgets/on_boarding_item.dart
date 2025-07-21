import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/utils/constants.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/features/on_boarding/widgets/dots_list.dart';

class OnBoardingItem extends StatelessWidget {
  final int currentIndex;
  final void Function()? onPressed;
  const OnBoardingItem({super.key, required this.currentIndex, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(84 + 36),
            Image.asset(
              Constants.onBoardingList[currentIndex].image,
              width: 300.w,
              height: 250.h,
            ),
            verticalSpace(101),
            Text(
              Constants.onBoardingList[currentIndex].title,
              style: TextStyles.f30SemiBold,
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            Text(
              Constants.onBoardingList[currentIndex].description,
              style: TextStyles.f16Regular,
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            DotsList(currentIndex: currentIndex),
            verticalSpace(36),
            CustomBtn(onPressed: onPressed, text: 'Next'),
            verticalSpace(12),
            CustomBtn(
              onPressed: onPressed,
              text: 'Skip',
              color: ColorManager.background,
              textColor: ColorManager.primary,
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
