import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/group_model.dart';

class GroupItem extends StatelessWidget {
  final GroupModel groupModel;
  const GroupItem({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: ColorManager.white,
            backgroundImage: AssetImage(AppImages.defultProfile),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(groupModel.name, style: TextStyles.f16SemiBoldBlack),
              verticalSpace(4),
              Text(
                '${groupModel.memberIds.length} Members',
                style: TextStyles.f14Regular,
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Text('12:00 PM', style: TextStyles.f14Regular)],
          ),
        ],
      ),
    );
  }
}
