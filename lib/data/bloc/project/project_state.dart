part of 'project_cubit.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class CreateProjectLoading extends ProjectState {}

final class CreateProjectSuccess extends ProjectState {}

final class CreateProjectFailure extends ProjectState {
  final String message;

  CreateProjectFailure(this.message);
}

final class GetProjectsLoading extends ProjectState {}

final class GetProjectsSuccess extends ProjectState {}

final class GetProjectsFailure extends ProjectState {
  final String message;

  GetProjectsFailure(this.message);
}

final class AddBoardLoading extends ProjectState {}

final class AddBoardSuccess extends ProjectState {}

final class AddBoardFailure extends ProjectState {
  final String message;

  AddBoardFailure(this.message);
}

final class GetBoardLoading extends ProjectState {}

// ignore: must_be_immutable
final class GetBoardSuccess extends ProjectState {
  List<BoardModel> board;
  GetBoardSuccess(this.board);
}

final class GetBoardFailure extends ProjectState {
  final String message;

  GetBoardFailure(this.message);
}

final class AddTaskLoading extends ProjectState {}

final class AddTaskSuccess extends ProjectState {}

final class AddTaskFailure extends ProjectState {
  final String message;

  AddTaskFailure(this.message);
}

final class GetTasksLoading extends ProjectState {}

// ignore: must_be_immutable
final class GetTasksSuccess extends ProjectState {
  List<TaskModel> tasks;
  GetTasksSuccess(this.tasks);
}

final class GetTasksFailure extends ProjectState {
  final String message;

  GetTasksFailure(this.message);
}

final class UploadFileLoading extends ProjectState {}

final class UploadFileSuccess extends ProjectState {}

final class UploadFileFailure extends ProjectState {
  final String message;

  UploadFileFailure(this.message);
}

final class AddProjectCoverImageLoading extends ProjectState {}

final class AddProjectCoverImageSuccess extends ProjectState {}

final class AddProjectCoverImageFailure extends ProjectState {
  final String message;

  AddProjectCoverImageFailure(this.message);
}

final class AddSubTaskLoading extends ProjectState {}

final class AddSubTaskSuccess extends ProjectState {}

final class AddSubTaskFailure extends ProjectState {
  final String message;

  AddSubTaskFailure(this.message);
}

final class GetSubTaskLoading extends ProjectState {}

final class GetSubTaskSuccess extends ProjectState {
  final List<SubTasksModel> subtasks;

  GetSubTaskSuccess(this.subtasks);
}

final class GetSubTaskFailure extends ProjectState {
  final String message;

  GetSubTaskFailure(this.message);
}

final class AddCommentLoading extends ProjectState {}

final class AddCommentSuccess extends ProjectState {}

final class AddCommentFailure extends ProjectState {
  final String message;

  AddCommentFailure(this.message);
}

final class GetCommentsLoading extends ProjectState {}

final class GetCommentsSuccess extends ProjectState {}

final class GetCommentsFailure extends ProjectState {
  final String message;

  GetCommentsFailure(this.message);
}

final class GetTodayTasksLoading extends ProjectState {}

final class GetTodayTasksSuccess extends ProjectState {
  final List<TaskModel> tasks;

  GetTodayTasksSuccess(this.tasks);
}

final class GetTodayTasksFailure extends ProjectState {
  final String message;

  GetTodayTasksFailure(this.message);
}

final class UpdateTaskStatusLoading extends ProjectState {}

final class UpdateTaskStatusSuccess extends ProjectState {}

final class UpdateTaskStatusFailure extends ProjectState {
  final String message;

  UpdateTaskStatusFailure(this.message);
}

final class GetTasksForProjectLoading extends ProjectState {}

final class GetTasksForProjectSuccess extends ProjectState {
  final List<TaskModel> tasks;

  GetTasksForProjectSuccess(this.tasks);
}

final class GetTasksForProjectFailure extends ProjectState {
  final String message;

  GetTasksForProjectFailure(this.message);
}

// delete project
final class DeleteProjectLoading extends ProjectState {}

final class DeleteProjectSuccess extends ProjectState {}

final class DeleteProjectFailure extends ProjectState {
  final String message;

  DeleteProjectFailure(this.message);
}

// update project color
final class UpdateProjectColorLoading extends ProjectState {}

final class UpdateProjectColorSuccess extends ProjectState {}

final class UpdateProjectColorFailure extends ProjectState {
  final String message;

  UpdateProjectColorFailure(this.message);
}

// edit description
final class EditDescriptionLoading extends ProjectState {}

final class EditDescriptionSuccess extends ProjectState {}

final class EditDescriptionFailure extends ProjectState {
  final String message;

  EditDescriptionFailure(this.message);
}

// add deadline project
final class AddDeadlineProjectLoading extends ProjectState {}

final class AddDeadlineProjectSuccess extends ProjectState {}

final class AddDeadlineProjectFailure extends ProjectState {}

final class ChangeCategorySuccess extends ProjectState {}

// get all tasks
final class GetAllTasksLoading extends ProjectState {}

final class GetAllTasksSuccess extends ProjectState {
  final List<TaskModel> tasks;

  GetAllTasksSuccess(this.tasks);
}

final class GetAllTasksFailure extends ProjectState {
  final String message;

  GetAllTasksFailure(this.message);
}

final class SearchProjectLoading extends ProjectState {}

final class SearchProjectSuccess extends ProjectState {}

final class SearchProjectFailure extends ProjectState {
  final String message;

  SearchProjectFailure(this.message);
}

// get project by owner id
final class GetProjectByOwnerIdLoading extends ProjectState {}

final class GetProjectByOwnerIdSuccess extends ProjectState {
  final List<ProjectModel> projects;

  GetProjectByOwnerIdSuccess(this.projects);
}

final class GetProjectByOwnerIdFailure extends ProjectState {
  final String message;

  GetProjectByOwnerIdFailure(this.message);
}

// get tasks by ownerId
final class GetTasksByOwnerIdLoading extends ProjectState {}

final class GetTasksByOwnerIdSuccess extends ProjectState {
  final List<TaskModel> tasks;

  GetTasksByOwnerIdSuccess(this.tasks);
}

final class GetTasksByOwnerIdFailure extends ProjectState {
  final String message;

  GetTasksByOwnerIdFailure(this.message);
}

// upload  imag failure
final class UploadImageFailure extends ProjectState {}

final class AddMemberAndMemberId extends ProjectState {}
