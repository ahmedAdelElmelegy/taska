import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';

import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/features/fill_profile/widgets/profile_image.dart';

class FillProfileScreen extends StatelessWidget {
  const FillProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(41),
                TextPop(text: 'Fill your profile'),
                verticalSpace(48),
                ProfileImage(),
                verticalSpace(24),
                CustomTextField(text: 'Full Name'),
                verticalSpace(24),
                CustomTextField(text: 'Username'),
                verticalSpace(24),
                CustomTextField(text: 'Date Of Birth'),
                verticalSpace(24),
                CustomTextField(
                  text: 'Email',
                  suffixIcon: Icon(Icons.email, color: ColorManager.grey),
                ),
                verticalSpace(24),
                CustomTextField(text: 'Phone Number'),
                verticalSpace(24),
                CustomTextField(text: 'Role'),
                verticalSpace(48),
                CustomBtn(onPressed: () {}, text: 'Continue'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
