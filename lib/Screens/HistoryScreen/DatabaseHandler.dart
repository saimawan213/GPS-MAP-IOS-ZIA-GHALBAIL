import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  String dbName = "my_app";
  String userTable = "user";

  // Create a singleton instance of the database handler
  static final DatabaseHandler _instance = DatabaseHandler._internal();
  factory DatabaseHandler() => _instance;
  DatabaseHandler._internal();

  // Declare a database variable
  static Database? _database;

  // Initialize the database
  Future<Database?> get database async {
    if (_database != null) return _database;

    // If _database is null we instantiate it
    _database = await initializeDatabase();
    return _database;
  }

  // Initialize the database by opening a connection and creating tables (if not exists)
  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);
    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
          // create user table with fields (id autoincrement, username, password)
          await db.execute(
              "CREATE TABLE $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT, SourceLocation TEXT, DestinationLocation TEXT, SourceLog DOUBLE, SourceLath DOUBLE,DestinationLog DOUBLE,DestinationLath DOUBLE  )");
        });
  }

  // Add a new user to the database
  Future<int> addUser(User user) async {
    final db = await database;
    int result = await db!.insert(userTable, user.toMap());
    return result;
  }

  // Update an existing user in the database
  Future<int> updateUser(User user) async {
    final db = await database;
    int result = await db!
        .update(userTable, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete a user from the database
  Future<int> deleteUser(int id) async {
    final db = await database;
    int result = await db!.delete(userTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }
  Future<int> deleteAllUser() async {
    final db = await database;
    int result = await db!.delete(userTable);
    return result;
  }

  // Get all users from the database
  Future<List<User>> getUsers() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db!.query(userTable);
    List<User> users = [];
    for (var map in maps) {
      users.add(User.fromMap(map));
    }
    return users;
  }
}

// User model class
class User {
  int? id;
  String? SourceLocation;
  String? DestinationLocation;
  double? SourceLog;
  double? SourceLath;
  double? DestinationLog;
  double? DestinationLath;


  User({this.id, this.SourceLocation, this.DestinationLocation,this.SourceLog,this.SourceLath,this.DestinationLog,this.DestinationLath});

  // Convert User object to a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SourceLocation': SourceLocation,
      'DestinationLocation': DestinationLocation,
      'SourceLog': SourceLog,
      'SourceLath': SourceLath,
      'DestinationLog': DestinationLog,
      'DestinationLath': DestinationLath,

    };
    if (id != null) map['id'] = id;
    return map;
  }

  // Convert Map object to a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      SourceLocation: map['SourceLocation'],
      DestinationLocation: map['DestinationLocation'],
      SourceLog: map['SourceLog'],
      SourceLath: map['SourceLath'],
      DestinationLog: map['DestinationLog'],
      DestinationLath: map['DestinationLath'],

    );
  }
}
