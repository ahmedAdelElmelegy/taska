import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/project_model.dart';

import '../../../core/helper/app_constants.dart';
import '../../../core/themes/colors.dart';
import '../../../core/widgets/svg_icon.dart' show SvgIcon;

class ProjectSearchItem extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectSearchItem({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name, style: TextStyles.f18Meduim),
          SvgIcon(icon: AppIcons.iconsClear, color: ColorManager.grey),
        ],
      ),
    );
  }
}
