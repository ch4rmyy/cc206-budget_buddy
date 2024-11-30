//opening and interacting to the database

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _userTableName = "user";
  final String _userIdColumnName = "id";
  final String _userEmailColumnName = "email";
  final String _userUsernameColumnName = "username";
  final String _userPassWordColumnName = "password";


  //to delete
  Future<void> printAllUsers() async {
  final db = await database;
  final List<Map<String, dynamic>> users = await db.query(_userTableName);

  print('Users in the database:');
  for (var user in users) {
    print('ID: ${user[_userIdColumnName]}, Email: ${user[_userEmailColumnName]}, Username: ${user[_userUsernameColumnName]}, Password: ${user[_userPassWordColumnName]}');
  }
}

  

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
          $_userUsernameColumnName TEXT NOT NULL
         
        )
        ''');

        //add another table here


      },
    );
    return database;
  }

  Future<void> addUser(String email, String username, String password) async {

    //to be delete
    print('Inserting user: email=$email, username=$username, password=$password');


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

  //gina check kung may ara...para sa SIGNUP
  Future<bool> checkUserExists(String username, String email) async {
  final db = await database; // Your SQLite database instance
  final result = await db.query(
    _userTableName, // Replace with your table name
    where: 'username = ? OR email = ?',
    whereArgs: [username, email],
  );

  return result.isNotEmpty; // Return true if a user exists, otherwise false
}

//gina check kung may ara...para sa LOGIN
Future<Map<String, dynamic>?> getUserEmailAndPassword(String email, String password) async {
  final db = await database;
  final result = await db.query(
    _userTableName,
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );

  if (result.isNotEmpty) {
    return result.first; // Return the first matching user
  }
  return null; // No match found
}


}