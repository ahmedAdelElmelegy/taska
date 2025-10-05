import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/sub_task_model.dart';
import 'package:taska/features/projects/widgets/set_color.dart';

class ProjectMenuItem extends StatefulWidget {
  const ProjectMenuItem({
    super.key,
    this.onCoverImageSelected,
    required this.projectId,
  });
  static List<SubTaskModel> menuItem = [];
  final void Function(XFile? coverImage)? onCoverImageSelected;
  final String projectId;

  @override
  State<ProjectMenuItem> createState() => _ProjectMenuItemState();
}

class _ProjectMenuItemState extends State<ProjectMenuItem> {
  XFile? selectedImage;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
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
                title: 'Add Cover',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectImage(ImageSource.camera);
                            pop();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40.r,
                                backgroundColor: ColorManager.primaryDark,
                                child: SvgIcon(
                                  icon: AppIcons.camera,
                                  color: ColorManager.primary,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                              verticalSpace(16),
                              Text(
                                'Camera',
                                style: TextStyles.f16SemiBoldBlack,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectImage(ImageSource.gallery);
                            pop();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40.r,
                                backgroundColor: ColorManager.primaryDark,
                                child: SvgIcon(
                                  icon: AppIcons.gallery,
                                  color: ColorManager.primary,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                              verticalSpace(16),
                              Text(
                                'Gallery',
                                style: TextStyles.f16SemiBoldBlack,
                              ),
                            ],
                          ),
                        ),
                      ],
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
              push(SetColor(projectId: widget.projectId));
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
                        CustomBtn(
                          text: 'Yes, Delete',
                          onPressed: () {
                            context.read<ProjectCubit>().deleteProject(
                              widget.projectId,
                            );
                            pop();
                          },
                        ),
                        verticalSpace(8),
                        CustomBtn(
                          text: 'Cancel',
                          onPressed: () {
                            pop();
                          },
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

  Future selectImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      selectedImage = image;
      widget.onCoverImageSelected!(selectedImage);
    });
    // ignore: use_build_context_synchronously
    context.read<ProjectCubit>().addProjectCoverImage(
      File(image.path),
      widget.projectId,
    ); // ignore: use_build_context_synchronously
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
