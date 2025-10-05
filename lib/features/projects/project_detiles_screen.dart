import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/helper/validator.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/calender_page.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/core/widgets/project_person.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/time_picker_page.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/home/widgets/finshed_btn.dart';
import 'package:taska/features/home/widgets/slider_widget.dart';
import 'package:taska/features/projects/widgets/board_item.dart';
import 'package:taska/features/projects/widgets/board_list.dart';
import 'package:taska/features/projects/widgets/project_menu_item.dart';
import 'package:uuid/uuid.dart';

class ProjectDetilesScreen extends StatefulWidget {
  final ProjectModel? projectModel;
  const ProjectDetilesScreen({super.key, this.projectModel});

  @override
  State<ProjectDetilesScreen> createState() => _ProjectDetilesScreenState();
}

class _ProjectDetilesScreenState extends State<ProjectDetilesScreen> {
  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).getBoard(widget.projectModel!.id);

    super.initState();
  }

  bool _moreSelected = false;
  XFile? coverImageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          if (state is AddProjectCoverImageLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AddProjectCoverImageFailure) {
            return Center(child: Text(state.message));
          }
          return SingleChildScrollView(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _moreSelected = false;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 240.h,
                        decoration:
                            widget.projectModel?.coverImage != null ||
                                    coverImageFile != null
                                ? BoxDecoration(
                                  // borderRadius: BorderRadius.circular(24.r),
                                  image: DecorationImage(
                                    image:
                                        coverImageFile != null
                                            ? FileImage(
                                              File(coverImageFile!.path),
                                            )
                                            : NetworkImage(
                                              widget.projectModel!.coverImage!,
                                            ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : BoxDecoration(
                                  color: ColorManager.primaryLight,
                                ),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              children: [
                                verticalSpace(21),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => pop(),
                                      child: SvgIcon(
                                        icon: AppIcons.iconsArrowBack,
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                    Spacer(),
                                    SvgIcon(
                                      icon: AppIcons.iconsSearch,
                                      color: ColorManager.primary,
                                    ),
                                    horizontalSpace(20),
                                    widget.projectModel?.ownerId !=
                                            FirebaseAuth
                                                .instance
                                                .currentUser!
                                                .uid
                                        ? SizedBox()
                                        : InkWell(
                                          onTap: () {
                                            setState(() {
                                              _moreSelected = !_moreSelected;
                                            });
                                          },
                                          child: SvgIcon(
                                            icon: AppIcons.iconsMore,
                                            color: ColorManager.primary,
                                          ),
                                        ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    ProjectPerson(),
                                    Spacer(),
                                    Row(
                                      children: List.generate(
                                        widget.projectModel!.members.length,
                                        (index) => ProjectPerson(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.projectModel!.name,
                              style: TextStyles.f32Bold,
                            ),
                            verticalSpace(8),
                            widget.projectModel?.description == null
                                ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Add Description',
                                            style: TextStyles.f24Bold,
                                            textAlign: TextAlign.center,
                                          ),
                                          content: CustomTextField(
                                            text: 'Description',
                                            controller:
                                                projectCubit
                                                    .descriptionController,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorManager.error,
                                              ),
                                              onPressed: () {
                                                pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyles
                                                    .f16SemiBoldWhite
                                                    .copyWith(
                                                      color: ColorManager.white,
                                                    ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorManager.primary,
                                              ),
                                              onPressed: () {
                                                projectCubit.editDescription(
                                                  widget.projectModel!.id,
                                                  projectCubit
                                                      .descriptionController
                                                      .text,
                                                );
                                                pop();
                                              },
                                              child: Text(
                                                'Add',
                                                style: TextStyles
                                                    .f16SemiBoldWhite
                                                    .copyWith(
                                                      color: ColorManager.white,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Add Description',
                                    style: TextStyles.f16Regular.copyWith(
                                      color: ColorManager.grey,
                                    ),
                                  ),
                                )
                                : Text(
                                  widget.projectModel!.description!,
                                  style: TextStyles.f16Regular,
                                ),
                            verticalSpace(12),
                            widget.projectModel?.deadline == null
                                ? OutLineBtn(
                                  color: ColorManager.primary,
                                  text: 'Set Deadline Project',
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            title: Text(
                                              'Set Deadline Project',
                                              style: TextStyles.f24Bold,
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomTextField(
                                                  text: 'Deadline Date',

                                                  onTap: () {
                                                    defaultBottomSheet(
                                                      context,
                                                      title: 'Select Due Date',
                                                      child: Column(
                                                        children: [
                                                          CalendarPage(
                                                            onDateSelected: (
                                                              p0,
                                                            ) {
                                                              projectCubit
                                                                  .selectedDeadline = p0;
                                                              print(
                                                                projectCubit
                                                                    .selectedDeadline,
                                                              );
                                                            },
                                                          ),
                                                          verticalSpace(36),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  readOnly: true,
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12.0,
                                                        ),
                                                    child: SvgIcon(
                                                      icon: AppIcons.iconsDate,
                                                    ),
                                                  ),
                                                ),
                                                verticalSpace(24),
                                                CustomTextField(
                                                  text: 'Time',

                                                  onTap: () async {
                                                    await defaultBottomSheet(
                                                      context,
                                                      title: 'Due Date',
                                                      child: Column(
                                                        children: [
                                                          HourPickerPage(
                                                            onHourSelected: (
                                                              date,
                                                            ) {
                                                              projectCubit
                                                                      .selectedTime =
                                                                  date;
                                                              print(
                                                                projectCubit
                                                                    .selectedTime,
                                                              );
                                                            },
                                                          ),
                                                          verticalSpace(36),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  readOnly: true,
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12.0,
                                                        ),
                                                    child: SvgIcon(
                                                      icon: AppIcons.time,
                                                    ),
                                                  ),
                                                ),
                                                verticalSpace(24),
                                                CustomBtn(
                                                  text: 'Set Deadline',
                                                  onPressed: () {
                                                    projectCubit
                                                        .addDeadlineProject(
                                                          widget
                                                              .projectModel!
                                                              .id,
                                                        );
                                                    widget
                                                        .projectModel!
                                                        .deadline = projectCubit
                                                            .selectedDeadline;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                    );
                                  },
                                )
                                : SizedBox(),
                            // change this beacouse i am not set deadline or progress
                            widget.projectModel?.deadline == null
                                ? SizedBox()
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FinshedBtn(project: widget.projectModel),
                                    SliderWidget(project: widget.projectModel),
                                  ],
                                ),
                          ],
                        ),
                      ),
                      verticalSpace(24),
                      BoardList(
                        projectId: widget.projectModel!.id,
                        projectModel: widget.projectModel!,
                      ),
                    ],
                  ),
                ),
                if (_moreSelected)
                  Positioned(
                    right: 24.w,
                    top: 105.h,
                    child: ProjectMenuItem(
                      onCoverImageSelected: (file) {
                        setState(() {
                          coverImageFile = file;
                        });
                      },
                      projectId: widget.projectModel!.id,
                    ),
                  ),
              ],
            ),
          );
        },
      ),

      floatingActionButton:
          widget.projectModel?.ownerId != FirebaseAuth.instance.currentUser!.uid
              ? null
              : BlocConsumer<ProjectCubit, ProjectState>(
                listener: (context, state) {
                  if (state is AddBoardSuccess) {
                    pop();
                    context.read<ProjectCubit>().getBoard(
                      widget.projectModel!.id,
                    );
                  }
                },
                builder: (context, state) {
                  final projectCubit = context.read<ProjectCubit>();
                  if (state is AddBoardFailure) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.red),
                      ),
                    );
                  }
                  return FloatingActionButton(
                    backgroundColor: ColorManager.primary,
                    shape: CircleBorder(
                      side: BorderSide(color: ColorManager.primary),
                    ),
                    onPressed: () {
                      defaultBottomSheet(
                        context,
                        title: 'Add New Board',
                        child: Form(
                          key: projectCubit.formkeyBoard,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: projectCubit.boardNameController,
                                validator: (p) => Validator.role(p),

                                text: 'Board Name',
                              ),
                              verticalSpace(24),
                              CustomBtn(
                                text: 'Create New Board',
                                onPressed: () {
                                  if (projectCubit.formkeyBoard.currentState!
                                      .validate()) {
                                    BoardModel board = BoardModel(
                                      id: Uuid().v4(),
                                      title:
                                          projectCubit.boardNameController.text,
                                      projectId: widget.projectModel!.id,
                                      createdAt: DateTime.now(),
                                    );
                                    projectCubit.addBoard(board: [board]);
                                  }
                                },
                                color: ColorManager.secondary,
                              ),
                              verticalSpace(36),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 24.sp,
                      color: ColorManager.white,
                    ),
                  );
                },
              ),
    );
  }
}
