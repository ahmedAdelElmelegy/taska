import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/outline_container.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/projects/add_new_task.dart';
import 'package:taska/features/projects/widgets/detail_item.dart';
import 'package:taska/features/projects/widgets/project_detail_container.dart';
import 'package:taska/features/sub_task/sub_task_screen.dart';

class ProjectDetailItem extends StatelessWidget {
  const ProjectDetailItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(SubTaskScreen());
      },
      child: Container(
        width: 319.w,
        margin: EdgeInsets.symmetric(horizontal: 24.w),

        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: ColorManager.details,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('To-Do', style: TextStyles.f20SemiBold),
                horizontalSpace(8),
                OutlineContainer(),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    push(AddNewTask());
                  },
                  child: SvgIcon(icon: AppIcons.addRounded),
                ),
              ],
            ),
            verticalSpace(50),
            ProjectDetailContainer(),
            verticalSpace(30),
            Column(children: List.generate(5, (index) => DetailItem())),
          ],
        ),
      ),
    );
  }
}
