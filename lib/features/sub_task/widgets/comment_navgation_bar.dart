import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class CommentNavgationBar extends StatelessWidget {
  const CommentNavgationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        border: Border(top: BorderSide(color: ColorManager.grey, width: .3.w)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 5 / 100),
            blurRadius: 50,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 36.h,
          left: 24.w,
          right: 24.w,
          top: 24.h,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundImage: AssetImage(AppImages.profile),
            ),
            horizontalSpace(24),
            Expanded(
              child: CustomTextField(
                text: 'Post a comment...',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgIcon(
                    icon: AppIcons.send2,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
