import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';

import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/teams/add_team.dart';
import 'package:taska/features/teams/widgets/member_item.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(41),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPop(text: 'Team Member (8)'),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(32),
                CustomTextField(
                  text: 'Search',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgIcon(
                      icon: AppIcons.iconsSearch,
                      width: 20.w,
                      height: 20.h,
                      color: ColorManager.grey,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgIcon(
                      icon: AppIcons.swap,
                      width: 20.w,
                      height: 20.h,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                verticalSpace(32),

                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: MemberItem(),
                      ),
                  itemCount: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          border: Border(
            top: BorderSide(color: ColorManager.grey, width: .3.w),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 5 / 100),
              blurRadius: 50,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 36.h,
            right: 24.w,
            left: 24.w,
          ),
          child: CustomBtn(
            text: 'Add Member',
            onPressed: () {
              push(AddTeam());
            },
          ),
        ),
      ),
    );
  }
}
