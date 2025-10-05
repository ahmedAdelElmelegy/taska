import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/di/injection.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/outline_container.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/projects/add_new_task.dart';
import 'package:taska/features/projects/widgets/task_list.dart';

ProjectCubit projectCubit = getIt<ProjectCubit>();

class BoardItem extends StatefulWidget {
  final BoardModel boardModel;
  final ProjectModel projectModel;

  const BoardItem({
    super.key,
    required this.boardModel,
    required this.projectModel,
  });

  @override
  State<BoardItem> createState() => _BoardItemState();
}

class _BoardItemState extends State<BoardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 319.w,
      margin: EdgeInsets.symmetric(horizontal: 24.w),

      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: ColorManager.details,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.boardModel.title, style: TextStyles.f20SemiBold),

              horizontalSpace(8),
              OutlineContainer(
                text:
                    context
                        .read<ProjectCubit>()
                        .getTasksForBoard(widget.boardModel.id)
                        .length
                        .toString(),
              ),
              Spacer(),
              widget.projectModel.ownerId ==
                      FirebaseAuth.instance.currentUser!.uid
                  ? GestureDetector(
                    onTap: () {
                      push(
                        AddNewTask(
                          boardModel: widget.boardModel,
                          projectModel: widget.projectModel,
                        ),
                      );
                    },
                    child: SvgIcon(icon: AppIcons.addRounded),
                  )
                  : SizedBox(),
            ],
          ),

          TaskList(boardModel: widget.boardModel),
        ],
      ),
    );
  }
}
