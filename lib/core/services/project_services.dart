import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taska/data/model/body/board_model.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/data/model/body/sub_tasks_model.dart';
import 'package:taska/data/model/body/task_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:taska/data/model/comment_model.dart';

class ProjectServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = firebase_storage.FirebaseStorage.instance;

  Future<void> createProject({required ProjectModel projectModel}) async {
    _firestore
        .collection('projects')
        .doc(projectModel.id)
        .set(projectModel.toJson());
  }

  Future<List<ProjectModel>> getProjects() async {
    final snapshot =
        await _firestore
            .collection('projects')
            .where(
              'memberIds',
              arrayContains: FirebaseAuth.instance.currentUser!.uid,
            )
            .get();

    return snapshot.docs.map((e) => ProjectModel.fromJson(e.data())).toList();
  }

  // add deadline project
  Future<void> addDeadlineProject(
    String projectId,
    DateTime deadline,
    TimeOfDay time,
  ) async {
    final docRef = _firestore.collection('projects').doc(projectId);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({
        'deadline':
            DateTime(
              deadline.year,
              deadline.month,
              deadline.day,
              time.hour,
              time.minute,
            ).toIso8601String(),
      });
    } else {
      print('Document does not exist');
    }
  }
  // delete project

  Future<void> deleteProject(String projectId) async {
    final docRef = _firestore.collection('projects').doc(projectId);
    final doc = await docRef.get();

    if (doc.exists) {
      await deleteBoard(projectId);
      await docRef.delete();
    }
  }

  // update Color
  Future<void> updateProjectColor(String projectId, Color color) async {
    final docRef = _firestore.collection('projects').doc(projectId);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({'color': color.value});
    }
  }

  // delete board
  Future<void> deleteBoard(String projectId) async {
    final docRef = _firestore
        .collection('Boards')
        .where('projectId', isEqualTo: projectId);
    final doc = await docRef.get();

    if (doc.docs.isNotEmpty) {
      for (var element in doc.docs) {
        await element.reference.delete();
        await deleteTask(element.id);
      }
    }
  }

  // delete task
  Future<void> deleteTask(String boardId) async {
    final docRef = _firestore
        .collection('Tasks')
        .where('boardId', isEqualTo: boardId);
    final doc = await docRef.get();

    if (doc.docs.isNotEmpty) {
      for (var element in doc.docs) {
        await element.reference.delete();
        await deleteSubTask(element.id);
      }
    }
  }

  // delete subTask
  Future<void> deleteSubTask(String taskId) async {
    final docRef = _firestore
        .collection('subTasks')
        .where('taskId', isEqualTo: taskId);
    final doc = await docRef.get();

    if (doc.docs.isNotEmpty) {
      for (var element in doc.docs) {
        await element.reference.delete();
      }
    }
  }

  Future<void> addProjectCoverImage(String url, String projectId) async {
    final docRef = _firestore.collection('projects').doc(projectId);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({'coverImage': url});
    } else {
      print('Document does not exist');
    }
  }
  // edit project

  Future<void> editDescription(String projectId, String description) async {
    final docRef = _firestore.collection('projects').doc(projectId);
    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({'description': description});
    } else {
      print('Document does not exist');
    }
  }

  // add new board
  Future<void> addBoard(List<BoardModel> board) async {
    for (var element in board) {
      await _firestore
          .collection('Boards')
          .doc(element.id)
          .set(element.toJson());
    }
  }

  Future<List<BoardModel>> getBoard(String projectId) async {
    final snapshot =
        await _firestore
            .collection('Boards')
            .where('projectId', isEqualTo: projectId)
            .get();
    return snapshot.docs.map((e) => BoardModel.fromJson(e.data())).toList();
  }

  Future<void> addTasks(List<TaskModel> task) async {
    for (var element in task) {
      await _firestore
          .collection('Tasks')
          .doc(element.id)
          .set(element.toJson());
    }
  }

  Future<List<TaskModel>> getTasks(String boardId) async {
    final snapshot =
        await _firestore
            .collection('Tasks')
            .where('boardId', isEqualTo: boardId)
            .get();

    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  }

  // get tasks for project
  Future<List<TaskModel>> getTasksForProject(String projectId) async {
    final snapshot =
        await _firestore
            .collection('Tasks')
            .where('projectId', isEqualTo: projectId)
            .get();
    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  }

  // get project by id
  Future<List<ProjectModel>> getProjectByOwnerId(String ownerId) async {
    final snapshot =
        await _firestore
            .collection('projects')
            .where('ownerId', isEqualTo: ownerId)
            .get();
    return snapshot.docs.map((e) => ProjectModel.fromJson(e.data())).toList();
  }

  // get tasks by owner id
  Future<List<TaskModel>> getTasksByOwnerId(String ownerId) async {
    final snapshot =
        await _firestore
            .collection('Tasks')
            .where('ownerId', isEqualTo: ownerId)
            .get();
    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  }

  // get all tasks
  Future<List<TaskModel>> getAllTasks() async {
    final snapshot = await _firestore.collection('Tasks').get();
    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  }

  // get all today tasks
  Future<List<TaskModel>> getTodayTasks() async {
    final snapshot =
        await _firestore
            .collection('Tasks')
            .where(
              'dueDate',
              isEqualTo: DateTime.now().toIso8601String().split('T').first,
            )
            .get();
    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  }
  //  task completed?

  Future<void> updateTaskStatus(String taskId, bool status) async {
    await _firestore.collection('Tasks').doc(taskId).update({
      'isCompleted': status,
    });
  }

  Future<String?> uploadImage(File file) async {
    try {
      final ref = _storage.ref().child(
        'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  // subTask
  Future<void> addSubTasks(List<SubTasksModel> task) async {
    for (var element in task) {
      await _firestore
          .collection('subTasks')
          .doc(element.taskId)
          .collection('subTask')
          .doc(element.id)
          .set(element.toJson());
    }
  }

  Future<List<SubTasksModel>> getSubTasks(String taskId) async {
    final snapshot =
        await _firestore
            .collection('subTasks')
            .doc(taskId)
            .collection('subTask')
            .get();

    print("Found ${snapshot.docs.length} subTasks in task $taskId");
    return snapshot.docs.map((e) => SubTasksModel.fromjson(e.data())).toList();
  }

  // comments

  Future<void> addComments(List<CommentModel> comment) async {
    for (var element in comment) {
      await _firestore
          .collection('comments')
          .doc(element.taskId)
          .collection('comment')
          .doc(element.id)
          .set(element.toJson());
    }
  }
  // get all  comment

  Stream<List<CommentModel>> getComments(String taskId) {
    return _firestore
        .collection('comments')
        .doc(taskId)
        .collection('comment')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((e) => CommentModel.fromJson(e.data()))
                  .toList(),
        );
  }
}
