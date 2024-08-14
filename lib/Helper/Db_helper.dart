import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//SQFLite Connectivity

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'Register.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT,
            gender TEXT,
            mobile TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> registerUser(
      String username, String password, String mobile) async {
    final db = await database;
    return await db.insert(
      'users',
      {'username': username, 'password': password, 'mobile': mobile},
    );
  }

  Future<bool> checkUsernameExists(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return maps.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }
}
