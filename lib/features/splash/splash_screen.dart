import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/features/on_boarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
    ).then((value) => pushReplacement(OnboardingScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('assets/images/logo.png'),
            verticalSpace(150),
            Lottie.asset('assets/splash.json', height: 120.h, width: 120.w),
          ],
        ),
      ),
    );
  }
}
