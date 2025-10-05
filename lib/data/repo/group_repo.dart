import 'package:dartz/dartz.dart';
import 'package:taska/core/error/firestore_error.dart';
import 'package:taska/core/services/group_services.dart';
import 'package:taska/data/model/body/group_model.dart';
import 'package:taska/data/model/body/message_model.dart';

class GroupRepo {
  final GroupServices groupServices;

  GroupRepo(this.groupServices);
  Future<Either<FirestoreFailure, void>> createGroup({
    required GroupModel groupModel,
  }) async {
    try {
      await groupServices.createGroup(groupModel: groupModel);
      return right(null);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  Future<Either<FirestoreFailure, List<GroupModel>>> getGroups() async {
    try {
      final groups = await groupServices.getGroups();
      return right(groups);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  // send message
  Future<Either<FirestoreFailure, void>> sendMessage({
    required MessageModel messageModel,
  }) async {
    try {
      await groupServices.sendMessage(messageModel: messageModel);
      return right(null);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  // get messages
  Either<FirestoreFailure, Stream<List<MessageModel>>> getMessages(
    String groupId,
  ) {
    try {
      final messages = groupServices.getMessages(groupId);
      return right(messages);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  Future<Either<FirestoreFailure, List<GroupModel>>> getGroupsByOwnerId(
    String ownerId,
  ) async {
    try {
      final groups = await groupServices.getGroupsByOwnerId(ownerId);
      return right(groups);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }
}
