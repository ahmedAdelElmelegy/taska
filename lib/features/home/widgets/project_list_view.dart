import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/home/widgets/project_item.dart';
import 'package:taska/features/projects/project_detiles_screen.dart';

class ProjectListView extends StatelessWidget {
  final bool isImageView;

  final List<ProjectModel>? projects;
  const ProjectListView({super.key, required this.isImageView, this.projects});

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.watch<ProjectCubit>();

    List<ProjectModel> displayProjects = projects ?? projectCubit.filterProject;

    // Filter based on `isImageView`
    displayProjects =
        isImageView
            ? displayProjects.where((p) => p.coverImage != null).toList()
            : displayProjects.where((p) => p.coverImage == null).toList();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: displayProjects.length,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 18.0.h),
            child: GestureDetector(
              onTap: () {
                push(
                  ProjectDetilesScreen(projectModel: displayProjects[index]),
                );
              },
              child: ProjectItem(
                isImageView: isImageView,
                project: displayProjects[index],
              ),
            ),
          ),
    );
  }
}
