import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const createDbScript = "CREATE TABLE server ("
    "sever_id INTEGER PRIMARY KEY,"
    "ip TEXT,"
    "port INTEGER,"
    "secret TEXT"
    ")";

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  initDb() async {
    Directory documetDirectory = await getApplicationDocumentsDirectory();
    String path = join(documetDirectory.path, 'data');

    return await openDatabase(path, onCreate: (Database db, int v) async {
      await db.execute(createDbScript);
    });
  }
}
