part of 'group_cubit.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupSuccess extends GroupState {}

final class GroupFailure extends GroupState {
  final String message;
  GroupFailure(this.message);
}

final class GetGroupsLoading extends GroupState {}

final class GetGroupsSuccess extends GroupState {}

final class GetGroupsFailure extends GroupState {
  final String message;
  GetGroupsFailure(this.message);
}

final class SendMessageLoading extends GroupState {}

final class SendMessageSuccess extends GroupState {}

final class SendMessageFailure extends GroupState {
  final String message;
  SendMessageFailure(this.message);
}

final class GetMessagesLoading extends GroupState {}

final class GetMessagesSuccess extends GroupState {}

final class GetMessagesFailure extends GroupState {
  final String message;
  GetMessagesFailure(this.message);
}

final class GetGroupsByOwnerIdLoading extends GroupState {}

final class GetGroupsByOwnerIdSuccess extends GroupState {}

final class GetGroupsByOwnerIdFailure extends GroupState {
  final String message;
  GetGroupsByOwnerIdFailure(this.message);
}
