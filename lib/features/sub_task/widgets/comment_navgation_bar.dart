import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/helper/validator.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/data/model/comment_model.dart';
import 'package:uuid/uuid.dart';

class CommentNavgationBar extends StatefulWidget {
  final TaskModel? taskModel;
  const CommentNavgationBar({super.key, this.taskModel});

  @override
  State<CommentNavgationBar> createState() => _CommentNavgationBarState();
}

class _CommentNavgationBarState extends State<CommentNavgationBar> {
  @override
  initState() {
    AuthCubit.get(context).getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ProjectCubit.get(context);
    final authbloc = AuthCubit.get(context);
    bloc.commentUserModel = authbloc.user;
    return Form(
      key: bloc.formKeyComment,
      child: Container(
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
            bottom: 36.h,
            left: 24.w,
            right: 24.w,
            top: 24.h,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              horizontalSpace(24),
              Expanded(
                child: CustomTextField(
                  controller: bloc.commentController,
                  validator: (p0) => Validator.role(p0),
                  text: 'Post a comment...',
                  suffixIcon: InkWell(
                    onTap: () {
                      if (bloc.formKeyComment.currentState!.validate()) {
                        CommentModel commentModel = CommentModel(
                          userModel: bloc.commentUserModel!,
                          taskId: widget.taskModel!.id!,
                          message: bloc.commentController.text,
                          likes: [],
                          id: Uuid().v4(),
                          createdAt: DateTime.now(),
                        );
                        bloc.addComment(commentModel: [commentModel]);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(
                        icon: AppIcons.send2,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
