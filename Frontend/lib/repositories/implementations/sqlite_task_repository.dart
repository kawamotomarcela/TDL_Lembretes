import 'package:sqflite/sqflite.dart';
import '../interfaces/task_repository.dart';
import '../../models/task_model.dart';
import '../../database/database_helper.dart';

class SqliteTaskRepository implements TaskRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  @override
  Future<void> saveTask(TaskModel task) async {
    final db = await dbHelper.database;
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final db = await dbHelper.database;
    await db.update('tasks', task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<void> deleteTask(String id) async {
    final db = await dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
