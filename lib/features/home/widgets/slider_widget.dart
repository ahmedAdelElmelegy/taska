import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/project_model.dart';

class SliderWidget extends StatefulWidget {
  final ProjectModel? project;

  const SliderWidget({super.key, this.project});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    final projectCubit = context.read<ProjectCubit>();
    projectCubit.getTasksForProject(widget.project?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        final tasks = cubit.tasksByProject[widget.project?.id ?? ''] ?? [];
        final total = tasks.length;
        final completed = tasks.where((t) => t.isCompleted ?? false).length;

        // update only if not interacted manually
        if (_progress == 0 && total > 0) {
          _progress = (completed / total) * 100;
        }

        return Slider(value: _progress, max: 100, onChanged: (value) {});
      },
    );
  }
}
