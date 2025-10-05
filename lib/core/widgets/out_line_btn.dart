import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class OutLineBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String? icon;
  final Color? color;
  const OutLineBtn({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color ?? ColorManager.grey),
        minimumSize: Size(double.infinity, 50.h),
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          icon != null
              ? Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(icon!),
              )
              : const SizedBox.shrink(),

          Text(
            text,
            style: TextStyles.f14SemiBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PrimaryOutLineBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String? icon;
  final double? height;
  final double? width;

  const PrimaryOutLineBtn({
    super.key,
    this.onPressed,
    required this.text,
    this.icon,
    this.width,

    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorManager.primary),
        minimumSize: Size(width ?? double.infinity, height ?? 33.h),
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          icon != null
              ? Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(icon!),
              )
              : const SizedBox.shrink(),

          Text(
            text,
            style: TextStyles.f16SemiBoldPrimary,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
