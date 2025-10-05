import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/project_model.dart';

class FinshedBtn extends StatefulWidget {
  final ProjectModel? project;

  const FinshedBtn({super.key, this.project});

  @override
  State<FinshedBtn> createState() => _FinshedBtnState();
}

class _FinshedBtnState extends State<FinshedBtn> {
  @override
  void initState() {
    super.initState();
    final projectCubit = context.read<ProjectCubit>();
    projectCubit.getTasksForProject(widget.project?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final tasks = projectCubit.tasksByProject[widget.project?.id ?? ''] ?? [];
    final total = tasks.length;
    final completed = tasks.where((t) => t.isCompleted ?? false).length;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000.r),
        gradient: LinearGradient(
          colors: [
            ColorManager.white,
            Color(widget.project?.color ?? ColorManager.primary.value),
            Color(widget.project?.color ?? ColorManager.primary.value),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Text(
        '$completed/$total',
        style: TextStyles.f14Regular.copyWith(color: Colors.white),
      ),
    );
  }
}
