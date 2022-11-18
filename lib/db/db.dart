import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'storagekb.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  static _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
    );
  }
}
