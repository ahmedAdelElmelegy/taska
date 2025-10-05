import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:taska/core/widgets/custom_dropdown.dart';
import 'package:taska/core/widgets/custom_loading.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/multiple_selected_widget.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/core/widgets/time_picker_page.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/features/projects/widgets/add_cover_task.dart';
import 'package:uuid/uuid.dart';

class AddNewTask extends StatefulWidget {
  final BoardModel boardModel;
  final ProjectModel projectModel;
  const AddNewTask({
    super.key,
    required this.boardModel,
    required this.projectModel,
  });

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  XFile? selectedImage;
  File? selectedFile;
  List<File> additionalFiles = [];

  @override
  Widget build(BuildContext context) {
    final projectCubit = BlocProvider.of<ProjectCubit>(context);
    final authcubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProjectCubit, ProjectState>(
          listener: (context, state) {
            if (state is AddTaskSuccess) {
              pop();
              BlocProvider.of<ProjectCubit>(
                context,
              ).getBoard(widget.projectModel.id);
            }
          },
          builder: (context, state) {
            if (state is AddTaskFailure) {
              return Center(child: Text(state.message));
            }
            return SingleChildScrollView(
              child: CustomLoadingOverlay(
                isLoading: state is AddTaskLoading,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: projectCubit.formKeyTask,
                    child: Column(
                      children: [
                        verticalSpace(40),
                        TextPop(text: 'Add New Task'),
                        verticalSpace(24),
                        GestureDetector(
                          onTap: () {
                            defaultBottomSheet(
                              context,
                              title: 'Add Cover',
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                              backgroundColor:
                                                  ColorManager.primaryDark,
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
                                              style:
                                                  TextStyles.f16SemiBoldBlack,
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
                                              backgroundColor:
                                                  ColorManager.primaryDark,
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
                                              style:
                                                  TextStyles.f16SemiBoldBlack,
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
                          child: AddCoverTask(image: selectedImage),
                        ),
                        verticalSpace(24),
                        CustomTextField(
                          text: 'Task Title',
                          controller: projectCubit.taskNameController,
                          validator: (p0) => Validator.role(p0),
                        ),
                        verticalSpace(24),
                        CustomTextField(
                          text: 'Description',
                          controller: projectCubit.taskDescriptionController,
                          validator: (p0) => Validator.role(p0),
                        ),
                        verticalSpace(24),
                        CustomDropDown(
                          onItemSelected: (p0) {
                            projectCubit.projectLeader = p0;
                          },
                          hint: 'Select Project Leader',
                          users: widget.projectModel.members,
                        ),
                        verticalSpace(24),
                        MultiSelectMembers(
                          users: widget.projectModel.members,
                          onConfirm: (p0) => projectCubit.teamMember.addAll(p0),
                        ),

                        verticalSpace(24),
                        CustomTextField(
                          controller: projectCubit.dueDateController,
                          onTap: () {
                            defaultBottomSheet(
                              context,
                              title: 'Select Due Date',
                              child: Column(
                                children: [
                                  CalendarPage(
                                    onDateSelected: (p0) {
                                      projectCubit.dueDateController.text =
                                          p0.day == DateTime.now().day
                                              ? 'Today'
                                              : p0.day ==
                                                  DateTime.now()
                                                      .add(Duration(days: 1))
                                                      .day
                                              ? 'Tomorrow'
                                              : "${p0.month}/${p0.day}/${p0.year}";

                                      // خزّن القيمة الحقيقية هنا
                                      projectCubit.selectedDueDate = p0;
                                    },
                                  ),
                                  verticalSpace(36),
                                ],
                              ),
                            );
                          },
                          readOnly: true,
                          text: 'Due Date',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgIcon(icon: AppIcons.iconsDate),
                          ),
                        ),
                        verticalSpace(24),
                        CustomTextField(
                          onTap: () async {
                            await defaultBottomSheet(
                              context,
                              title: 'Due Date',
                              child: Column(
                                children: [
                                  HourPickerPage(
                                    onHourSelected: (date) {
                                      setState(() {
                                        projectCubit.dueTimeController.text =
                                            '${date.hour}:${date.minute} ${date.period == DayPeriod.am ? 'AM' : 'PM'} ';
                                      });
                                    },
                                  ),
                                  verticalSpace(36),
                                ],
                              ),
                            );
                          },

                          controller: projectCubit.dueTimeController,
                          validator: (p0) => Validator.role(p0),
                          readOnly: true,
                          text: 'Time',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgIcon(icon: AppIcons.time),
                          ),
                        ),
                        verticalSpace(24),
                        CustomTextField(
                          // validator: (p0) => Validator.role(p0),
                          onTap: () {
                            selectFile();
                          },
                          readOnly: true,

                          text:
                              selectedFile != null
                                  ? selectedFile!.path.split('/').last
                                  : 'Attachment',
                          // controller: projectCubit.attachmentController,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgIcon(icon: AppIcons.iconsProject),
                          ),
                        ),
                        verticalSpace(24),

                        verticalSpace(24),
                        CustomBtn(
                          text: 'Add New Task',
                          onPressed: () {
                            if (selectedImage == null &&
                                selectedFile == null &&
                                projectCubit.teamMember.isEmpty &&
                                projectCubit.projectLeader == null) {
                              Fluttertoast.showToast(
                                msg: "Please select image or file",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            } else {
                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              if (projectCubit.formKeyTask.currentState!
                                  .validate()) {
                                TaskModel taskModel = TaskModel(
                                  memberIds: [
                                    uid,
                                    ...projectCubit.teamMember.map(
                                      (e) => e.uid,
                                    ),
                                  ],
                                  coverImage:
                                      selectedImage!.path.split('/').last,
                                  status: 'To-Do',
                                  id: Uuid().v4(),
                                  title: projectCubit.taskNameController.text,
                                  ownerId: uid,
                                  description:
                                      projectCubit
                                          .taskDescriptionController
                                          .text,
                                  dueDate: projectCubit.selectedDueDate!,
                                  dueTime: projectCubit.dueTimeController.text,
                                  boardId: widget.boardModel.id,
                                  projectLeader: projectCubit.projectLeader!,
                                  teamMember: [
                                    authcubit.user!,
                                    ...projectCubit.teamMember,
                                  ],
                                  attachment:
                                      selectedFile!.path.split('/').last,
                                  projectId: widget.boardModel.projectId,
                                  /*******  d44030d9-ba72-45c5-9d06-acab834a983a  *******/
                                );

                                projectCubit.addTask(
                                  taskModel: [taskModel],
                                  image: File(selectedImage!.path),
                                  file: selectedFile!,
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future selectImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    setState(() {
      selectedImage = image;
    });
  }

  Future<void> selectFile() async {
    final file = await FilePicker.platform.pickFiles();

    if (file != null) {
      setState(() {
        selectedFile = File(file.files.single.path!);
      });
    }
  }
}
