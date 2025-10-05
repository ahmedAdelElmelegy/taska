class UserModel {
  final String fullName;
  final String userName;
  final String uid;
  final String dateOfBirth;
  final String email;
  final String? imageUrl;
  final String phoneNumber;
  final String role;

  const UserModel({
    required this.fullName,
    required this.userName,
    required this.uid,
    required this.dateOfBirth,
    required this.email,
    this.imageUrl,
    required this.phoneNumber,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'uid': uid,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? userName,
    String? uid,
    String? dateOfBirth,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? role,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      uid: uid ?? this.uid,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  @override
  String toString() => 'UserModel(fullName: $fullName, uid: $uid)';

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserModel &&
            runtimeType == other.runtimeType &&
            uid == other.uid);
  }

  @override
  int get hashCode => uid.hashCode;
}
