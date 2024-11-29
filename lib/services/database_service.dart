//opening and interacting to the database

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _userTableName = "user";
  final String _userIdColumnName = "id";
  final String _userEmailColumnName = "email";
  final String _userUsernameColumnName = "username";
  final String _userPassWordColumnName = "password";
  

  DatabaseService._constructor();

  Future<Database> get database async{
    if (_db != null)  return _db!;
    _db = await getDataBase();
    return _db!;
  }

  Future<Database> getDataBase() async {

    // Get a location using getDatabasesPath
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    //open the database
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
         // When creating the db, create the table
        db.execute('''
        CREATE TABLE $_userTableName(
          $_userIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_userEmailColumnName TEXT NOT NULL,
          $_userPassWordColumnName TEXT NOT NULL,
          $_userUsernameColumnName TEXT NOT NULL,
         
        )
        ''');

        //add another table here


      },
    );
    return database;
  }

  Future<void> addUser(String email, String username, String password) async {
    final db = await database;
    await db.insert(
      _userTableName,
      {
        _userEmailColumnName: email,
        _userUsernameColumnName: username,
        _userPassWordColumnName: password,
      },
    );
  }
}