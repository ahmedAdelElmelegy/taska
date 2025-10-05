class SubTasksModel {
  final String id;
  final String subTaskName;
  final String dueDate;
  final String time;
  final bool? status;
  final String taskId;

  SubTasksModel({
    required this.taskId,
    required this.id,
    required this.subTaskName,
    required this.dueDate,
    required this.time,
    this.status,
  });

  factory SubTasksModel.fromjson(Map<String, dynamic> json) => SubTasksModel(
    id: json['id'],
    subTaskName: json['subTaskName'],
    dueDate: json['dueDate'],
    time: json['time'],
    status: json['status'],
    taskId: json['taskId'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'subTaskName': subTaskName,
      'dueDate': dueDate,
      'time': time,
      'status': status,
    };
  }
}
