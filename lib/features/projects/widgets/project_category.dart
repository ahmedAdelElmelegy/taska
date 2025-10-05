import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/projects/widgets/project_btn.dart';

class ProjectCategory extends StatelessWidget {
  const ProjectCategory({super.key});

  static Map<ProjectCat, String> projectMap = {
    ProjectCat.todo: 'To-Do',
    ProjectCat.inProgress: 'In-Progress',
    ProjectCat.completed: 'Completed',
    ProjectCat.archived: 'Archived',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final project = BlocProvider.of<ProjectCubit>(context);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              projectMap.length,
              (index) => GestureDetector(
                onTap: () {
                  project.changeCategory(projectMap.keys.elementAt(index));
                },
                child: ProjectBtn(
                  title: projectMap.values.elementAt(index),
                  isActive:
                      project.selectCategory ==
                      projectMap.keys.elementAt(index),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
