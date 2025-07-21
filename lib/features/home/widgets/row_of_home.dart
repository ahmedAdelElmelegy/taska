import 'package:flutter/material.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class RowOfHome extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  final String? subText;
  const RowOfHome({super.key, required this.text, this.onPress, this.subText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyles.f20SemiBold),

        GestureDetector(
          onTap: onPress,
          child: Text(
            subText ?? 'View All',
            style: TextStyles.f16SemiBoldBlack.copyWith(
              color: ColorManager.primary,
            ),
          ),
        ),
      ],
    );
  }
}
