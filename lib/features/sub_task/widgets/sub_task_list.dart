import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/utils/constants.dart';
import 'package:taska/core/widgets/calender_page.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/core/widgets/project_person.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/body/sub_task_model.dart';
import 'package:taska/features/sub_task/widgets/status_item.dart';
import 'package:taska/features/sub_task/widgets/subtask_item.dart';
import 'package:taska/features/teams/teams_screen.dart';

class SubTaskList extends StatelessWidget {
  const SubTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubTaskItem(
          item: Constants.subTaskList[0],
          trailing: Expanded(
            child: Row(
              children: [
                horizontalSpace(36),
                Row(children: List.generate(5, (index) => ProjectPerson())),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    push(TeamsScreen());
                  },
                  child: SvgIcon(
                    icon: AppIcons.addRounded,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),

        SubTaskItem(
          item: Constants.subTaskList[1],
          trailing: Expanded(
            child: Row(
              children: [
                horizontalSpace(29),
                ProjectPerson(),
                horizontalSpace(4),
                Text(
                  ' Daniel Austin (you)',
                  style: TextStyles.f16Regular.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),

        SubTaskItem(
          item: Constants.subTaskList[2],
          trailing: Expanded(
            child: Row(
              children: [
                horizontalSpace(38),
                PrimaryOutLineBtn(
                  text: 'To-Do',
                  onPressed: () async {
                    await defaultBottomSheet(
                      context,
                      title: 'Status',
                      child: Column(
                        children: List.generate(
                          Constants.status.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(bottom: 36.h),
                            child: StatusItem(title: Constants.status[index]),
                          ),
                        ),
                      ),
                    );
                  },
                  width: 70.w,
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),

        SubTaskItem(
          item: Constants.subTaskList[3],
          trailing: Expanded(
            child: Row(
              children: [
                horizontalSpace(18),
                Text(
                  'Due date : Dec 14,2024',
                  style: TextStyles.f14SemiBold.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
                horizontalSpace(8),
                GestureDetector(
                  onTap: () async {
                    await defaultBottomSheet(
                      context,
                      title: 'Due Date',
                      child: Column(
                        children: [CalendarPage(), verticalSpace(36)],
                      ),
                    );
                  },
                  child: SvgIcon(
                    icon: AppIcons.edit,
                    width: 16.w,
                    height: 16.h,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),
        SubTaskItem(
          item: Constants.subTaskList[4],
          trailing: Expanded(
            child: Row(
              children: [
                horizontalSpace(18),
                Expanded(
                  flex: 4,
                  child: PrimaryOutLineBtn(text: 'References.pdf'),
                ),
                horizontalSpace(8),
                Expanded(
                  flex: 2,
                  child: CustomBtn(
                    height: 32.h,
                    onPressed: () {
                      defaultBottomSheet(
                        context,
                        title: 'Attachment',
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                Constants.attachment.length,
                                (index) => AttachmentItem(
                                  subTaskModel: Constants.attachment[index],
                                ),
                              ),
                            ),
                            verticalSpace(36),
                          ],
                        ),
                      );
                    },

                    text: 'Add',
                    // height: 32.h,
                    // width: 83.w,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),
        CustomBtn(
          onPressed: () {},
          text: 'Add Custom Section',
          color: ColorManager.lightBlue,
          textColor: ColorManager.primary,
        ),
      ],
    );
  }
}

class AttachmentItem extends StatelessWidget {
  final SubTaskModel subTaskModel;
  const AttachmentItem({super.key, required this.subTaskModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32.r,
          backgroundColor: ColorManager.primaryLight,
          child: SvgIcon(
            icon: subTaskModel.icon,
            color: ColorManager.primary,
            width: 30.w,
            height: 30.h,
          ),
        ),
        verticalSpace(8),
        Text(subTaskModel.title, style: TextStyles.f16Medium),
      ],
    );
  }
}
