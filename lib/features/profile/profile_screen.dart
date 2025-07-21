import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/utils/constants.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/profile/widget/vertical_div.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(24),
                Row(
                  children: [
                    Image.asset(AppImages.logo2, height: 33.h, width: 33.w),
                    horizontalSpace(10),
                    Text('Profile', style: TextStyles.f24Bold),
                    Spacer(),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(24),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: AssetImage(AppImages.profile),
                    ),
                    Material(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(50.r),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgIcon(
                          icon: AppIcons.edit,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(24),
                Text('Daniel Austin', style: TextStyles.f22SemiBold),
                verticalSpace(8),
                Text('daniel_austin', style: TextStyles.f14Meduim),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('27', style: TextStyles.f24Bold),
                        verticalSpace(8),
                        Text('Projects', style: TextStyles.f18Meduim),
                      ],
                    ),
                    VerticalDiv(),
                    Column(
                      children: [
                        Text('27', style: TextStyles.f24Bold),
                        verticalSpace(8),
                        Text('Projects', style: TextStyles.f18Meduim),
                      ],
                    ),
                    VerticalDiv(),
                    Column(
                      children: [
                        Text('27', style: TextStyles.f24Bold),
                        verticalSpace(8),
                        Text('Projects', style: TextStyles.f18Meduim),
                      ],
                    ),
                  ],
                ),
                verticalSpace(18),
                Divider(thickness: 1, color: ColorManager.lightGrey),
                verticalSpace(40),
                Column(
                  children: List.generate(
                    Constants.profileItem.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Row(
                        children: [
                          SvgIcon(
                            icon: Constants.profileItem[index].icon,
                            // color:
                            //     Constants.profileItem.length == index
                            //         ? ColorManager.primary
                            //         : ColorManager.grey,
                          ),
                          horizontalSpace(8),
                          Text(
                            Constants.profileItem[index].title,
                            style: TextStyles.f18Meduim,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
