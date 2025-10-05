import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/home/widgets/project_list_view.dart';
import 'package:taska/features/projects/search_screen.dart';
import 'package:taska/features/projects/widgets/project_category.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool isImageView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPop(text: 'My Project', isBack: false),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            push(SearchScreen());
                          },
                          child: SvgIcon(
                            icon: AppIcons.iconsSearch,
                            color:
                                isImageView
                                    ? ColorManager.grey
                                    : ColorManager.primary,
                          ),
                        ),
                        horizontalSpace(8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isImageView = true;
                            });
                          },
                          child: Icon(
                            Icons.image,
                            color:
                                isImageView
                                    ? ColorManager.primary
                                    : ColorManager.grey,
                            size: 30.sp,
                          ),
                        ),
                        horizontalSpace(8),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              setState(() {});
                              isImageView = false;
                            });
                          },
                          child: SvgIcon(
                            icon: AppIcons.iconsProject,
                            color:
                                isImageView
                                    ? ColorManager.grey
                                    : ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(24),
                ProjectCategory(),

                verticalSpace(24),

                ProjectListView(isImageView: isImageView),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
