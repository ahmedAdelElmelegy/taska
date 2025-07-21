import 'package:flutter/material.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/circle_check_box.dart';

class StatusItem extends StatelessWidget {
  final String title;
  const StatusItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('To-Do', style: TextStyles.f20SemiBold),
        Spacer(),
        CircleCheckBox(),
      ],
    );
  }
}
