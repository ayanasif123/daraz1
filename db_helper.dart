import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper {
  static Database? _db;

  static Future<Database> database() async {
    if (_db != null) return _db!;
    

    String path = join(await getDatabasesPath(), 'notes.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            note TEXT,
            date TEXT
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insertNote(String title, String note, String date) async {
    final db = await database();
    await db.insert('notes', {'title': title, 'note': note, 'date': date});
    print("Inserted: $title | $note | $date"); // DEBUG
   print(insertNote(title, note, date));
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database();
    return db.query('notes', orderBy: 'id DESC');
  }

  static Future<void> updateNote(int id, String title, String note) async {
    final db = await database();
    await db.update('notes', {'title': title, 'note': note}, where: 'id=?', whereArgs: [id]);
    print(updateNote(id, title, note));
  }

  static Future<void> deleteNote(int id) async {
    final db = await database();
    await db.delete('notes', where: 'id=?', whereArgs: [id]);
    print(deleteNote(id));
  }
}
