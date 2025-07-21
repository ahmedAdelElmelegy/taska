import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/features/home/widgets/project_item.dart';
import 'package:taska/features/projects/project_detiles_screen.dart';

class ProjectListView extends StatelessWidget {
  final bool isImageView;
  const ProjectListView({super.key, required this.isImageView});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 18.0.h),
            child: GestureDetector(
              onTap: () {
                push(ProjectDetilesScreen());
              },
              child: ProjectItem(isImageView: isImageView),
            ),
          ),
    );
  }
}
