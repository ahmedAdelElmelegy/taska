import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/chat/widget/group_list_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(16),
                Row(
                  children: [
                    Image.asset(AppImages.logo2, height: 24.h, width: 24.w),
                    horizontalSpace(16),
                    Text('Inbox', style: TextStyles.f22SemiBold),
                    Spacer(),
                    SvgIcon(icon: AppIcons.iconsMore),
                  ],
                ),
                verticalSpace(16),
                GroupListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
