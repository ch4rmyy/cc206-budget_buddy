import 'package:cc206_budget_buddy/features/components.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';


class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _userTableName = "user";
  final String _userIdColumnName = "id";
  final String _userEmailColumnName = "email";
  final String _userUsernameColumnName = "username";
  final String _userPassWordColumnName = "password";
  final String _userTotalExpenseColumnName = "totalexpense";
  final String _userTotalBudgetColumnName = "totalbudget";

  final String _budgetTableName = "budget";
  final String _budgetIdColumnName = "bid";
  final String _budgetUserIdColumnName = "user_id"; 
  final String _budgetAmountColumnName = "bamount";
  final String _budgetDateColumnName = "bdate";

  final String _expenseTableName = "expense";
  final String _expenseIdColumnName = "eid";
  final String _expenseUserIdColumnName = "user_id"; 
  final String _expenseAmountColumnName = "amount";
  final String _expenseCategoryColumnName = "category";
  final String _expenseDateColumnName = "date";

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "tid";
  final String _tasksUserIdColumnName = "user_id"; 
  final String _tasksDescriptionColumnName = "description";
  final String _tasksDateColumnName = "tdate";

  


  //to be delete
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

    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
  databasePath,
  version: 4, 
  onCreate: (db, version) {

    db.execute('''
    CREATE TABLE IF NOT EXISTS $_userTableName(
      $_userIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $_userEmailColumnName TEXT NOT NULL,
      $_userPassWordColumnName TEXT NOT NULL,
      $_userUsernameColumnName TEXT NOT NULL,
      $_userTotalExpenseColumnName REAL DEFAULT 0,
      $_userTotalBudgetColumnName REAL DEFAULT 0
    )
    ''');

    db.execute('''
    CREATE TABLE IF NOT EXISTS $_budgetTableName(
      $_budgetIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $_budgetUserIdColumnName INTEGER NOT NULL,
      $_budgetAmountColumnName REAL NOT NULL,
      $_budgetDateColumnName TEXT NOT NULL,
      FOREIGN KEY ($_budgetUserIdColumnName) REFERENCES $_userTableName($_userIdColumnName)
    )
    ''');

    db.execute('''
    CREATE TABLE IF NOT EXISTS $_expenseTableName(
      $_expenseIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $_expenseUserIdColumnName INTEGER NOT NULL,
      $_expenseAmountColumnName REAL NOT NULL,
      $_expenseCategoryColumnName TEXT NOT NULL,
      $_expenseDateColumnName TEXT NOT NULL,
      FOREIGN KEY ($_expenseUserIdColumnName) REFERENCES $_userTableName($_userIdColumnName)
    )
    ''');

    db.execute('''
    CREATE TABLE IF NOT EXISTS $_tasksTableName(
      $_tasksIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $_tasksUserIdColumnName INTEGER NOT NULL,
      $_tasksDescriptionColumnName TEXT NOT NULL,
      $_tasksDateColumnName TEXT NOT NULL,
      FOREIGN KEY ($_tasksUserIdColumnName) REFERENCES $_userTableName($_userIdColumnName)
      )
    ''');

  },

);




  final tasks = await database.rawQuery('SELECT * FROM $_tasksTableName');
  print ('TASKS: $tasks');
  final tables = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
  print('Existing tables: $tables');



    return database;
    
}


  Future<void> checkTableInfo() async {
  final db = await database;
  final budgetTableInfo = await db.rawQuery('PRAGMA table_info($_budgetTableName)');
  final expenseTableInfo = await db.rawQuery('PRAGMA table_info($_expenseTableName)');
  final version = await db.rawQuery('PRAGMA user_version');
  print('Database version: ${version.first['user_version']}');
  print('Budget Table Info: $budgetTableInfo');
  print('Expense Table Info: $expenseTableInfo');
}

Future<void> printAllExpenses() async {
  final db = await database;
  final List<Map<String, dynamic>> expenses = await db.query(_expenseTableName);

  print('Expenses in the database:');
  for (var expense in expenses) {
    print('ID: ${expense[_expenseIdColumnName]}, User ID: ${expense[_expenseUserIdColumnName]}, Amount: ${expense[_expenseAmountColumnName]}, Category: ${expense[_expenseCategoryColumnName]}, Date: ${expense[_expenseDateColumnName]}');
  }
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

  //gina check kung may ara...para sa SIGNUP
  Future<bool> checkUserExists(String username, String email) async {
  final db = await database; 
  final result = await db.query(
    _userTableName, 
    where: 'username = ? OR email = ?',
    whereArgs: [username, email],
  );

  return result.isNotEmpty; 
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
    return result.first; 
  }
  return null; 
}


