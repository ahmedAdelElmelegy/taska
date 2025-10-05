import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class StatusItem extends StatelessWidget {
  final String title;
  final bool isActive;

  const StatusItem({super.key, required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: TextStyles.f20SemiBold),
        const Spacer(),
        CircleAvatar(
          radius: 12.r,
          backgroundColor: ColorManager.primary,
          child:
              isActive
                  ? CircleAvatar(
                    radius: 9.r,
                    backgroundColor: ColorManager.white,
                    child: CircleAvatar(
                      radius: 6.r,
                      backgroundColor: ColorManager.primary,
                    ),
                  )
                  : CircleAvatar(
                    radius: 9.r,
                    backgroundColor: ColorManager.white,
                  ),
        ),
      ],
    );
  }
}
