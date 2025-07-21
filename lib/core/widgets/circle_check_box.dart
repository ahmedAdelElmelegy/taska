import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

class CircleCheckBox extends StatelessWidget {
  final bool? isActive;
  const CircleCheckBox({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return isActive == true
        ? CircleAvatar(
          radius: 12.r,
          backgroundColor: ColorManager.primary,
          child: CircleAvatar(radius: 9.r, backgroundColor: ColorManager.white),
        )
        : CircleAvatar(
          radius: 12.r,
          backgroundColor: ColorManager.primary,
          child: CircleAvatar(
            radius: 9.r,
            backgroundColor: ColorManager.white,
            child: CircleAvatar(
              radius: 6.r,
              backgroundColor: ColorManager.primary,
            ),
          ),
        );
  }
}
