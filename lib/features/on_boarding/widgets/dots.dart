import 'package:flutter/material.dart';
import 'package:taska/core/themes/colors.dart';

class Dots extends StatelessWidget {
  final bool isActive;
  const Dots({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(radius: 4, backgroundColor: ColorManager.primary)
        : CircleAvatar(radius: 4, backgroundColor: ColorManager.lightGrey);
  }
}
