import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/features/home/widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 18.0.h),
            child: TaskItem(),
          ),
    );
  }
}
