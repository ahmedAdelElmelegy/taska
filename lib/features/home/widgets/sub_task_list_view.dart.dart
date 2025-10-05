import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/sub_tasks_model.dart';
import 'package:taska/features/home/widgets/sub_task_item.dart';

class SubTaskListView extends StatefulWidget {
  final String? taskId;
  const SubTaskListView({super.key, this.taskId});

  @override
  State<SubTaskListView> createState() => _SubTaskListViewState();
}

class _SubTaskListViewState extends State<SubTaskListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProjectCubit>().getSubTask(widget.taskId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final projectCubit = context.read<ProjectCubit>();
        List<SubTasksModel> subtasks = projectCubit.getSubTaskForTask(
          widget.taskId!,
        );
        if (state is GetSubTaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetSubTaskFailure) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
          );
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: subtasks.length,
          itemBuilder:
              (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 18.0.h),
                child: SubTaskItem(subTasksModel: subtasks[index]),
              ),
        );
      },
    );
  }
}
