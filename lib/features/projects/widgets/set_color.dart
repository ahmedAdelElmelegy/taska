import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/text_pop.dart';

class SetColor extends StatelessWidget {
  const SetColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(40),
                TextPop(text: 'Set Color'),
                verticalSpace(24),
                GridViewColor(),
                verticalSpace(24),
                CustomBtn(onPressed: () {}, text: 'Set Color'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridViewColor extends StatelessWidget {
  const GridViewColor({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ColorManager.colors.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        if (index == ColorManager.colors.length) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: 121.w,
              height: 124.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(width: 1, color: ColorManager.lightGrey),
              ),
              child: Icon(Icons.add, color: ColorManager.grey),
            ),
          );
        } else {
          return Container(
            width: 121.w,
            height: 124.h,

            decoration: BoxDecoration(
              color: ColorManager.colors[index],
              borderRadius: BorderRadius.circular(24.r),
            ),
          );
        }
      },
    );
  }
}
