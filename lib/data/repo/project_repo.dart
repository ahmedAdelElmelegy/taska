import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:taska/core/error/firestore_error.dart';
import 'package:taska/core/services/project_services.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taska/data/model/body/sub_tasks_model.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:taska/data/model/comment_model.dart';

class ProjectRepo {
  final ProjectServices projectServices;
  ProjectRepo(this.projectServices);

  Future<Either<FirestoreFailure, void>> createProject({
    required ProjectModel projectModel,
  }) async {
    try {
      await projectServices.createProject(projectModel: projectModel);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, List<ProjectModel>>> getProjects() async {
    try {
      final projects = await projectServices.getProjects();
      print(projects.length);
      return right(projects);
    } on FirebaseException {
      rethrow;
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, List<ProjectModel>>> getProjectByOwnerId(
    String ownerId,
  ) async {
    try {
      final projects = await projectServices.getProjectByOwnerId(ownerId);
      return right(projects);
    } on FirebaseException {
      rethrow;
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, void>> addDeadlineProject(
    String projectId,
    DateTime deadline,
    TimeOfDay time,
  ) async {
    try {
      await projectServices.addDeadlineProject(projectId, deadline, time);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, void>> addBoard({
    required List<BoardModel> board,
  }) async {
    try {
      await projectServices.addBoard(board);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, List<BoardModel>>> getBoard(
    String projectId,
  ) async {
    try {
      final boards = await projectServices.getBoard(projectId);
      return right(boards);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, void>> addTask(List<TaskModel> tasks) async {
    try {
      await projectServices.addTasks(tasks);
      return right(null);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<Either<FirestoreFailure, void>> updateTaskStatus(
    String taskId,
    bool status,
  ) async {
    try {
      await projectServices.updateTaskStatus(taskId, status);
      return right(null);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<Either<FirestoreFailure, List<TaskModel>>> getTodayTasks() async {
    try {
      final tasks = await projectServices.getTodayTasks();
      return right(tasks);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, String>> uploadFile(File file) async {
    try {
      final downloadUrl = await projectServices.uploadImage(file);
      return right(downloadUrl!);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  Future<Either<FirestoreFailure, List<TaskModel>>> getTask(
    String boardId,
  ) async {
    try {
      final tasks = await projectServices.getTasks(boardId);
      return right(tasks);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<Either<FirestoreFailure, List<TaskModel>>> getTasksForProject(
    String projectId,
  ) async {
    try {
      final tasks = await projectServices.getTasksForProject(projectId);
      return right(tasks);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  // get all tasks
  Future<Either<FirestoreFailure, List<TaskModel>>> getAllTasks() async {
    try {
      final tasks = await projectServices.getAllTasks();
      return right(tasks);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }

  // get tasks by ownerId
  Future<Either<FirestoreFailure, List<TaskModel>>> getTasksByOwnerId(
    String ownerId,
  ) async {
    try {
      final tasks = await projectServices.getTasksByOwnerId(ownerId);
      return right(tasks);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (_) {
      return Left(
        FirestoreFailure('Unexpected error, please try again later.'),
      );
    }
  }
  // delete project

  Future<Either<FirestoreFailure, void>> deleteProject(String projectId) async {
    try {
      final result = await projectServices.deleteProject(projectId);
      return right(result);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    }
  }

  Future<Either<FirestoreFailure, void>> addProjectCoverImage(
    String url,
    String projectId,
  ) async {
    try {
      final result = await projectServices.addProjectCoverImage(url, projectId);
      return right(result);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    }
  }

  // update project color
  Future<Either<FirestoreFailure, void>> updateProjectColor(
    String projectId,
    Color color,
  ) async {
    try {
      final result = await projectServices.updateProjectColor(projectId, color);
      return right(result);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    }
  }

  // edit project
  Future<Either<FirestoreFailure, void>> editDescription(
    String projectId,
    String description,
  ) async {
    try {
      final result = await projectServices.editDescription(
        projectId,
        description,
      );
      return right(result);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    }
  }

  // subTask
  Future<Either<FirestoreFailure, void>> addSubTask(
    List<SubTasksModel> tasks,
  ) async {
    try {
      await projectServices.addSubTasks(tasks);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<FirestoreFailure, List<SubTasksModel>>> getSubTask(
    String taskId,
  ) async {
    try {
      final tasks = await projectServices.getSubTasks(taskId);
      return right(tasks);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (e) {
      return Left(FirestoreFailure('Unexpected error, $e'));
    }
  }

  Future<Either<FirestoreFailure, void>> addComments(
    List<CommentModel> comment,
  ) async {
    try {
      await projectServices.addComments(comment);
      return right(null);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    } catch (e) {
      rethrow;
    }
  }
  // get all comment

  Either<FirestoreFailure, Stream<List<CommentModel>>> getComments(
    String taskId,
  ) {
    try {
      final comments = projectServices.getComments(taskId);
      return right(comments);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.message ?? 'Firestore error occurred.'));
    }
  }
}
