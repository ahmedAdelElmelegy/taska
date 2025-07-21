import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/home/widgets/project_list_view.dart';
import 'package:taska/features/home/widgets/row_of_home.dart';
import 'package:taska/features/projects/project_screen.dart';
import 'package:taska/features/projects/widgets/project_search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String value = '';
  bool isSearched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(40),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon(
                      icon: AppIcons.iconsSearch,
                      width: 24.w,
                      height: 24.h,
                      color: ColorManager.primary,
                    ),
                  ),

                  text: 'Search',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon(
                      icon: AppIcons.iconsFilter,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                verticalSpace(24),
                ProjectCategory(),
                verticalSpace(48),
                value.isEmpty
                    ? Column(
                      children: [
                        RowOfHome(
                          text: 'Search Result',
                          subText: '23 founds',
                          onPress: () {},
                        ),
                        verticalSpace(24),
                        ProjectListView(isImageView: false),
                      ],
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent', style: TextStyles.f18SemiBold),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ProjectSearchItem(),

                          itemCount: 5,
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
