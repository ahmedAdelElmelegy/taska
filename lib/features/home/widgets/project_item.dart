import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/home/widgets/finshed_btn.dart';
import 'package:taska/features/home/widgets/slider_widget.dart';

class ProjectItem extends StatelessWidget {
  final bool isImageView;
  final ProjectModel? project;
  const ProjectItem({super.key, required this.isImageView, this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 5 / 100),
            blurRadius: 50,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          isImageView &&
                  project!.coverImage != null &&
                  project!.coverImage!.isNotEmpty
              ? Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(project!.coverImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
              : Container(),

          isImageView ? verticalSpace(10) : verticalSpace(24),
          Padding(
            padding: EdgeInsets.only(
              right: 24.0.w,
              left: 24.0.w,
              bottom: 24.0.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(project!.name, style: TextStyles.f22SemiBold),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(18),
                FinshedBtn(project: project!),
                project?.deadline != null
                    ? SliderWidget(project: project!)
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
