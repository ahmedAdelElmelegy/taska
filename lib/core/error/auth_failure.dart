class AuthFailure {
  final String message;

  const AuthFailure(this.message);

  /// Factory constructor to create an AuthFailure from Firebase error code

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const AuthFailure('Invalid email format.');
      case 'user-disabled':
        return const AuthFailure('This user has been disabled.');
      case 'user-not-found':
        return const AuthFailure('No user found with this email.');
      case 'wrong-password':
      case 'invalid-credential': // أضف ده عشان يشتغل للباسورد الغلط
        return const AuthFailure('Incorrect password.');
      case 'email-already-in-use':
        return const AuthFailure('Email is already in use.');
      case 'operation-not-allowed':
        return const AuthFailure('Operation not allowed.');
      case 'weak-password':
        return const AuthFailure('Password is too weak.');
      case 'network-request-failed':
        return const AuthFailure('Network connection failed.');
      default:
        return const AuthFailure('An unknown error occurred.');
    }
  }
  @override
  String toString() => message;
}
