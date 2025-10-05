import 'package:taska/core/helper/spacing.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/features/projects/widgets/task_item.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key, required this.boardModel});

  final BoardModel boardModel;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectCubit>().getTask(widget.boardModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is GetTasksLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetTasksFailure) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is GetTasksSuccess) {
          final tasks = state.tasks;

          if (tasks.isEmpty) {
            return const Center(child: Text("No tasks found"));
          }

          return Column(
            children: [
              verticalSpace(50),
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                    transform: index == tasks.length - 1,
                  );
                },
              ),
            ],
          );
        }

        // الحالة الافتراضية
        return const SizedBox();
      },
    );
  }
}
