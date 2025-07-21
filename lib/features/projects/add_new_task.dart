import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_dropdown.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/projects/widgets/add_cover_task.dart';

class AddNewTask extends StatelessWidget {
  const AddNewTask({super.key});

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
                TextPop(text: 'Add New Task'),
                verticalSpace(24),
                InkWell(onTap: () {}, child: AddCoverTask()),
                verticalSpace(24),
                CustomTextField(text: 'Task Title'),
                verticalSpace(24),
                CustomTextField(text: 'Description'),
                verticalSpace(24),
                CustomDropDown(hint: 'Select Project Leader'),
                verticalSpace(24),
                CustomDropDown(hint: 'Select Project Members'),
                verticalSpace(24),
                CustomTextField(
                  text: 'Due Date',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon(icon: AppIcons.iconsDate),
                  ),
                ),
                verticalSpace(24),
                CustomTextField(
                  text: 'Due Date',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon(icon: AppIcons.iconsProject),
                  ),
                ),
                verticalSpace(24),
                CustomBtn(text: 'Add New Task', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
