import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/features/projects/widgets/detail_item_header.dart';
import 'package:taska/features/projects/widgets/profile_sections.dart';

class ProjectDetailContainer extends StatelessWidget {
  const ProjectDetailContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -6,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 5 / 100),
              blurRadius: 60,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemHeader(),
            verticalSpace(18),
            Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.project),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            verticalSpace(24),
            ProfilesSections(),
          ],
        ),
      ),
    );
  }
}
