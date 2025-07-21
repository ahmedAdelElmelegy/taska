import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              horizontalSpace(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Andrew Liam', style: TextStyles.f18SemiBold),
                  Text(
                    'andrw_liam',
                    style: TextStyles.f14Regular.copyWith(
                      color: ColorManager.grey,
                    ),
                  ),
                ],
              ),
              Spacer(),
              SvgIcon(icon: AppIcons.iconsMore),
            ],
          ),
          verticalSpace(12),
          Text(
            'l’ve wireframed the app in figma ,but i still need to add a few more things.',
            style: TextStyles.f14Regular,
          ),
          verticalSpace(12),
          Row(
            children: [
              Row(
                children: [
                  SvgIcon(icon: AppIcons.heart),
                  horizontalSpace(4),
                  Text('1', style: TextStyles.f14Regular),
                ],
              ),
              horizontalSpace(24),
              Text('Reply', style: TextStyles.f14Regular),
              horizontalSpace(24),
              Text('3 hours ago', style: TextStyles.f14Regular),
            ],
          ),
        ],
      ),
    );
  }
}
