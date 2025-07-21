import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final double? height;
  final double? width;
  final Color? color;
  const SvgIcon({
    super.key,
    required this.icon,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height ?? 28.h,
      width: width ?? 28.w,
      // ignore: deprecated_member_use
      color: color ?? Colors.black,
    );
  }
}
