import 'package:flutter/material.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/features/in/in_screen.dart';
import 'package:taska/features/on_boarding/widgets/on_boarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,

          itemBuilder:
              (context, index) => OnBoardingItem(
                currentIndex: index,
                onPressed: () {
                  if (index < 2) {
                    pageController.animateToPage(
                      index + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    pushAndRemoveUntil(InScreen());
                  }
                },
              ),
          itemCount: 3,
        ),
      ),
    );
  }
}
