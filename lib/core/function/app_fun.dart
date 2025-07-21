import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

Future<dynamic> defaultBottomSheet(
  BuildContext context, {
  String? title,
  Widget? child,
}) {
  return showModalBottomSheet(
    context: context,
    builder:
        (context) => SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: 24.h,
              left: 24.w,
              right: 24.w,
              top: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.r),
                topRight: Radius.circular(50.r),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 35.w,
                  child: Divider(
                    thickness: 1,
                    color: ColorManager.lightGrey,
                    height: 3,
                    // indent: 50,
                    // endIndent: 50,
                  ),
                ),
                verticalSpace(24),
                Text(title ?? "", style: TextStyles.f24Bold),
                verticalSpace(16),
                Divider(
                  thickness: 1,
                  color: ColorManager.lightDivider,
                  height: 1,
                ),
                verticalSpace(24),
                child ?? Container(),
              ],
            ),
          ),
        ),
  );
}
