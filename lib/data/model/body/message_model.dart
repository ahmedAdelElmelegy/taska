import 'package:taska/data/model/body/user_model.dart';

class MessageModel {
  final String id;
  final String groupId;
  final String message;
  final String senderId;
  final UserModel sender;

  final DateTime sentTime;
  final bool? isRead;

  MessageModel({
    required this.id,
    required this.groupId,
    required this.message,
    required this.senderId,
    required this.sender,
    required this.sentTime,
    this.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'],
    groupId: json['groupId'],
    message: json['message'],
    senderId: json['senderId'],
    sender: UserModel.fromJson(json['sender']),
    sentTime: DateTime.parse(json['sentTime']),
    isRead: json['isRead'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'groupId': groupId,
    'message': message,
    'senderId': senderId,
    'sender': sender.toJson(),
    'sentTime': sentTime.toIso8601String(),
    'isRead': isRead,
  };
}
