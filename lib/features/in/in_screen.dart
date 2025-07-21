import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/or_widget.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/features/login/login_screen.dart';
import 'package:taska/features/sign_up/sign_up_screen.dart';

class InScreen extends StatelessWidget {
  const InScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              verticalSpace(153),
              Text('Let‘s you in ', style: TextStyles.f40SemiBold),
              verticalSpace(95),
              OutLineBtn(
                onPressed: () {},
                text: 'Sign in with Google',
                icon: AppImages.google,
              ),
              verticalSpace(24),
              OutLineBtn(
                onPressed: () {},
                text: 'Sign in with Apple',
                icon: AppImages.apple,
              ),
              verticalSpace(24),
              OutLineBtn(
                onPressed: () {},
                text: 'Sign in with Facebook',
                icon: AppImages.facebook,
              ),
              verticalSpace(24),
              OrWidget(),
              verticalSpace(24),
              CustomBtn(
                onPressed: () {
                  push(const LoginScreen());
                },
                text: 'Sign in with password',
              ),
              verticalSpace(48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account? ', style: TextStyles.f16Regular),
                  GestureDetector(
                    onTap: () {
                      push(SignUpScreen());
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
