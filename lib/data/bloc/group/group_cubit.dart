import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/data/model/body/group_model.dart';
import 'package:taska/data/model/body/message_model.dart';
import 'package:taska/data/model/body/user_model.dart';
import 'package:taska/data/repo/group_repo.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(this.groupRepo) : super(GroupInitial());
  List<String> membersIds = [];
  List<UserModel> members = [];
  TextEditingController nameController = TextEditingController();
  final GroupRepo groupRepo;
  Future<void> createGroup({required GroupModel groupModel}) async {
    emit(GroupLoading());
    final result = await groupRepo.createGroup(groupModel: groupModel);
    result.fold(
      (failure) {
        emit(GroupFailure(failure.message));
      },
      (success) {
        emit(GroupSuccess());
        nameController.clear();
        membersIds.clear();
        members.clear();
        getGroups();
        pop();
      },
    );
  }

  List<GroupModel> groups = [];
  Future<void> getGroups() async {
    emit(GetGroupsLoading());
    final result = await groupRepo.getGroups();
    result.fold(
      (failure) {
        emit(GetGroupsFailure(failure.message));
      },
      (success) {
        emit(GetGroupsSuccess());
        groups = success;
      },
    );
  }

  TextEditingController messageController = TextEditingController();
  // send message
  Future<void> sendMessage({required MessageModel messageModel}) async {
    emit(SendMessageLoading());
    final result = await groupRepo.sendMessage(messageModel: messageModel);
    result.fold(
      (failure) {
        emit(SendMessageFailure(failure.message));
      },
      (success) {
        emit(SendMessageSuccess());
        messageController.clear();
      },
    );
  }

  Stream<List<MessageModel>>? messages;
  // get messages
  Future<void> getMessages(String groupId) async {
    emit(GetMessagesLoading());
    final result = groupRepo.getMessages(groupId);
    result.fold(
      (failure) {
        emit(GetMessagesFailure(failure.message));
      },
      (success) {
        messages = success;
        emit(GetMessagesSuccess());
      },
    );
  }

  List<GroupModel> groupsByOwnerId = [];
  Future<void> getGroupsByOwnerId(String ownerId) async {
    emit(GetGroupsByOwnerIdLoading());
    final result = await groupRepo.getGroupsByOwnerId(ownerId);
    result.fold(
      (failure) {
        emit(GetGroupsByOwnerIdFailure(failure.message));
      },
      (success) {
        groupsByOwnerId = success;
        emit(GetGroupsByOwnerIdSuccess());
      },
    );
  }
}
