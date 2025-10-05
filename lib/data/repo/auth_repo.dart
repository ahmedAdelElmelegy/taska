import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taska/core/error/auth_failure.dart';
import 'package:taska/core/error/firestore_error.dart';
import 'package:taska/core/services/firebase_services.dart';
import 'package:taska/data/model/body/user_model.dart';

class AuthRepo {
  final FirebaseServices firebaseServices;

  AuthRepo(this.firebaseServices);
  Future<Either<AuthFailure, UserCredential>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseServices.signUp(
        email: email,
        password: password,
      );
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (_) {
      return const Left(
        AuthFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<AuthFailure, UserCredential>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseServices.login(
        email: email,
        password: password,
      );
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (_) {
      return const Left(
        AuthFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<AuthFailure, void>> createUserProfile({
    required UserModel userModel,
  }) async {
    try {
      return right(
        await firebaseServices.createUserProfile(userModel: userModel),
      );
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure('Failed to create user profile: $e'));
    }
  }

  Future<Either<AuthFailure, List<UserModel>>> getUsersProfile() async {
    try {
      final users = await firebaseServices.getUsersProfile();
      return right(users);
    } catch (e) {
      return Left(AuthFailure('Failed to fetch user profiles: $e'));
    }
  }

  Future<Either<AuthFailure, UserModel>> getCurrentUser() async {
    try {
      final users = await firebaseServices.getCurrentUser();
      return right(users);
    } catch (e) {
      return Left(AuthFailure('Failed to fetch user profile: $e'));
    }
  }

  Future<Either<AuthFailure, void>> updateProfile({
    required UserModel userModel,
  }) async {
    try {
      return right(await firebaseServices.updateProfile(userModel: userModel));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(AuthFailure('Failed to update user profile: $e'));
    }
  }

  Future<Either<AuthFailure, void>> logout() async {
    try {
      await firebaseServices.logout();
      return right(null);
    } catch (e) {
      return Left(AuthFailure('Failed to log out: $e'));
    }
  }

  Future<Either<AuthFailure, String>> uploadImage(File file) async {
    try {
      final url = await firebaseServices.uploadImage(file);
      return right(url!);
    } catch (e) {
      return Left(AuthFailure('Failed to upload image: $e'));
    }
  }

  Future<Either<FirestoreFailure, String>> uploadFile(File file) async {
    try {
      final downloadUrl = await firebaseServices.uploadImage(file);
      return right(downloadUrl!);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }
}
