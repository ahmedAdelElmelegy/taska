import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/data/model/body/sub_tasks_model.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/data/model/body/user_model.dart';
import 'package:taska/data/model/comment_model.dart';
import 'package:taska/data/repo/project_repo.dart';
import 'package:taska/features/main_screen.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this.projectRepo) : super(ProjectInitial());
  static ProjectCubit get(context) => BlocProvider.of<ProjectCubit>(context);
  ProjectRepo projectRepo;
  final formKey = GlobalKey<FormState>();
  String visibility = 'Public';
  List<UserModel> members = [];
  List<String> membersIds = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController boardNameController = TextEditingController();
  final formkeyBoard = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createProject({required ProjectModel projectModel}) async {
    emit(CreateProjectLoading());
    final result = await projectRepo.createProject(projectModel: projectModel);

    result.fold(
      (failure) {
        emit(CreateProjectFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Project creation failed: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(CreateProjectSuccess());
        nameController.clear();
        visibility = 'Public';
        members.clear();
        Fluttertoast.showToast(
          msg: "Project created successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        pop();
      },
    );
  }

  // addmemberand memberid
  void addMemberAndMemberId(UserModel userModel) {
    members.add(userModel);
    membersIds.add(userModel.uid);
    emit(AddMemberAndMemberId());
  }

  List<ProjectModel> allProjects = [];
  Future<void> getProjects() async {
    emit(GetProjectsLoading());
    final result = await projectRepo.getProjects();
    result.fold(
      (failure) {
        emit(GetProjectsFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load projects: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (projects) {
        allProjects = projects;
        emit(GetProjectsSuccess());
      },
    );
  }

  // get project by owner id
  List<ProjectModel> projectByOwnerId = [];
  Future<void> getProjectByOwnerId(String ownerId) async {
    emit(GetProjectByOwnerIdLoading());
    final result = await projectRepo.getProjectByOwnerId(ownerId);
    result.fold(
      (failure) {
        emit(GetProjectByOwnerIdFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load projects: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (projects) {
        projectByOwnerId = projects;
        emit(GetProjectByOwnerIdSuccess(projects));
      },
    );
  }
  // delete project

  Future<void> deleteProject(String projectId) async {
    emit(DeleteProjectLoading());
    final result = await projectRepo.deleteProject(projectId);
    result.fold(
      (failure) {
        emit(DeleteProjectFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to delete project: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(DeleteProjectSuccess());

        getProjects();
        push(MainScreen());
        Fluttertoast.showToast(
          msg: "Project deleted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }
  // update project color

  Future<void> updateProjectColor(String projectId, Color color) async {
    emit(UpdateProjectColorLoading());
    final result = await projectRepo.updateProjectColor(projectId, color);
    result.fold(
      (failure) {
        emit(UpdateProjectColorFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to update project color: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(UpdateProjectColorSuccess());
        getProjects();
        pop();

        Fluttertoast.showToast(
          msg: "Project color updated successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }

  // edit description
  TextEditingController descriptionController = TextEditingController();
  Future<void> editDescription(String projectId, String description) async {
    emit(EditDescriptionLoading());
    final result = await projectRepo.editDescription(projectId, description);
    result.fold(
      (failure) {
        emit(EditDescriptionFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to edit description: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(EditDescriptionSuccess());
        getProjects();
        descriptionController.clear();
        Fluttertoast.showToast(
          msg: "Description edited successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }

  // add deadline project
  DateTime? selectedDeadline;
  TimeOfDay? selectedTime;

  Future<void> addDeadlineProject(String projectId) async {
    emit(AddDeadlineProjectLoading());
    final result = await projectRepo.addDeadlineProject(
      projectId,
      selectedDeadline!,
      selectedTime!,
    );
    result.fold(
      (failure) {
        emit(AddDeadlineProjectFailure());
        Fluttertoast.showToast(
          msg: "Failed to add deadline project: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(AddDeadlineProjectSuccess());
        getProjects();

        pop();
        Fluttertoast.showToast(
          msg: "Deadline project added successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }

  Future<void> addBoard({required List<BoardModel> board}) async {
    emit(AddBoardLoading());
    final result = await projectRepo.addBoard(board: board);
    result.fold(
      (failure) {
        emit(AddBoardFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to add board: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(AddBoardSuccess());
        boardNameController.clear();
        Fluttertoast.showToast(
          msg: "Board added successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }

  List<UserModel> taskMember = [];
  Future<void> getBoard(String projectId) async {
    emit(GetBoardLoading());
    final result = await projectRepo.getBoard(projectId);
    result.fold(
      (failure) {
        emit(GetBoardFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load boards: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (boards) {
        emit(GetBoardSuccess(boards));
      },
    );
  }

  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  UserModel? projectLeader;
  List<UserModel> teamMember = [];
  final formKeyTask = GlobalKey<FormState>();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();
  DateTime? selectedDueDate;
  TextEditingController dueTimeController = TextEditingController();

  Future<void> addTask({
    required List<TaskModel> taskModel,
    required File file,
    required File image,
  }) async {
    emit(AddTaskLoading());

    final fileResult = await projectRepo.uploadFile(file);
    final imageResult = await projectRepo.uploadFile(image);

    fileResult.fold(
      (failure) {
        emit(UploadFileFailure(failure.message));
        Fluttertoast.showToast(msg: "Failed to upload file");
      },
      (fileUrl) {
        imageResult.fold(
          (failure) {
            emit(UploadFileFailure(failure.message));
            Fluttertoast.showToast(msg: "Failed to upload image");
          },
          (imageUrl) async {
            // عدل taskModel وأضف روابط الملفات
            final task = taskModel.first.copyWith(
              attachment: fileUrl,
              coverImage: imageUrl, // لو عندك حقل `image` في TaskModel
            );

            final result = await projectRepo.addTask([task]);
            result.fold(
              (failure) {
                emit(AddTaskFailure(failure.message));
                Fluttertoast.showToast(msg: failure.message);
              },
              (success) {
                emit(AddTaskSuccess());
                taskNameController.clear();
                taskDescriptionController.clear();
                dueDateController.clear();
                attachmentController.clear();

                projectLeader = null;
                teamMember.clear();

                getProjects();

                Fluttertoast.showToast(msg: "Task added successfully");
              },
            );
          },
        );
      },
    );
  }

  Future<void> addProjectCoverImage(File file, String projectId) async {
    emit(AddProjectCoverImageLoading());
    final fileResult = await projectRepo.uploadFile(file);
    fileResult.fold(
      (failure) {
        emit(UploadFileFailure(failure.message));
        Fluttertoast.showToast(msg: "Failed to upload file");
      },
      (sucess) async {
        final result = await projectRepo.addProjectCoverImage(
          sucess,
          projectId,
        );
        result.fold(
          (failure) => emit(AddProjectCoverImageFailure(failure.message)),
          (coverSuces) {
            emit(AddProjectCoverImageSuccess());
            Fluttertoast.showToast(msg: "Cover image added successfully");
          },
        );
      },
    );
  }

  final Map<String, List<TaskModel>> _boardTasks = {};
  List<TaskModel> getTasksForBoard(String boardId) {
    return _boardTasks[boardId] ?? [];
  }

  bool hasTasksForBoard(String boardId) {
    return _boardTasks.containsKey(boardId);
  }

  Future<void> getTask(String boardId) async {
    emit(GetTasksLoading());
    final result = await projectRepo.getTask(boardId);
    result.fold(
      (failure) {
        emit(GetTasksFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load tasks: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (tasks) {
        List<TaskModel> tasksList =
            tasks
                .where(
                  (element) =>
                      element.memberIds.contains(auth.currentUser!.uid),
                )
                .toList();

        _boardTasks[boardId] = tasksList;

        emit(GetTasksSuccess(tasksList));
      },
    );
  }

  List<TaskModel> todayTasks = [];

  Future<void> getTodayTasks() async {
    emit(GetTodayTasksLoading());
    final result = await projectRepo.getTodayTasks();
    result.fold(
      (failure) {
        emit(GetTodayTasksFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load tasks: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (tasks) {
        todayTasks =
            tasks
                .where((task) => task.memberIds.contains(auth.currentUser!.uid))
                .toList();

        emit(GetTodayTasksSuccess(todayTasks));
      },
    );
  }
  // Instead of one global list
  // List<TaskModel> tasksForProject = [];

  // Use a map keyed by project ID
  Map<String, List<TaskModel>> tasksByProject = {};

  Future<void> getTasksForProject(String projectId) async {
    emit(GetTasksForProjectLoading());

    final result = await projectRepo.getTasksForProject(projectId);
    result.fold(
      (failure) {
        emit(GetTasksForProjectFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load tasks: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (tasks) {
        // Save tasks for this specific project ID
        tasksByProject[projectId] = tasks;

        emit(GetTasksForProjectSuccess(tasks));
      },
    );
  }

  // get tasks by ownerId
  List<TaskModel> tasksByOwnerId = [];
  Future<void> getTasksByOwnerId(String ownerId) async {
    emit(GetTasksByOwnerIdLoading());

    final result = await projectRepo.getTasksByOwnerId(ownerId);
    result.fold(
      (failure) {
        emit(GetTasksByOwnerIdFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load tasks: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (tasks) {
        tasksByOwnerId = tasks;
        emit(GetTasksByOwnerIdSuccess(tasks));
      },
    );
  }

  Future<void> updateTaskStatus(String taskId, bool status) async {
    emit(UpdateTaskStatusLoading());
    final result = await projectRepo.updateTaskStatus(taskId, status);
    result.fold(
      (failure) {
        emit(UpdateTaskStatusFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to update task status: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (success) {
        emit(UpdateTaskStatusSuccess());
        Fluttertoast.showToast(msg: "Task status updated successfully");
      },
    );
  }

  // subtasks
  /// Adds a list of subtasks to the repository.
  ///
  ///
  TextEditingController subtaskNameController = TextEditingController();
  TextEditingController subtaskDueDateController = TextEditingController();

  TextEditingController subtaskDueTimeController = TextEditingController();
  final formKeySubTask = GlobalKey<FormState>();

  Future<void> addSubTask({required List<SubTasksModel> subtaskModel}) async {
    emit(AddSubTaskLoading());

    final result = await projectRepo.addSubTask(subtaskModel);
    result.fold(
      (failure) {
        emit(AddSubTaskFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to add subtask: ${failure.message}",
        );
      },
      (success) {
        emit(AddSubTaskSuccess());
        subtaskNameController.clear();
        subtaskDueDateController.clear();
        subtaskDueTimeController.clear();
        Fluttertoast.showToast(msg: "Subtask added successfully");
      },
    );
  }

  final Map<String, List<SubTasksModel>> _subTask = {};
  List<SubTasksModel> getSubTaskForTask(String taskId) {
    return _subTask[taskId] ?? [];
  }

  Future<void> getSubTask(String taskId) async {
    emit(GetSubTaskLoading());
    final result = await projectRepo.getSubTask(taskId);
    result.fold(
      (failure) {
        emit(GetSubTaskFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load subtasks: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (subtasks) {
        _subTask[taskId] = subtasks;
        emit(GetSubTaskSuccess(subtasks));
      },
    );
  }

  // comments
  final formKeyComment = GlobalKey<FormState>();
  UserModel? commentUserModel;
  TextEditingController commentController = TextEditingController();

  Future<void> addComment({required List<CommentModel> commentModel}) async {
    emit(AddCommentLoading());
    final result = await projectRepo.addComments(commentModel);
    result.fold(
      (failure) {
        emit(AddCommentFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to add comment: ${failure.message}",
        );
      },
      (success) {
        emit(AddCommentSuccess());
        commentController.clear();

        Fluttertoast.showToast(msg: "Comment added successfully");
      },
    );
  }
  // get comments

  Stream<List<CommentModel>>? commentList;

  Future<void> getComments(String taskId) async {
    emit(GetCommentsLoading());

    final result = projectRepo.getComments(taskId);

    result.fold(
      (failure) {
        emit(GetCommentsFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load comments: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (stream) {
        commentList = stream;
        emit(GetCommentsSuccess());
      },
    );
  }

  List<TaskModel> allTasks = [];

  Future<void> getAllTasks() async {
    emit(GetAllTasksLoading());

    final result = await projectRepo.getAllTasks();
    result.fold(
      (failure) {
        emit(GetAllTasksFailure(failure.message));
        Fluttertoast.showToast(
          msg: "Failed to load tasks: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      (tasks) {
        allTasks = tasks;
        emit(GetAllTasksSuccess(tasks));
      },
    );
  }

  var selectCategory = ProjectCat.todo;
  Map<String, List<TaskModel>> filteredTasks = {};

  ProjectCat categoryFromTasks(List<TaskModel> tasks) {
    if (tasks.isEmpty) return ProjectCat.todo;
    final completedCount = tasks.where((t) => t.isCompleted ?? false).length;

    if (completedCount == 0) return ProjectCat.todo;
    if (completedCount < tasks.length) return ProjectCat.inProgress;
    return ProjectCat.completed;
  }

  List<ProjectModel> get filterProject {
    return allProjects.where((project) {
      final tasks = tasksByProject[project.id] ?? [];
      return categoryFromTasks(tasks) == selectCategory;
    }).toList();
  }

  List<ProjectModel> searchProjects = [];
  void searchProject(String value) {
    emit(SearchProjectLoading());
    searchProjects =
        allProjects
            .where(
              (project) =>
                  project.name.toLowerCase().startsWith(value.toLowerCase()),
            )
            .toList();
    emit(SearchProjectSuccess());
  }

  void changeCategory(ProjectCat category) {
    selectCategory = category;
    emit(ChangeCategorySuccess());
  }
}
