import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:taska/data/model/body/group_model.dart';
import 'package:taska/data/model/body/message_model.dart';

class GroupServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = firebase_storage.FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  Future<void> createGroup({required GroupModel groupModel}) async {
    _firestore.collection('groups').doc(groupModel.id).set(groupModel.toJson());
  }

  Future<List<GroupModel>> getGroups() async {
    final snapshot =
        await _firestore
            .collection('groups')
            .where('memberIds', arrayContains: _auth.currentUser!.uid)
            .get();
    return snapshot.docs.map((e) => GroupModel.fromJson(e.data())).toList();
  }

  Future<List<GroupModel>> getGroupsByOwnerId(String ownerId) async {
    final snapshot =
        await _firestore
            .collection('groups')
            .where('ownerId', isEqualTo: ownerId)
            .get();
    return snapshot.docs.map((e) => GroupModel.fromJson(e.data())).toList();
  }

  // creat chat group
  Future<void> sendMessage({required MessageModel messageModel}) async {
    _firestore
        .collection('messages')
        .doc(messageModel.id)
        .set(messageModel.toJson());
  }

  // get messages
  Stream<List<MessageModel>> getMessages(String groupId) {
    return _firestore
        .collection('messages')
        .where('groupId', isEqualTo: groupId)
        .orderBy('sentTime', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((e) => MessageModel.fromJson(e.data()))
                  .toList(),
        );
  }
}
