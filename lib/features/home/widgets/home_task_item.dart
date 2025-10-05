import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/features/home/widgets/task_check_box.dart';

class HomeTaskItem extends StatefulWidget {
  final TaskModel taskModel;
  const HomeTaskItem({super.key, required this.taskModel});

  @override
  State<HomeTaskItem> createState() => _HomeTaskItemState();
}

class _HomeTaskItemState extends State<HomeTaskItem> {
  @override
  Widget build(BuildContext context) {
    final formate = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.parse(widget.taskModel.dueDate!.toString()));
    return Container(
      padding: EdgeInsets.all(24.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 5 / 100),
            blurRadius: 50,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskModel.title!, style: TextStyles.f18SemiBold),
              Text(
                formate == DateTime.now().toIso8601String().split('T')[0]
                    ? 'Today'
                    : formate,
                style: TextStyles.f14Regular.copyWith(color: ColorManager.grey),
              ),
            ],
          ),

          TaskCheckBox(
            onChanged: (value) {
              context.read<ProjectCubit>().updateTaskStatus(
                widget.taskModel.id!,
                value!,
              );
              widget.taskModel.isCompleted = value;
            },
            isActive: widget.taskModel.isCompleted!,
          ),
        ],
      ),
    );
  }
}
