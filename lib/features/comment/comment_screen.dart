import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/sub_task/widgets/comment_list_view.dart';
import 'package:taska/features/sub_task/widgets/comment_navgation_bar.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(41),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPop(text: 'Comments (8)'),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(24),
                CommentListView(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CommentNavgationBar(),
    );
  }
}
