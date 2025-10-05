import 'package:flutter/material.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/model/body/task_model.dart';

class DetailItemHeader extends StatelessWidget {
  final TaskModel? taskModel;
  const DetailItemHeader({super.key, this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(taskModel!.title!, style: TextStyles.f22SemiBold),
            SvgIcon(icon: AppIcons.iconsMore),
          ],
        ),
        verticalSpace(18),
        Text(taskModel!.description!, style: TextStyles.f14Regular),
      ],
    );
  }
}
