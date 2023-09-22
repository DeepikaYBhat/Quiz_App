import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'quiz_scores.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scores (
            id INTEGER PRIMARY KEY,
            score INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertScore(int score) async {
    final db = await database;
    await db.insert(
      'scores',
      {'score': score},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<int>> getScores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('scores');
    return List.generate(maps.length, (i) {
      return maps[i]['score'] as int;
    });
  }
}
