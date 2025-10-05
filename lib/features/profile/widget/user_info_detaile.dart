import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/features/profile/widget/vertical_div.dart';

class UserInfoDetaile extends StatelessWidget {
  final ProjectCubit projectCubit;
  const UserInfoDetaile({
    super.key,
    required this.cubit,
    required this.projectCubit,
  });

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(cubit.user?.fullName ?? '', style: TextStyles.f22SemiBold),
        verticalSpace(8),
        Text(cubit.user?.userName ?? '', style: TextStyles.f14Meduim),
        verticalSpace(24),
        BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      projectCubit.projectByOwnerId.length.toString(),
                      style: TextStyles.f24Bold,
                    ),
                    verticalSpace(8),
                    Text('Projects', style: TextStyles.f18Meduim),
                  ],
                ),
                VerticalDiv(),
                Column(
                  children: [
                    Text(
                      projectCubit.tasksByOwnerId.length.toString(),
                      style: TextStyles.f24Bold,
                    ),
                    verticalSpace(8),
                    Text('Tasks', style: TextStyles.f18Meduim),
                  ],
                ),
                VerticalDiv(),
                Column(
                  children: [
                    Text(
                      context
                          .read<GroupCubit>()
                          .groupsByOwnerId
                          .length
                          .toString(),
                      style: TextStyles.f24Bold,
                    ),
                    verticalSpace(8),
                    Text('Group', style: TextStyles.f18Meduim),
                  ],
                ),
              ],
            );
          },
        ),
        verticalSpace(18),
        Divider(thickness: 1, color: ColorManager.lightGrey),
        verticalSpace(40),
      ],
    );
  }
}
