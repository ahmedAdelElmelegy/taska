import 'package:taska/data/model/body/user_model.dart';

class GroupModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> memberIds;
  List<UserModel>? adminIds;
  List<UserModel> members = [];
  DateTime? lastMessageTime;
  String ownerId;

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.memberIds,
    this.adminIds,
    required this.members,
    this.lastMessageTime,
    required this.ownerId,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    memberIds: List<String>.from(json['memberIds']),
    adminIds:
        (json['adminIds'] as List<dynamic>? ?? [])
            .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
    members:
        (json['members'] as List<dynamic>? ?? [])
            .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
    lastMessageTime:
        json['lastMessageTime'] != null
            ? DateTime.parse(json['lastMessageTime'])
            : null,
    ownerId: json['ownerId'],
  );

  // to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'memberIds': memberIds,
    'adminIds': adminIds?.map((e) => e.toJson()).toList(),
    'members': members.map((e) => e.toJson()).toList(),
    'lastMessageTime': lastMessageTime?.toIso8601String(),
    'ownerId': ownerId,
  };
}
