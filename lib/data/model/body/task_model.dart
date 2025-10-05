import 'package:taska/data/model/body/user_model.dart';

class TaskModel {
  String? id;
  String? title;
  String? description;
  String? coverImage;
  DateTime? dueDate;
  String? dueTime;
  String? projectId;
  bool? isCompleted;
  List<String>? comments;
  String? status; // e.g., 'To-Do', 'In Progress', 'Done'
  String? boardId; // Reference to the board this task belongs to
  UserModel? projectLeader;
  List<UserModel>? teamMember;
  List<String> memberIds;
  String? attachment;
  String? ownerId;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.dueDate,
    this.dueTime,
    this.boardId,
    this.projectLeader,
    required this.memberIds,
    this.teamMember,
    this.attachment,
    this.projectId,
    this.isCompleted,
    this.comments,
    this.status,
    this.ownerId,
  }); //
  TaskModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      title = json['title'] as String,
      description = json['description'] as String,
      coverImage = json['coverImage'] as String,
      dueDate = DateTime.parse(json['dueDate']),
      dueTime = json['dueTime'] as String,
      comments = (json['comments'] as List?)?.map((e) => e as String).toList(),
      status = json['status'] as String?,
      boardId = json['boardId'] as String,
      ownerId = json['ownerId'] as String,
      memberIds =
          (json['memberIds'] as List<dynamic>? ?? [])
              .map((e) => e as String)
              .toList(),
      projectLeader =
          json['projectLeader'] != null
              ? UserModel.fromJson(
                json['projectLeader'] as Map<String, dynamic>,
              )
              : null,
      teamMember =
          (json['teamMember'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      attachment = json['attachment'] as String,
      projectId = json['projectId'] as String,
      isCompleted = json['isCompleted'] as bool?;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerId': ownerId,
      'coverImage': coverImage,
      'dueDate': dueDate?.toIso8601String().split('T').first,
      'dueTime': dueTime,
      'comments': comments,
      'status': status,
      'boardId': boardId,
      'projectLeader': projectLeader?.toJson(),
      'teamMember': teamMember?.map((e) => e.toJson()).toList(),
      'attachment': attachment,
      'memberIds': memberIds.map((e) => e).toList(),
      'projectId': projectId,
      'isCompleted': isCompleted ?? false,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? coverImage,
    DateTime? dueDate,
    String? ownerId,
    String? dueTime,
    String? projectId,
    bool? isCompleted,
    List<String>? comments,
    String? status,
    String? boardId,
    UserModel? projectLeader,
    List<UserModel>? teamMember,
    String? attachment,
    List<String>? memberIds,
  }) {
    return TaskModel(
      id: id ?? this.id,
      memberIds: memberIds ?? this.memberIds,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      ownerId: ownerId ?? this.ownerId,
      projectId: projectId ?? this.projectId,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      boardId: boardId ?? this.boardId,
      projectLeader: projectLeader ?? this.projectLeader,
      teamMember: teamMember ?? this.teamMember,
      attachment: attachment ?? this.attachment,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
