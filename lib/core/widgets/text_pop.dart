import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';

class TextPop extends StatelessWidget {
  final String text;
  final bool? isBack;
  const TextPop({super.key, required this.text, this.isBack = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isBack == true)
          GestureDetector(
            onTap: () {
              pop();
            },
            child: SvgIcon(
              icon: AppIcons.iconsArrowBack,
              width: 24.w,
              height: 24.h,
            ),
          ),
        horizontalSpace(10),
        Text(text, style: TextStyles.f24Bold),
      ],
    );
  }
}
