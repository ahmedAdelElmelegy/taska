import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/message_model.dart';

class MyChat extends StatelessWidget {
  final MessageModel messageModel;
  const MyChat({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      messageModel.message,
                      style: TextStyles.f16Medium.copyWith(
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    DateFormat('hh:mm a').format(messageModel.sentTime),
                    style: TextStyles.f14Regular.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          horizontalSpace(16),
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorManager.white,
            backgroundImage:
                messageModel.sender.imageUrl != null
                    ? NetworkImage(messageModel.sender.imageUrl!)
                    : AssetImage(AppImages.defultProfile),
          ),
        ],
      ),
    );
  }
}
