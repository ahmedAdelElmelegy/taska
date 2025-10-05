import 'package:flutter/material.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/widgets/project_person.dart';

class MemberNumber extends StatelessWidget {
  final int memberCount;
  // final List<String> membersImage;
  const MemberNumber({super.key, required this.memberCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Members', style: Theme.of(context).textTheme.bodyLarge),
        horizontalSpace(16),
        Row(
          children: List.generate(memberCount, (index) {
            return ProjectPerson();
          }),
        ),
      ],
    );
  }
}
