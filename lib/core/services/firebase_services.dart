import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taska/data/model/body/user_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserProfile({required UserModel userModel}) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(userModel.toJson());
  }

  Future<UserModel> getCurrentUser() async {
    final doc =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  Future<List<UserModel>> getUsersProfile() async {
    final doc = await _firestore.collection('users').get();

    final users = doc.docs.map((e) => UserModel.fromJson(e.data())).toList();
    print(users.length);

    return users;
  }

  Future<void> updateProfile({required UserModel userModel}) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update(userModel.toJson());
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  final _storage = FirebaseStorage.instance;
  Future<String?> uploadImage(File file) async {
    try {
      final ref = _storage.ref().child(
        'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
