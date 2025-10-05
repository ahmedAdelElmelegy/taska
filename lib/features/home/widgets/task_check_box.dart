import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

class TaskCheckBox extends StatefulWidget {
  final void Function(bool? value)? onChanged;
  final bool? isActive;

  const TaskCheckBox({super.key, this.onChanged, this.isActive});

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  @override
  void initState() {
    super.initState();
    isChecked = widget.isActive ?? false;
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.w,
      height: 24.h,
      child: Checkbox(
        checkColor: ColorManager.white,
        activeColor: ColorManager.primary,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
            widget.onChanged!(value);
          });
        },
      ),
    );
  }
}
