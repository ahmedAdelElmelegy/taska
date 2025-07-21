import 'package:flutter/material.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_divider.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomDevider()),
        horizontalSpace(24),
        Text('or', style: TextStyles.f16Regular),
        horizontalSpace(24),
        Expanded(child: CustomDevider()),
      ],
    );
  }
}
