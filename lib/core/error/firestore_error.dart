import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFailure {
  final String message;

  FirestoreFailure(this.message);

  factory FirestoreFailure.fromException(Object e) {
    if (e is FirebaseException) {
      switch (e.code) {
        case 'permission-denied':
          return FirestoreFailure("Permission denied.");
        default:
          return FirestoreFailure("Firebase error: ${e.message}");
      }
    } else {
      return FirestoreFailure("Unexpected error occurred.");
    }
  }
}
