import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppImages.logo2, height: 33.h, width: 33.w),
        horizontalSpace(10),
        Text('Profile', style: TextStyles.f24Bold),
        Spacer(),
        SvgIcon(icon: AppIcons.iconsMore),
      ],
    );
  }
}
