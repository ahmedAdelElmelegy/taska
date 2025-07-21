import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/style.dart';

import '../../../core/helper/app_constants.dart';
import '../../../core/themes/colors.dart';
import '../../../core/widgets/svg_icon.dart' show SvgIcon;

class ProjectSearchItem extends StatelessWidget {
  const ProjectSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('NFT Project App', style: TextStyles.f18Meduim),
          SvgIcon(icon: AppIcons.iconsClear, color: ColorManager.grey),
        ],
      ),
    );
  }
}
