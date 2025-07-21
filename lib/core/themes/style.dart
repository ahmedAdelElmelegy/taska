import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

abstract class TextStyles {
  static const String fontFamily = 'Urbanist';

  static TextStyle f33Bold = TextStyle(
    fontSize: 33.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
    fontFamily: fontFamily,
  );
  static TextStyle f30SemiBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static TextStyle f32Bold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static TextStyle f16Regular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.hint,
    fontFamily: fontFamily,
  );

  static TextStyle f40SemiBold = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static TextStyle f20SemiBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static TextStyle f18SemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static TextStyle f18Meduim = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: ColorManager.grey,
  );

  static TextStyle f16Medium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle f16SemiBoldBlack = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static TextStyle f16SemiBoldPrimary = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    color: ColorManager.primary,
  );

  static TextStyle f16SemiBoldWhite = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    color: ColorManager.white,
  );

  static TextStyle f22SemiBold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static TextStyle f24Bold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
  static TextStyle f14Regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static TextStyle f14SemiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static TextStyle f14Meduim = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle f12Regulargrey = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.hint,
    fontFamily: fontFamily,
  );

  static TextStyle f12Regular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static TextStyle f10Medium = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.hint,
    fontFamily: fontFamily,
  );
}
