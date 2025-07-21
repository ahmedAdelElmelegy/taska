import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/or_widget.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/home/home_screen.dart';
import 'package:taska/features/login/widgets/social_widget.dart';
import 'package:taska/features/sign_up/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(41),
              SvgIcon(icon: AppIcons.iconsArrowBack),
              verticalSpace(41),
              Text('Login to your Account', style: TextStyles.f40SemiBold),
              verticalSpace(81),
              CustomTextField(
                text: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: ColorManager.grey),
              ),
              verticalSpace(24),
              CustomTextField(
                text: 'Password',
                keyboardType: TextInputType.emailAddress,
                suffixIcon: Icon(Icons.visibility, color: ColorManager.grey),
                prefixIcon: Icon(Icons.lock, color: ColorManager.grey),
              ),
              verticalSpace(48),
              CustomBtn(
                color: ColorManager.secondary,
                text: 'Login',
                onPressed: () {
                  push(HomeScreen());
                },
              ),
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
                  Text('Don’t have an account? ', style: TextStyles.f14Regular),
                  GestureDetector(
                    onTap: () {
                      push(const SignUpScreen());
                    },
                    child: Text(
                      'Sign up',
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
    );
  }
}
