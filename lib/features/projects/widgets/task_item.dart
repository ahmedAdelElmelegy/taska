import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/widgets/shadow_container.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/features/projects/widgets/detail_item_header.dart';
import 'package:taska/features/projects/widgets/profile_sections.dart';
import 'package:taska/features/sub_task/task_details_screen.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  final bool? transform;
  const TaskItem({super.key, required this.taskModel, this.transform = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(TaskDetailsScreen(taskModel: taskModel));
      },
      child: Transform.rotate(
        angle: transform == true ? -6 : 0,
        child: Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: ShadowContainer(
            child: Column(
              children: [
                DetailItemHeader(taskModel: taskModel),
                verticalSpace(18),
                if (taskModel.coverImage != null)
                  Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(taskModel.coverImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                verticalSpace(24),
                ProfilesSections(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
