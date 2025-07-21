import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

class VerticalDiv extends StatelessWidget {
  const VerticalDiv({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 2.w, height: 60.h, color: ColorManager.lightGrey);
  }
}
