import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/features/home/widgets/task_check_box.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

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
              Text('Kickoff Meeting Project', style: TextStyles.f18SemiBold),
              Text(
                'Today - 13.00 PM',
                style: TextStyles.f14Regular.copyWith(color: ColorManager.grey),
              ),
            ],
          ),

          TaskCheckBox(),
        ],
      ),
    );
  }
}
