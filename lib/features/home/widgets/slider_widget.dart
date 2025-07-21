import 'package:flutter/material.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('8 Days Left', style: TextStyles.f12Regulargrey),
        Slider(
          activeColor: ColorManager.primary,

          value: 80,
          onChanged: (value) {},
          max: 100,
          min: 0,
        ),
      ],
    );
  }
}
