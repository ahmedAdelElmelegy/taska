import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/message_model.dart';

class MyFriendChat extends StatelessWidget {
  final MessageModel messageModel;
  const MyFriendChat({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorManager.white,
            backgroundImage:
                messageModel.sender.imageUrl != null
                    ? NetworkImage(messageModel.sender.imageUrl!)
                    : AssetImage(AppImages.defultProfile),
          ),
          horizontalSpace(16),
          SizedBox(
            width: 200.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.background,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      messageModel.message,
                      style: TextStyles.f16Medium,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    DateFormat('hh:mm a').format(messageModel.sentTime),
                    style: TextStyles.f14Regular,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
