import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/model/body/sub_task_model.dart';

class SubTaskItem extends StatelessWidget {
  final SubTaskModel item;
  final Widget trailing;
  const SubTaskItem({super.key, required this.item, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(
          icon: item.icon,
          color: ColorManager.grey,
          width: 24.w,
          height: 24.h,
        ),
        horizontalSpace(4),
        Text(
          item.title,
          style: TextStyles.f14SemiBold.copyWith(color: ColorManager.grey),
        ),

        trailing,
      ],
    );
  }
}
