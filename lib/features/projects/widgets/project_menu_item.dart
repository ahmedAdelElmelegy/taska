import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/utils/constants.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/body/sub_task_model.dart';
import 'package:taska/features/projects/widgets/set_color.dart';
import 'package:taska/features/sub_task/widgets/sub_task_list.dart';

class ProjectMenuItem extends StatelessWidget {
  const ProjectMenuItem({super.key});
  static List<SubTaskModel> menuItem = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sp),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 5 / 100),
            blurRadius: 60,
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              defaultBottomSheet(
                context,
                title: 'Attachment',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        Constants.cover.length,
                        (index) => AttachmentItem(
                          subTaskModel: Constants.cover[index],
                        ),
                      ),
                    ),
                    verticalSpace(36),
                  ],
                ),
              );
            },
            child: MenuItem(
              subTaskModel: SubTaskModel(
                title: 'Add Cover',
                icon: AppIcons.camera,
              ),
            ),
          ),
          MenuItem(
            subTaskModel: SubTaskModel(
              title: 'Add Logo',
              icon: AppIcons.iconsCheck,
            ),
          ),
          GestureDetector(
            onTap: () {
              push(SetColor());
            },
            child: MenuItem(
              subTaskModel: SubTaskModel(
                title: 'Set Color',
                icon: AppIcons.eye,
              ),
            ),
          ),
          MenuItem(
            subTaskModel: SubTaskModel(
              title: 'Edit Project',
              icon: AppIcons.edit,
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      alignment: Alignment.center,
                      title: Text(
                        'Delete Project',
                        textAlign: TextAlign.center,
                        style: TextStyles.f20SemiBold.copyWith(
                          color: ColorManager.lightError,
                        ),
                      ),
                      content: Text(
                        textAlign: TextAlign.center,
                        'Are you sure you want to delete this project?',
                        style: TextStyles.f16Medium,
                      ),
                      actions: [
                        CustomBtn(text: 'Yes, Delete', onPressed: () {}),
                        verticalSpace(8),
                        CustomBtn(
                          text: 'Cancel',
                          onPressed: () {},
                          color: ColorManager.primaryLight,
                          textColor: ColorManager.primary,
                        ),
                      ],
                    ),
              );
            },
            child: MenuItem(
              color: ColorManager.lightError,
              subTaskModel: SubTaskModel(
                title: 'Delete Project',
                icon: AppIcons.delete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final SubTaskModel subTaskModel;
  final Color? color;
  const MenuItem({super.key, required this.subTaskModel, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              icon: subTaskModel.icon,
              color: color ?? ColorManager.black,
            ),
            horizontalSpace(15),
            Text(
              subTaskModel.title,
              style: TextStyles.f14SemiBold.copyWith(
                color: color ?? ColorManager.black,
              ),
            ),
          ],
        ),
        verticalSpace(18),
      ],
    );
  }
}
