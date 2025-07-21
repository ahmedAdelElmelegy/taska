import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/calender_page.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/core/widgets/project_person.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class NewProjectScreen extends StatelessWidget {
  const NewProjectScreen({super.key});
  static final List<String> _status = ["Pending", "In Progress", "Completed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            // height: 249.h,
            color: ColorManager.primaryDark,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  verticalSpace(70),
                  Row(
                    children: [
                      SvgIcon(
                        icon: AppIcons.iconsArrowBack,
                        color: ColorManager.primary,
                      ),

                      Spacer(),
                      SvgIcon(
                        icon: AppIcons.iconsSearch,
                        color: ColorManager.primary,
                      ),
                      horizontalSpace(20),
                      SvgIcon(
                        icon: AppIcons.iconsMore,
                        color: ColorManager.primary,
                      ),
                    ],
                  ),
                  verticalSpace(75),
                  Row(
                    children: [
                      SvgIcon(icon: AppIcons.edit),
                      Spacer(),
                      SizedBox(
                        height: 60.h,
                        width: 100.w,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.centerLeft,

                          children: List.generate(
                            5,
                            (index) => Positioned(
                              left: index * 15.w,
                              child: ProjectPerson(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(24),
                ],
              ),
            ),
          ),
          verticalSpace(24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('E-Wallet App Project', style: TextStyles.f33Bold),
                verticalSpace(8),
                Text(
                  'Add Description',
                  style: TextStyles.f14Regular.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
                verticalSpace(30),
                PrimaryOutLineBtn(
                  text: 'Set Deadline Project',
                  height: 55.h,
                  onPressed: () {
                    defaultBottomSheet(
                      context,
                      title: 'Add Deadline Project',
                      child: Column(
                        children: [CalendarPage(), verticalSpace(36)],
                      ),
                    );
                  },
                ),
                verticalSpace(24),
                _status.isNotEmpty
                    ? Container(
                      width: 328.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 18.h,
                        horizontal: 24.w,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primaryDark,
                      ),
                      child: Row(
                        children: [
                          Text('To-Do', style: TextStyles.f16SemiBoldBlack),
                          OutLineBtn(text: '6'),
                          horizontalSpace(150.w),
                          SvgIcon(icon: AppIcons.iconsMore),
                        ],
                      ),
                    )
                    : Image.asset(AppImages.newProject, height: 338.h),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        shape: CircleBorder(side: BorderSide(color: ColorManager.primary)),
        onPressed: () {
          defaultBottomSheet(
            context,
            title: 'Add New Board',
            child: Column(
              children: [
                CustomTextField(text: 'Board Name'),
                verticalSpace(24),
                CustomBtn(
                  text: 'Create Group Chat',
                  onPressed: () {},
                  color: ColorManager.secondary,
                ),
                verticalSpace(36),
              ],
            ),
          );
        },
        child: Icon(Icons.add, size: 24.sp, color: ColorManager.white),
      ),
    );
  }
}
