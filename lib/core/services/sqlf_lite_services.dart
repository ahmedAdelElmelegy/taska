import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlfLiteServices {
  // create db
  late Database _database;
  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'taska.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        return await db.execute(
          'CREATE TABLE projects (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, done INTEGER )',
        );
      },
    );
    // Your database initialization logic here
  }

  // insert project
  Future<void> insertProject(String title) async {
    await _database.insert('projects', {
      'name': title,
      'done': 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // get all projects
  Future<List<Map<String, dynamic>>> getAllProjects() async {
    return await _database.query('projects');
  }

  // update project
  Future<void> updateProject(int id, String title) async {
    await _database.update(
      'projects',
      {'name': title},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // delete project
  Future<void> deleteProject(int id) async {
    await _database.delete('projects', where: 'id = ?', whereArgs: [id]);
  }
}
