import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';

import 'package:taska/data/model/body/group_model.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/data/model/body/message_model.dart';
import 'package:taska/features/chat/widget/chat_item.dart';
import 'package:taska/features/chat/widget/chat_item_friend.dart';
import 'package:uuid/uuid.dart';

class GroupChatingScreen extends StatefulWidget {
  final GroupModel groupModel;

  const GroupChatingScreen({super.key, required this.groupModel});

  @override
  State<GroupChatingScreen> createState() => _GroupChatingScreenState();
}

class _GroupChatingScreenState extends State<GroupChatingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getCurrentUser();
    context.read<GroupCubit>().getMessages(widget.groupModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            final groupCubit = context.read<GroupCubit>();
            if (state is SendMessageLoading || state is GetMessagesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  verticalSpace(16),
                  GroupChatAppBar(groupModel: widget.groupModel),
                  verticalSpace(16),
                  Expanded(
                    child: StreamBuilder(
                      stream: groupCubit.messages,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index].senderId ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? MyChat(messageModel: snapshot.data![index])
                                : MyFriendChat(
                                  messageModel: snapshot.data![index],
                                );
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: CustomTextField(
                            controller: groupCubit.messageController,
                            text: 'Type a message',
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: SvgIcon(icon: AppIcons.camera2),
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(16),
                      GestureDetector(
                        onTap: () {
                          if (groupCubit.messageController.text.isNotEmpty) {
                            groupCubit.sendMessage(
                              messageModel: MessageModel(
                                id: Uuid().v4(),
                                groupId: widget.groupModel.id,
                                message: groupCubit.messageController.text,
                                senderId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                sender: context.read<AuthCubit>().user!,

                                sentTime: DateTime.now(),
                              ),
                            );
                          }
                        },
                        child:
                            state is SendMessageLoading
                                ? const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManager.primary,
                                  ),
                                )
                                : CircleAvatar(
                                  radius: 24.r,
                                  backgroundColor: ColorManager.primary,
                                  child: SvgIcon(
                                    icon: AppIcons.send2,
                                    color: ColorManager.white,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GroupChatAppBar extends StatelessWidget {
  const GroupChatAppBar({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            pop();
          },
          child: SvgIcon(icon: AppIcons.iconsArrowBack),
        ),
        horizontalSpace(16),
        Expanded(
          child: Text(
            groupModel.name,
            style: TextStyles.f22SemiBold,
            maxLines: 1,
          ),
        ),
        horizontalSpace(8),
        SvgIcon(icon: AppIcons.phone),
        horizontalSpace(16),
        SvgIcon(icon: AppIcons.vedio),
        horizontalSpace(16),
        SvgIcon(icon: AppIcons.iconsMore),
      ],
    );
  }
}
