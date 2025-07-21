import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/home/widgets/finshed_btn.dart';
import 'package:taska/features/home/widgets/slider_widget.dart';
import 'package:taska/features/projects/widgets/project_detailes_item.dart';
import 'package:taska/features/projects/widgets/project_menu_item.dart';

class ProjectDetilesScreen extends StatefulWidget {
  const ProjectDetilesScreen({super.key});

  @override
  State<ProjectDetilesScreen> createState() => _ProjectDetilesScreenState();
}

class _ProjectDetilesScreenState extends State<ProjectDetilesScreen> {
  bool _moreSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _moreSelected = false;
                });
              },
              child: Column(
                children: [
                  Container(
                    height: 240.h,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(24.r),
                      image: DecorationImage(
                        image: AssetImage(AppImages.project),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            verticalSpace(21),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => pop(),
                                  child: SvgIcon(
                                    icon: AppIcons.iconsArrowBack,
                                    color: ColorManager.white,
                                  ),
                                ),
                                Spacer(),
                                SvgIcon(
                                  icon: AppIcons.iconsSearch,
                                  color: Colors.white,
                                ),
                                horizontalSpace(20),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _moreSelected = !_moreSelected;
                                    });
                                  },
                                  child: SvgIcon(
                                    icon: AppIcons.iconsMore,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiki Mobile App Project',
                          style: TextStyles.f32Bold,
                        ),
                        verticalSpace(18),
                        Text(
                          'UI Kit Design Project for Task, Notes ,and Reminder Mobile App -December 20, 2024',
                          style: TextStyles.f16Regular,
                        ),
                        FinshedBtn(),
                        SliderWidget(),
                      ],
                    ),
                  ),
                  verticalSpace(24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: List.generate(
                        10,
                        (index) => ProjectDetailItem(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_moreSelected)
              Positioned(right: 24.w, top: 105.h, child: ProjectMenuItem()),
          ],
        ),
      ),
    );
  }
}
