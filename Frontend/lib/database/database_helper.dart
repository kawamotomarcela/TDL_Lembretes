import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _dbName = 'tasks_database.db';
  static const int _dbVersion = 1;

  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        titulo TEXT NOT NULL,
        data TEXT NOT NULL, -- ISO 8601 String (salvo como TEXT)
        categoria TEXT NOT NULL,
        prioridade INTEGER NOT NULL,
        status INTEGER NOT NULL, -- índice do enum StatusTarefa
        alarmeAtivado INTEGER NOT NULL -- 0 ou 1
      )
    ''');

    await db.execute('''
      CREATE TABLE usuarios (
        id TEXT PRIMARY KEY,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        telefone TEXT NOT NULL,
        pontos INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
    }
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
