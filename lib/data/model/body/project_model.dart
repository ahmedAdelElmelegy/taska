import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/data/model/body/user_model.dart';

enum ProjectCat { todo, inProgress, completed, archived }

class ProjectModel {
  final String id;
  String name;
  String visibility;
  String ownerId;
  List<UserModel> members;
  List<String> memberIds;
  int? totalTasks;
  int? completedTasks;
  DateTime? deadline;
  int? color;
  String? coverImage;
  String? logo;
  DateTime createdAt;
  String? description;

  ProjectModel({
    required this.id,
    this.totalTasks,
    this.completedTasks,
    required this.name,
    required this.visibility,
    required this.ownerId,
    required this.members,
    this.deadline,
    required this.memberIds,
    this.color,
    this.coverImage,
    this.logo,
    this.description,
    required this.createdAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      memberIds:
          (json['memberIds'] as List<dynamic>? ?? [])
              .map((e) => e as String)
              .toList(),
      id: json['id'] as String,
      name: json['name'] as String,
      visibility: json['visibility'] as String,
      ownerId: json['ownerId'] as String,
      members:
          (json['members'] as List<dynamic>? ?? [])
              .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
              .toList(),
      deadline:
          json['deadline'] != null
              ? DateTime.parse(json['deadline'] as String)
              : null,
      color: json['color'] as int?,
      coverImage: json['coverImage'] as String?,
      logo: json['logo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'memberIds': memberIds,
      'visibility': visibility,
      'ownerId': ownerId,
      'members': members.map((e) => e.toJson()).toList(),
      'deadline': deadline?.toIso8601String(),
      'color': color,
      'coverImage': coverImage,
      'logo': logo,
      'createdAt': createdAt.toIso8601String(),
      'description': description,
    };
  }

  double progressFromTasks(List<TaskModel> tasks) {
    final projectTasks = tasks.where((t) => t.projectId == id).toList();
    if (projectTasks.isEmpty) return 0;
    final completedCount =
        projectTasks.where((t) => t.isCompleted == true).length;
    return completedCount / projectTasks.length;
  }

  ProjectCat categoryFromTasks(List<TaskModel> tasks) {
    final projectTasks = tasks.where((t) => t.projectId == id).toList();
    if (projectTasks.isEmpty) return ProjectCat.todo;

    final completedCount =
        projectTasks.where((t) => t.isCompleted == true).length;

    if (completedCount == 0) {
      return ProjectCat.todo;
    } else if (completedCount < projectTasks.length) {
      return ProjectCat.inProgress;
    } else {
      return ProjectCat.completed;
    }
  }
}
