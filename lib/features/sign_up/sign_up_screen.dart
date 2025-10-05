import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/or_widget.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/login/login_screen.dart';
import 'package:taska/features/login/widgets/social_widget.dart';
import 'package:taska/features/sign_up/widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(41),
                GestureDetector(
                  onTap: () {
                    pop();
                  },
                  child: SvgIcon(icon: AppIcons.iconsArrowBack),
                ),
                verticalSpace(41),
                Text('Create your\n Account', style: TextStyles.f40SemiBold),
                verticalSpace(81),
                SignUpForm(),
                verticalSpace(24),
                OrWidget(),

                verticalSpace(24),
                Row(
                  children: [
                    SocialWidget(image: AppImages.google),
                    horizontalSpace(16),
                    SocialWidget(image: AppImages.apple),
                    horizontalSpace(16),
                    SocialWidget(image: AppImages.facebook),
                  ],
                ),
                verticalSpace(48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyles.f14Regular,
                    ),
                    GestureDetector(
                      onTap: () {
                        push(LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyles.f16SemiBoldBlack.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
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
