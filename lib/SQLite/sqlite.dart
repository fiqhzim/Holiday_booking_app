import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tour_package_booking/JsonModels/tourbook.dart';
import 'package:tour_package_booking/JsonModels/users.dart';

class DatabaseHelper {
  final databaseName = "tourpackage.db";
  static const _databaseVersion = 2;

  // Create user table into sqlite db
  String usersTable = '''CREATE TABLE users (
        userid INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        email TEXT, 
        phone INTEGER, 
        username TEXT UNIQUE, 
        password TEXT,
        address TEXT
        )''';

  String tourbookTable = '''CREATE TABLE tourbook (
        bookid INTEGER PRIMARY KEY AUTOINCREMENT, 
        userid INTEGER NOT NULL, 
        bookdate DATE, 
        booktime TIME, 
        tourstartdate DATE, 
        tourenddate DATE, 
        tourpackage TEXT, 
        numpeople INTEGER, 
        packageprice DOUBLE,
        FOREIGN KEY (userid) REFERENCES users(userid)
        )''';

  String administratorTable = '''CREATE TABLE administrator (
        adminid INTEGER PRIMARY KEY AUTOINCREMENT, 
        username TEXT UNIQUE, 
        password TEXT
        )''';

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await initDB();
    return await db.query('users');
  }

  // Initialize database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // Create tables
  Future _onCreate(Database db, int version) async {
    await db.execute(usersTable);
    await db.execute(tourbookTable);
    await db.execute(administratorTable);
    await db.execute('''
          INSERT INTO administrator (username, password)
          VALUES ('admin', 'admin')
          ''');
  }

  // Upgrade database
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await _dropAllTables(db);
      await _onCreate(db, newVersion);
    }
  }

  // Drop all tables
  Future<void> _dropAllTables(Database db) async {
    await db.execute('DROP TABLE IF EXISTS users');
    await db.execute('DROP TABLE IF EXISTS tourbook');
    await db.execute('DROP TABLE IF EXISTS administrator');
  }

  // Login method
  Future<List<dynamic>> login(Users user) async {
    final Database db = await initDB();

    String role = 'user';
    // Check password
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE username = ? AND password = ?",
        [user.username, user.password]);
    List<Users> userDetails = await searchUser(user.username);
    if (result.isEmpty) {
      result = await db.rawQuery(
          "SELECT * FROM administrator WHERE username = ? AND password = ?",
          [user.username, user.password]);
      role = 'admin';
    }

    if (result.isNotEmpty) {
      return [true, role, role == 'admin' ? null : userDetails[0]];
    } else {
      return [false, role, null];
    }
  }

  // Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert('users', user.toMap());
  }

  // add book package
  Future<int> bookPackage(TourBook tourBook) async {
    final Database db = await initDB();
    return db.insert('tourbook', tourBook.toMap());
  }

  // query all user package book
  Future<List<TourBook>> getUserPackage(int? userid) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult =
        await db.rawQuery("select * from tourbook where userid = ?", [userid]);
    return searchResult.map((e) => TourBook.fromMap(e)).toList();
  }

  //Update user package
  Future<int> updateUserPackage(bookdate, booktime, tourstartdate, tourenddate, tourpackage, numpeople, packageprice, bookid) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update tourbook set bookdate = ?, booktime = ?, tourstartdate = ?, tourenddate = ?, tourpackage = ?, numpeople = ?, packageprice = ? where bookid = ?',
        [bookdate, booktime, tourstartdate, tourenddate, tourpackage, numpeople, packageprice, bookid]);
  }

  //Delete user package
  Future<int> deleteUserPackage(int bookid) async {
    final Database db = await initDB();
    return db.delete('tourbook', where: 'bookid = ?', whereArgs: [bookid]);
  }

  //Delete user
  Future<int> deleteUser(int userid) async {
    final Database db = await initDB();
    return db.delete('users', where: 'userid = ?', whereArgs: [userid]);
  }

  //Update User
  Future<int> updateUsers(name, email, phone, address, userid) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update users set name = ?, email = ?, phone = ?, address = ? where userid = ?',
        [name, email, phone, address, userid]);
  }

  //Search Method
  Future<List<Users>> searchUser(String username) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult =
        await db.rawQuery("select * from users where username = ?", [username]);
    return searchResult.map((e) => Users.fromMap(e)).toList();
  }

  Future<Users> getUser(int? userid) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult =
        await db.rawQuery("select * from users where userid = ?", [userid]);

    if (searchResult.isNotEmpty) {
      return Users.fromMap(searchResult.first);
    } else {
      throw Exception('User not found');
    }
  }
}
