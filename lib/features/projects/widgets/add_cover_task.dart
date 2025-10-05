import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class AddCoverTask extends StatelessWidget {
  final XFile? image;
  const AddCoverTask({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: FileImage(File(image!.path)),
              fit: BoxFit.cover,
            ),
          ),
        )
        : Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(width: 1.w, color: ColorManager.lightGrey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 24.sp, color: ColorManager.grey),
              verticalSpace(8),
              Text('Add Cover', style: TextStyles.f14Regular),
            ],
          ),
        );
  }
}
