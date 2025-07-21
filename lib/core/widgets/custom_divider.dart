import 'package:flutter/material.dart';
import 'package:taska/core/themes/colors.dart';

class CustomDevider extends StatelessWidget {
  const CustomDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1, color: ColorManager.lightGrey);
  }
}
