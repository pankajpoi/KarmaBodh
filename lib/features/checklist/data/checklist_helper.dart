import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChecklistDB {

  static Database? _db;

  static Future<Database> get database async {

    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  static Future<Database> initDB() async {

    String path = join(
      await getDatabasesPath(),
      'ritual_checklist.db',
    );

    return openDatabase(

      path,

      version: 1,

      onCreate: (db, version) async {

        await db.execute('''
        CREATE TABLE checklist(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          isDone INTEGER
        )
        ''');
      },
    );
  }

  static Future<void> saveChecklistItems(
      List<String> items,
      ) async {

    final db = await database;

    for (String item in items) {

      await db.insert(
        'checklist',
        {
          'title': item,
          'isDone': 0,
        },
      );
    }
  }

  static Future<List<Map<String, dynamic>>> getItems() async {

    final db = await database;

    return db.query('checklist');
  }

  static Future<void> updateItem(
      int id,
      int value,
      ) async {

    final db = await database;

    await db.update(
      'checklist',
      {'isDone': value},
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteItem(int id) async {

    final db = await database;

    await db.delete(
      'checklist',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}