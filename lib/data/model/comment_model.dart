import 'package:taska/data/model/body/user_model.dart';

class CommentModel {
  final UserModel userModel;
  final String message;
  final List<UserModel>? likes;
  final String id;
  final String taskId;
  final DateTime createdAt;

  CommentModel({
    required this.userModel,
    required this.taskId,
    required this.message,
    this.likes,
    required this.id,
    required this.createdAt,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    List<UserModel>? likes =
        json['likes'] != null
            ? List<UserModel>.from(
              json['likes'].map((x) => UserModel.fromJson(x)),
            )
            : null;
    return CommentModel(
      userModel: UserModel.fromJson(json['userModel']),
      taskId: json['taskId'],
      message: json['message'],
      likes: likes,
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userModel': userModel.toJson(),
      'message': message,
      'taskId': taskId,
      'likes':
          likes == null
              ? []
              : List<Map<String, dynamic>>.from(likes!.map((x) => x.toJson())),
      'id': id,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
