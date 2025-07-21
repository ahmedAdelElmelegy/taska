import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/home/widgets/task_list_view.dart';

class TodayTask extends StatelessWidget {
  const TodayTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(40),
                Row(
                  children: [
                    TextPop(text: 'Today Task'),
                    Spacer(),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(24),
                TaskListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
