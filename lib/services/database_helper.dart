import 'package:employee_management/features/employee_add/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  static const String databaseName = 'employee.db';

  static const int versionNumber = 1;

  static const String tableEmployee = 'Employee';

  static const String colId = 'id';
  static const String colEmpName = 'empName';
  static const String colEmpRole = 'empRole';
  static const String colEmpStartDate = 'empStartDate';
  static const String colEmpEndDate = 'empEndDate';
  static const String colEmpDeleteStatus = 'empDeleteStatus';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    var db =
        await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableEmployee ("
        " $colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $colEmpName TEXT NOT NULL, "
        " $colEmpRole TEXT NOT NULL, "
        " $colEmpStartDate TEXT NOT NULL, "
        " $colEmpEndDate TEXT NOT NULL, "
        " $colEmpDeleteStatus TEXT NOT NULL"
        ")");
  }

  Future<List<EmployeeModel>> getAll() async {
    final db = await database;
    final result = await db.query(tableEmployee, orderBy: '$colId ASC');
    return result.map((json) => EmployeeModel.fromJson(json)).toList();
  }

  Future<List<EmployeeModel>> getAllExceptDeleted() async {
    final db = await database;
    final result = await db.query(tableEmployee,
        orderBy: '$colId DESC',
        where: "$colEmpDeleteStatus != ?",
        whereArgs: ['1']);
    return result.map((json) => EmployeeModel.fromJson(json)).toList();
  }

  Future<EmployeeModel> read(int id) async {
    final db = await database;
    final maps = await db.query(
      tableEmployee,
      where: '$colId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return EmployeeModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<void> insert(EmployeeModel employee) async {
    final db = await database;
    await db.insert(tableEmployee, employee.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(EmployeeModel employee) async {
    final db = await database;
    var res = await db.update(tableEmployee, employee.toJson(),
        where: '$colId = ?', whereArgs: [employee.id]);
    return res;
  }

  Future<void> delete(int id) async {
    final db = await database;
    try {
      await db.delete(tableEmployee, where: "$colId = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
