import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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

import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/core/widgets/time_picker_page.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/sub_tasks_model.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/features/home/widgets/row_of_home.dart';
import 'package:taska/features/home/widgets/sub_task_list_view.dart.dart';
import 'package:taska/features/sub_task/widgets/comment_navgation_bar.dart';
import 'package:taska/features/sub_task/widgets/comment_section.dart';
import 'package:taska/features/sub_task/widgets/task_detials_content.dart';
import 'package:uuid/uuid.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel taskModel;
  const TaskDetailsScreen({super.key, required this.taskModel});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).getComments(widget.taskModel.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: BlocBuilder<ProjectCubit, ProjectState>(
              builder: (context, state) {
                final projectCubit = context.read<ProjectCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(40),
                    Row(
                      children: [
                        TextPop(text: widget.taskModel.title!),
                        Spacer(),
                        SvgIcon(icon: AppIcons.star, color: Colors.amber),
                        horizontalSpace(12),
                        SvgIcon(icon: AppIcons.iconsMore),
                      ],
                    ),
                    verticalSpace(24),
                    widget.taskModel.coverImage == null
                        ? Container()
                        : Container(
                          width: double.infinity,
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: NetworkImage(widget.taskModel.coverImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    verticalSpace(24),
                    Text(
                      widget.taskModel.description!,
                      style: TextStyles.f16Regular,
                    ),
                    verticalSpace(36),
                    TaskDetialsContent(taskModel: widget.taskModel),
                    verticalSpace(24),
                    RowOfHome(text: 'Sub-Task (14)'),
                    verticalSpace(24),
                    SubTaskListView(taskId: widget.taskModel.id),
                    verticalSpace(24),
                    widget.taskModel.projectLeader!.uid !=
                            auth.currentUser!.uid
                        ? CustomBtn(
                          onPressed: () {},
                          text: 'Expand More',
                          color: ColorManager.lightBlue,
                          textColor: ColorManager.primary,
                        )
                        : CustomBtn(
                          text: 'Add New Sub-Task',
                          onPressed: () {
                            defaultBottomSheet(
                              context,
                              title: 'Add New Sub-Task',
                              child: Form(
                                key: projectCubit.formKeySubTask,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      validator: (p0) => Validator.role(p0),
                                      controller:
                                          projectCubit.subtaskNameController,
                                      text: 'Sub-Task Name',
                                    ),
                                    verticalSpace(24),
                                    CustomTextField(
                                      validator: (p0) => Validator.role(p0),
                                      readOnly: true,
                                      onTap: () async {
                                        await defaultBottomSheet(
                                          context,
                                          title: 'Due Date',
                                          child: Column(
                                            children: [
                                              CalendarPage(
                                                onDateSelected: (date) {
                                                  setState(() {
                                                    projectCubit
                                                        .subtaskDueDateController
                                                        .text = DateFormat(
                                                      'MMMM dd,yyyy',
                                                    ).format(date);
                                                  });
                                                },
                                              ),
                                              verticalSpace(36),
                                            ],
                                          ),
                                        );
                                      },
                                      controller:
                                          projectCubit.subtaskDueDateController,
                                      text: 'Due Date',
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgIcon(
                                          icon: AppIcons.iconsDate,
                                        ),
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
                                                    projectCubit
                                                            .dueTimeController
                                                            .text =
                                                        '${date.hour}:${date.minute} ${date.period == DayPeriod.am ? 'AM' : 'PM'} ';
                                                  });
                                                },
                                              ),
                                              verticalSpace(36),
                                            ],
                                          ),
                                        );
                                      },

                                      validator: (p0) => Validator.role(p0),
                                      readOnly: true,
                                      text: 'Time',
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgIcon(icon: AppIcons.time),
                                      ),
                                    ),
                                    verticalSpace(24),
                                    CustomBtn(
                                      color:
                                          state is AddSubTaskLoading
                                              ? ColorManager.primary
                                              : ColorManager.secondary,
                                      text: 'Add New Sub-Task',
                                      onPressed: () {
                                        if (projectCubit
                                            .formKeySubTask
                                            .currentState!
                                            .validate()) {
                                          SubTasksModel
                                          subtaskModel = SubTasksModel(
                                            id: Uuid().v4(),
                                            subTaskName:
                                                projectCubit
                                                    .subtaskNameController
                                                    .text,
                                            dueDate:
                                                projectCubit
                                                    .subtaskDueDateController
                                                    .text,

                                            time:
                                                projectCubit
                                                    .subtaskDueTimeController
                                                    .text,

                                            status: false,
                                            taskId: widget.taskModel.id!,
                                          );
                                          projectCubit.addSubTask(
                                            subtaskModel: [subtaskModel],
                                          );
                                        }
                                        pop();
                                      },
                                    ),
                                    verticalSpace(36),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    verticalSpace(24),
                    CommentSection(taskId: widget.taskModel.id!),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomSheet: CommentNavgationBar(taskModel: widget.taskModel),
    );
  }
}
