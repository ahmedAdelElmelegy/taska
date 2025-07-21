import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,

          backgroundImage: AssetImage(AppImages.profile),
        ),
        horizontalSpace(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daniel Austin', style: TextStyles.f18SemiBold),
            verticalSpace(4),
            Text('daniel_austin', style: TextStyles.f14Meduim),
          ],
        ),
      ],
    );
  }
}
