import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/home/widgets/project_list_view.dart';
import 'package:taska/features/projects/search_screen.dart';

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
                    TextPop(text: 'My Project'),
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

class ProjectCategory extends StatefulWidget {
  const ProjectCategory({super.key});

  @override
  State<ProjectCategory> createState() => _ProjectCategoryState();
}

class _ProjectCategoryState extends State<ProjectCategory> {
  static List<String> catList = [
    'To-Do',
    'In-Progress',
    'Completed',
    'Messages',
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          catList.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: ProjectBtn(
              title: catList[index],
              isActive: currentIndex == index,
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectBtn extends StatelessWidget {
  final bool? isActive;
  final String title;
  const ProjectBtn({super.key, this.isActive = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive == true ? ColorManager.primary : Colors.transparent,
        border: Border.all(color: ColorManager.primary, width: 2.w),
        borderRadius: BorderRadius.circular(1000.r),
      ),
      child: Text(
        title,
        style: TextStyles.f16SemiBoldWhite.copyWith(
          color: isActive == true ? Colors.white : ColorManager.primary,
        ),
      ),
    );
  }
}
