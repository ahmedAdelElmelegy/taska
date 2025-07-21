import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/teams/widgets/profile_info.dart';

class MemberItem extends StatelessWidget {
  final bool? inProject;
  final bool? isInvite;
  const MemberItem({super.key, this.inProject = true, this.isInvite = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileInfo(),
        Spacer(),
        inProject == true
            ? Row(
              children: [
                SvgIcon(icon: AppIcons.iconsSend),
                horizontalSpace(20),
                SvgIcon(icon: AppIcons.delete, color: Colors.red),
              ],
            )
            : isInvite == false
            ? CustomBtn(
              onPressed: () {},

              text: 'Invite',
              height: 31.h,
              width: 50.w,
            )
            : PrimaryOutLineBtn(text: 'Invited', onPressed: () {}, width: 50.w),
      ],
    );
  }
}
