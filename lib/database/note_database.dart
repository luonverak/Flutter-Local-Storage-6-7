import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  final String table = 'tbl_note';
  Future<Database> initializeData() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDir = await getApplicationDocumentsDirectory();
    String appPath = appDir.path;
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'data.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $table(id INTEGER PRIMARY KEY,title TEXT,description TEXT,date TEXT)',
        );
      },
    );
  }
}
