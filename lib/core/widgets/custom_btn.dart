import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? child;

  const CustomBtn({
    super.key,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color ?? ColorManager.primary,
        minimumSize: Size(width ?? double.infinity, height ?? 55.h),
      ),

      onPressed: onPressed,
      child:
          child ??
          Text(
            text ?? '',
            style: TextStyles.f16SemiBoldWhite.copyWith(
              color: textColor ?? Colors.white,
            ),
          ),
    );
  }
}
