import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'coursedb.dart';
import 'package:sqflite/sqflite.dart';

//creating a private constructor
class CoursedbDatabaseProvider {
  CoursedbDatabaseProvider._();

  static final CoursedbDatabaseProvider db = CoursedbDatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Coursedb.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Coursedb ("
            "id integer primary key AUTOINCREMENT,"
            "semester TEXT,"
            "code TEXT,"
            "credit TEXT,"
            "grade TEXT"
            ")");

        await db.execute("CREATE TABLE GPAdb ("
            "id integer primary key AUTOINCREMENT,"
            "semester TEXT,"
            "gpa TEXT,"
            "chr TEXT"
            ")");
      },
    );
  }

  addCoursedbToDatabase(Coursedb Coursedb) async {
    final db = await database;
    var raw = await db.insert(
      "Coursedb",
      Coursedb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateCoursedb(Coursedb Coursedb) async {
    final db = await database;
    var response = await db.update("Coursedb", Coursedb.toMap(),
        where: "id = ?", whereArgs: [Coursedb.id]);
    return response;
  }

  Future<Coursedb> getCoursedbWithId(int id) async {
    final db = await database;
    var response = await db.query("Coursedb", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Coursedb.fromMap(response.first) : null;
  }

  Future<List<Coursedb>> getAllCoursedbs() async {
    final db = await database;
    var response = await db.query("Coursedb");
    List<Coursedb> list = response.map((c) => Coursedb.fromMap(c)).toList();
    return list;
  }

  deleteCoursedbWithId(int id) async {
    final db = await database;
    return db.delete("Coursedb", where: "id = ?", whereArgs: [id]);
  }

  deleteCoursedbWithSemester(String semester) async {
    final db = await database;
    return db.delete("Coursedb", where: "semester = ?", whereArgs: [semester]);
  }

  deleteAllCoursedbs() async {
    final db = await database;
    db.delete("Coursedb");
  }

  //Function for the GPA table
  addGPAdbToDatabase(GPAdb GPAdb) async {
    final db = await database;
    var raw = await db.insert(
      "GPAdb",
      GPAdb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateGPAdb(GPAdb GPAdb) async {
    final db = await database;
    var response = await db
        .update("GPAdb", GPAdb.toMap(), where: "id = ?", whereArgs: [GPAdb.id]);
    return response;
  }

  Future<GPAdb> getGPAdbWithId(int id) async {
    final db = await database;
    var response = await db.query("GPAdb", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? GPAdb.fromMap(response.first) : null;
  }

  Future<List<GPAdb>> getAllGPAdbs() async {
    final db = await database;
    var response = await db.query("GPAdb");
    List<GPAdb> list = response.map((c) => GPAdb.fromMap(c)).toList();
    return list;
  }

  deleteGPAdbWithId(int id) async {
    final db = await database;
    return db.delete("GPAdb", where: "id = ?", whereArgs: [id]);
  }

  deleteGPAdbWithSemester(String semester) async {
    final db = await database;
    return db.delete("GPAdb", where: "semester = ?", whereArgs: [semester]);
  }

  deleteAllGPAdbs() async {
    final db = await database;
    db.delete("GPAdb");
  }
}
