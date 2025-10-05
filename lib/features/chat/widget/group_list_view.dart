import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';
import 'package:taska/features/chat/group_chat_screen.dart';
import 'package:taska/features/chat/widget/group_item.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupCubit>().getGroups();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        final groupCubit = context.read<GroupCubit>();
        if (state is GetGroupsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetGroupsFailure) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
          );
        }
        return Column(
          children: [
            CustomTextField(
              text: 'Search',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: ColorManager.grey),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgIcon(
                  icon: AppIcons.iconsFilter,

                  color: ColorManager.primary,
                ),
              ),
            ),
            verticalSpace(24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupCubit.groups.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    push(
                      GroupChatingScreen(groupModel: groupCubit.groups[index]),
                    );
                  },
                  child: GroupItem(groupModel: groupCubit.groups[index]),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
