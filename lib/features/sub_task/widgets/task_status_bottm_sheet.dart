import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/utils/constants.dart';
import 'package:taska/features/sub_task/widgets/task_item.dart';

class TaskStatusBottomSheet extends StatefulWidget {
  final String currentStatus;

  const TaskStatusBottomSheet({super.key, required this.currentStatus});

  @override
  State<TaskStatusBottomSheet> createState() => _TaskStatusBottomSheetState();
}

class _TaskStatusBottomSheetState extends State<TaskStatusBottomSheet> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder:
          (context, index) => InkWell(
            onTap: () {
              setState(() {
                selectedStatus = Constants.status[index];
              });

              Future.delayed(Duration(milliseconds: 300), () {
                pop();
              });
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: StatusItem(
                title: Constants.status[index],
                isActive: selectedStatus == Constants.status[index],
              ),
            ),
          ),
      separatorBuilder: (_, __) => Divider(),
      itemCount: Constants.status.length,
    );
  }
}
