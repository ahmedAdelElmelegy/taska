import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/cached_network_image.dart';
import 'package:taska/data/model/body/user_model.dart';

class ProfileInfo extends StatelessWidget {
  final UserModel userModel;
  const ProfileInfo({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(color: ColorManager.primary, width: 2),
          ),
          child: CachedImage(image: AppImages.profileImage),
        ),
        horizontalSpace(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userModel.fullName, style: TextStyles.f18SemiBold),
            verticalSpace(4),
            Text(userModel.userName, style: TextStyles.f14Meduim),
          ],
        ),
      ],
    );
  }
}
