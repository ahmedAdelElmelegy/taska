import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';

import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/features/teams/widgets/member_item.dart';

class AddTeam extends StatefulWidget {
  final bool isGroup;
  const AddTeam({super.key, this.isGroup = false});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  @override
  void initState() {
    context.read<AuthCubit>().fetchUsersProfile();
    // Initialize the AuthCubit to fetch user profiles
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is GetuserProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetuserProfileFailure) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is GetuserProfileLoading) {
                return Center(child: CircularProgressIndicator());
              }
              final cubit = context.read<AuthCubit>();
              final project = context.read<ProjectCubit>();
              final group = context.read<GroupCubit>();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    verticalSpace(41),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextPop(text: 'Add Team Member'),
                        SvgIcon(icon: AppIcons.iconsMore),
                      ],
                    ),
                    verticalSpace(32),
                    CustomTextField(
                      text: 'Search',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgIcon(
                          icon: AppIcons.iconsSearch,
                          width: 20.w,
                          height: 20.h,
                          color: ColorManager.grey,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgIcon(
                          icon: AppIcons.swap,
                          width: 20.w,
                          height: 20.h,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    verticalSpace(32),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      itemBuilder:
                          (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child:
                                widget.isGroup
                                    ? MemberItem(
                                      userModel: cubit.userProfiles[index],
                                      inProject: false,

                                      isInvite: group.members.any(
                                        (element) =>
                                            element ==
                                            cubit.userProfiles[index],
                                      ),
                                      onInvitePressed: () {
                                        setState(() {
                                          group.members.add(
                                            cubit.userProfiles[index],
                                          );
                                          group.membersIds.add(
                                            cubit.userProfiles[index].uid,
                                          );
                                        });
                                      },
                                    )
                                    : MemberItem(
                                      userModel: cubit.userProfiles[index],
                                      inProject: false,

                                      isInvite: project.members.any(
                                        (element) =>
                                            element ==
                                            cubit.userProfiles[index],
                                      ),
                                      onInvitePressed: () {
                                        setState(() {
                                          project.addMemberAndMemberId(
                                            cubit.userProfiles[index],
                                          );
                                        });
                                      },
                                    ),
                          ),
                      itemCount: cubit.userProfiles.length,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          border: Border(
            top: BorderSide(color: ColorManager.grey, width: .3.w),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 5 / 100),
              blurRadius: 50,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 36.h,
            right: 24.w,
            left: 24.w,
          ),
          child: CustomBtn(
            text: 'Add Member',
            onPressed: () {
              pop();
            },
          ),
        ),
      ),
    );
  }
}
