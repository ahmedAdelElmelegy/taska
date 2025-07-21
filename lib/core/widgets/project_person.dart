import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/themes/colors.dart';

class ProjectPerson extends StatelessWidget {
  const ProjectPerson({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15.r,
      backgroundColor: ColorManager.white,
      child: CircleAvatar(
        radius: 13.r,
        backgroundImage: AssetImage(AppImages.profile),
      ),
    );
  }
}
