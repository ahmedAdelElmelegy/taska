import 'package:flutter/material.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class DetailItemHeader extends StatelessWidget {
  const DetailItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Build Wireframe', style: TextStyles.f22SemiBold),
            SvgIcon(icon: AppIcons.iconsMore),
          ],
        ),
        verticalSpace(18),
        Text('Due date: Dec 14, 2024', style: TextStyles.f14Regular),
      ],
    );
  }
}
