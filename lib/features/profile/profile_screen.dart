import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/utils/constants.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/features/fill_profile/widgets/profile_image.dart';
import 'package:taska/features/profile/widget/profile_app_bar.dart';
import 'package:taska/features/profile/widget/user_info_detaile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).getCurrentUser();
    ProjectCubit.get(
      context,
    ).getProjectByOwnerId(FirebaseAuth.instance.currentUser!.uid);
    ProjectCubit.get(
      context,
    ).getTasksByOwnerId(FirebaseAuth.instance.currentUser!.uid);

    context.read<GroupCubit>().getGroupsByOwnerId(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = AuthCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    verticalSpace(24),
                    ProfileAppBar(),
                    verticalSpace(24),
                    ProfileImage(isEdit: true, user: cubit.user),
                    verticalSpace(24),
                    UserInfoDetaile(
                      cubit: cubit,
                      projectCubit: ProjectCubit.get(context),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: GestureDetector(
                            onTap: () {
                              cubit.logout();
                            },
                            child: Row(
                              children: [
                                SvgIcon(
                                  icon: Constants.profileItem[5].icon,
                                  color: ColorManager.lightError,
                                ),
                                horizontalSpace(8),
                                Text(
                                  Constants.profileItem[5].title,
                                  style: TextStyles.f18Meduim.copyWith(
                                    color: ColorManager.lightError,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
  // push(FillProfileScreen(isEdit: true));