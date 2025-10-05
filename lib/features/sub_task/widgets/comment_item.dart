import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/function/get_duration.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/model/comment_model.dart';

class CommentItem extends StatelessWidget {
  final CommentModel? commentModel;
  const CommentItem({super.key, this.commentModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              horizontalSpace(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentModel!.userModel.fullName,
                    style: TextStyles.f18SemiBold,
                  ),
                  Text(
                    commentModel!.userModel.userName,
                    style: TextStyles.f14Regular.copyWith(
                      color: ColorManager.grey,
                    ),
                  ),
                ],
              ),
              Spacer(),
              SvgIcon(icon: AppIcons.iconsMore),
            ],
          ),
          verticalSpace(12),
          Text(commentModel!.message, style: TextStyles.f14Regular),
          verticalSpace(12),
          Row(
            children: [
              Row(
                children: [
                  SvgIcon(icon: AppIcons.heart),
                  horizontalSpace(4),
                  Text(
                    commentModel!.likes!.length.toString(),
                    style: TextStyles.f14Regular,
                  ),
                ],
              ),
              horizontalSpace(24),
              Text('Reply', style: TextStyles.f14Regular),
              horizontalSpace(24),
              Text(
                getDuration(commentModel!.createdAt.toString()),
                style: TextStyles.f14Regular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
