import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/project_person.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class ProfilesSections extends StatelessWidget {
  const ProfilesSections({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60.h,
            width: 100.w,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,

              children: List.generate(
                5,
                (index) =>
                    Positioned(left: index * 15.w, child: ProjectPerson()),
              ),
            ),
          ),
          SvgIcon(icon: AppIcons.flag, color: ColorManager.primary),
          Row(
            children: [
              Icon(Icons.chat_bubble, size: 24.sp, color: ColorManager.grey),
              horizontalSpace(8),
              Text('8', style: TextStyles.f14Regular),
            ],
          ),
          Row(
            children: [
              Icon(Icons.chat_bubble, size: 24.sp, color: ColorManager.grey),
              horizontalSpace(8),
              Text('8', style: TextStyles.f14Regular),
            ],
          ),
        ],
      ),
    );
  }
}
