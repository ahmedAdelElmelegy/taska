import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/sub_tasks_model.dart';
import 'package:taska/features/home/widgets/task_check_box.dart';

class SubTaskItem extends StatefulWidget {
  final SubTasksModel subTasksModel;
  const SubTaskItem({super.key, required this.subTasksModel});

  @override
  State<SubTaskItem> createState() => _SubTaskItemState();
}

class _SubTaskItemState extends State<SubTaskItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
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
              Text(
                widget.subTasksModel.subTaskName,
                style: TextStyles.f18SemiBold,
              ),
              Text(
                widget.subTasksModel.time,
                style: TextStyles.f14Regular.copyWith(color: ColorManager.grey),
              ),
            ],
          ),

          TaskCheckBox(
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
            isActive: widget.subTasksModel.status,
          ),
        ],
      ),
    );
  }
}
