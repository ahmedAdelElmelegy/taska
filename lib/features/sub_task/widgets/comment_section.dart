import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/features/comment/comment_screen.dart';
import 'package:taska/features/home/widgets/row_of_home.dart';
import 'package:taska/features/sub_task/widgets/comment_list_view.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.taskId});

  final String taskId;
  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).getComments(widget.taskId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final projectCubit = context.read<ProjectCubit>();
        if (state is GetCommentsFailure) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
          );
        } else if (state is GetCommentsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: projectCubit.commentList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return Column(
              children: [
                RowOfHome(
                  text: 'Comments (${snapshot.data!.length})',
                  onPress: () {
                    push(CommentScreen());
                  },
                ),
                verticalSpace(24),
                CommentListView(commentList: snapshot.data),
                verticalSpace(24),
                CustomBtn(
                  onPressed: () {
                    push(CommentScreen());
                  },
                  text: 'Expand More',
                  color: ColorManager.lightBlue,
                  textColor: ColorManager.primary,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
