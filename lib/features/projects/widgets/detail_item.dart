import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/widgets/shadow_container.dart';
import 'package:taska/features/projects/widgets/detail_item_header.dart';
import 'package:taska/features/projects/widgets/profile_sections.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: ShadowContainer(
        child: Column(
          children: [DetailItemHeader(), verticalSpace(24), ProfilesSections()],
        ),
      ),
    );
  }
}
