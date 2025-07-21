import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

class SocialWidget extends StatelessWidget {
  final String image;
  const SocialWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: ColorManager.light),
          minimumSize: Size(double.infinity, 55.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),

        onPressed: () {},
        child: Image.asset(image),
      ),
    );
  }
}
