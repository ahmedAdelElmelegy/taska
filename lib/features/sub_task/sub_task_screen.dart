import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';

import 'package:taska/core/themes/style.dart';

import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';

import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/comment/comment_screen.dart';
import 'package:taska/features/home/widgets/row_of_home.dart';
import 'package:taska/features/home/widgets/task_list_view.dart';
import 'package:taska/features/sub_task/widgets/comment_list_view.dart';
import 'package:taska/features/sub_task/widgets/comment_navgation_bar.dart';
import 'package:taska/features/sub_task/widgets/sub_task_list.dart';

class SubTaskScreen extends StatelessWidget {
  const SubTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(40),
                Row(
                  children: [
                    TextPop(text: 'Sub Task (14)'),
                    Spacer(),
                    SvgIcon(icon: AppIcons.star, color: Colors.amber),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(24),
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: AssetImage(AppImages.project),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                verticalSpace(24),
                Text(
                  'Create 24 different wireframe  views each case that occurs from ths application',
                  style: TextStyles.f16Regular,
                ),
                verticalSpace(36),
                SubTaskList(),
                verticalSpace(24),
                RowOfHome(text: 'Sub-Task (14)'),
                verticalSpace(24),
                TaskListView(),
                verticalSpace(24),
                CustomBtn(
                  onPressed: () {
                    defaultBottomSheet(
                      context,
                      title: 'Add New Sub-Task',
                      child: Column(
                        children: [
                          CustomTextField(text: 'Sub-Task Name'),
                          verticalSpace(24),
                          CustomTextField(
                            text: 'Due Date',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgIcon(icon: AppIcons.iconsDate),
                            ),
                          ),
                          verticalSpace(24),
                          CustomTextField(
                            text: 'Time',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgIcon(icon: AppIcons.time),
                            ),
                          ),
                          verticalSpace(24),
                          CustomBtn(text: 'Add New Sub-Task', onPressed: () {}),
                          verticalSpace(36),
                        ],
                      ),
                    );
                  },
                  text: 'Expand More',
                  color: ColorManager.lightBlue,
                  textColor: ColorManager.primary,
                ),
                verticalSpace(24),
                RowOfHome(
                  text: 'Comments (8)',
                  onPress: () {
                    push(CommentScreen());
                  },
                ),
                verticalSpace(24),
                CommentListView(),
                verticalSpace(24),
                CustomBtn(
                  onPressed: () {
                    push(CommentScreen());
                  },
                  text: 'Expand More',
                  color: ColorManager.lightBlue,
                  textColor: ColorManager.primary,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: CommentNavgationBar(),
    );
  }
}
