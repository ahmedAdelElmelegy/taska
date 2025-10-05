import 'package:taska/data/model/body/task_model.dart';

class BoardModel {
  final String id;
  final String title;
  final String projectId;
  final DateTime createdAt;
  List<TaskModel>? tasks;

  BoardModel({
    required this.id,
    required this.title,
    required this.projectId,
    required this.createdAt,
    this.tasks,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      id: json['id'] as String,
      title: json['title'] as String,
      projectId: json['projectId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((task) => TaskModel.fromJson(task as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'projectId': projectId,
      'createdAt': createdAt.toIso8601String(),
      'tasks': tasks?.map((task) => task.toJson()).toList(),
    };
  }
}