Future<void> addExpense(int userId, double amount, String category) async {
  final db = await database;
  print('Adding budget: userId=$userId, amount=$amount, category: $category');
  await db.insert(
    _expenseTableName,
    {
      'user_id': userId, 
      'amount': amount,
      'category': category,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


// Get total expenses for a user
Future<double> getTotalExpenses(int userId) async {
  final db = await database;
  final result = await db.query(
    _expenseTableName,
    columns: ['SUM($_expenseAmountColumnName)'],
    where: '$_expenseUserIdColumnName = ?',
    whereArgs: [userId],
  );
print('Query Result: $result');
  if (result.isNotEmpty && result.first.values.first != null) {
    return result.first.values.first as double; // Return the sum of expenses
  }
  return 0.0; // Return 0 if no expenses found
}

// Update total expense for a user
Future<void> updateTotalExpense(int userId, double totalExpense) async {
  final db = await database;
  await db.update(
    _userTableName,
    { _userTotalExpenseColumnName: totalExpense },
    where: '$_userIdColumnName = ?',
    whereArgs: [userId],
  );
}

Future<void> addBudget(int userId,double bamount) async {
  final db = await database;

  await db.insert(
    _budgetTableName,
    {
      'user_id': userId, 
      'bamount': bamount,
      'bdate': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


Future<double> getTotalBudget(int userId) async {
  final db = await database;
  final result = await db.query(
    _budgetTableName,
    columns: ['SUM($_budgetAmountColumnName)'],
    where: '$_budgetUserIdColumnName = ?',
    whereArgs: [userId],
  );
print('Query Result: $result');
  if (result.isNotEmpty && result.first.values.first != null) {
    return result.first.values.first as double; // Return the sum of expenses
  }
  return 0.0; // Return 0 if no expenses found
}

Future<void> updateTotalBudget(int userId, double totalBudget) async {
  final db = await database;
  await db.update(
    _userTableName,
    { _userTotalBudgetColumnName: totalBudget },
    where: '$_userIdColumnName = ?',
    whereArgs: [userId],
  );
}


Future<int?> getUserId(String username) async {
  final db = await database;
  final result = await db.query(
    _userTableName,
    columns: [_userIdColumnName], // Fetch only the ID
    where: '$_userUsernameColumnName = ?',
    whereArgs: [username],
    limit: 1,
  );

  if (result.isNotEmpty) {
    return result.first[_userIdColumnName] as int; // Return the ID
  }
  return null; // User not found
}


Future<Map<String, dynamic>?> getUserIdByUsername(String username) async {
  final db = await database;

  final List<Map<String, dynamic>> result = await db.query(
    _userTableName,
    where: '$_userUsernameColumnName = ?', 
    whereArgs: [username],
  );

  if (result.isNotEmpty) {
    return result.first;
  }
  return null; // No user found
}

Future<double> getTotalSpendingForCategory(int userId, String category) async {
  final db = await database;

  final result = await db.rawQuery('''
    SELECT SUM($_expenseAmountColumnName) AS total
    FROM $_expenseTableName
    WHERE $_expenseUserIdColumnName = ? AND $_expenseCategoryColumnName = ?
  ''', [userId, category]);

  if (result.isNotEmpty) {
    final total = result.first['total'];
    return total != null ? double.parse(total.toString()) : 0.0;
  }

  return 0.0; // Return 0 if no expenses found for specific category
}


Future<List<Map<String, dynamic>>> getTransactionHistory(int userId) async {
  final db = await database;

  final result = await db.rawQuery('''
SELECT 
  'Expense' AS type, 
  IFNULL($_expenseAmountColumnName, 0) AS value, 
  IFNULL($_expenseCategoryColumnName, 'Uncategorized') AS category, 
  $_expenseDateColumnName AS date
FROM $_expenseTableName
WHERE $_expenseUserIdColumnName = ?
UNION ALL
SELECT 
  'Budget' AS type, 
  IFNULL($_budgetAmountColumnName, 0) AS value, 
  'Budget' AS category, -- Default "Uncategorized" budgets to "Budget"
  $_budgetDateColumnName AS date
FROM $_budgetTableName
WHERE $_budgetUserIdColumnName = ?
ORDER BY date DESC

  ''', [userId, userId]);

  print('Fetched transactions: $result');
  return result; // Return combined transaction history
}

Future<int?> getUserIdFromEmailAndPassword(String email, String password) async {
  final db = await database; // Access the database
  final result = await db.query(
    _userTableName, 
    columns: [_userIdColumnName], 
    where: '$_userEmailColumnName = ? AND $_userPassWordColumnName = ?', 
    whereArgs: [email, password],
    limit: 1, 
  );

  if (result.isNotEmpty) {
    return result.first[_userIdColumnName] as int; 
  }
  return null; 
}

Future<int> addPlans(int userId,String description, DateTime selectedDate) async {
  final db = await database;

  try{
    final tid = await db.insert(
    _tasksTableName,
    {
      'user_id': userId, 
      'description': description,
      'tdate': DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Plan addd with ID: $tid');

    return tid;

  }catch(e){
    print('error adding plan: $e');
    throw Exception('Error adding plan');
  }
}

Future<void> deletePlan(int tid) async {
    final db = await database;

    try {
      final result = await db.delete(
        _tasksTableName, 
        where: '$_tasksIdColumnName = ?', 
        whereArgs: [tid],
      );

      if(result > 0){
      print('Task with ID $tid deleted successfully.');
      }else{
        print('No task found with ID $tid to delete.');
      }
      
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  Future<List<Event>> getEventsForDate(DateTime selectedDate) async {
  final db = await database; 

  final formattedDate = selectedDate.toIso8601String().split('T')[0];

  try {
    final List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'tdate = ?', // Exact match sa date
      whereArgs: [formattedDate],
    );

    return result.map((task) => Event.fromMap(task)).toList();
  } catch (e) {
    print('Error fetching events for $formattedDate: $e');
    return [];
  }
}


  Future<List<Event>> getAllTasks() async {
  final db = await database;

  try {
    final result = await db.query(_tasksTableName);

    // Convert to list of Event objects
    List<Event> tasks = result.map((task) {
      return Event.fromMap(task);
    }).toList();

    return tasks;
  } catch (e) {
    print('Error retrieving tasks: $e');
    return [];
  }
}


}