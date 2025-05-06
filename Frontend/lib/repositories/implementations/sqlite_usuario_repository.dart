import 'package:sqflite/sqflite.dart';
import '../interfaces/usuario_repository.dart';
import '../../models/usuario_model.dart';
import '../../database/database_helper.dart';

class SqliteUsuarioRepository implements UsuarioRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Usuario>> getAllUsers() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  @override
  Future<void> saveUser(Usuario user) async {
    final db = await dbHelper.database;
    await db.insert('usuarios', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateUser(Usuario user) async {
    final db = await dbHelper.database;
    await db.update('usuarios', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  @override
  Future<void> deleteUser(String id) async {
    final db = await dbHelper.database;
    await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}
