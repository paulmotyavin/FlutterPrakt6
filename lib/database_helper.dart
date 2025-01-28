import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'film.dart';

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
    String path = join(await getDatabasesPath(), 'films.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE films(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, poster TEXT, year TEXT, genre TEXT, director TEXT)',
        );
      },
    );
  }

  Future<void> insertFilm(Film film) async {
    final db = await database;
    await db.insert(
      'films',
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<String> getDatabasePath() async {
    String path = join(await getDatabasesPath(), 'films.db');
    print('Database path: $path');
    return path;
  }
  Future<List<Film>> films() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('films');

    return List.generate(maps.length, (i) {
      return Film(
        id: maps[i]['id'],
        title: maps[i]['title'],
        poster: maps[i]['poster'],
        year: maps[i]['year'],
        genre: maps[i]['genre'],
        director: maps[i]['director'],
      );
    });
  }

  Future<void> updateFilm(Film film) async {
    final db = await database;
    await db.update(
      'films',
      film.toMap(),
      where: 'id = ?',
      whereArgs: [film.id],
    );
  }

  Future<void> deleteFilm(int id) async {
    final db = await database;
    await db.delete(
      'films',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}