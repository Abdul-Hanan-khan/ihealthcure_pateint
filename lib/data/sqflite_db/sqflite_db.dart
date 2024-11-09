// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tabib_al_bait/data/localDB/local_db.dart';
import '../../models/health_summary_model/health_summary_model.dart';

class SqfliteDB {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'healthSummary';
  static const columnId = 'id';
  static const columnPatientId = 'patientId';
  static const columnValue = 'value';
  static const columnValue1 = 'value1';
  static const columnCondition = 'condition';
  static const columnDateTime = 'dateTime';
  static const columnTitle = 'title';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    log(_db.toString());
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table(
            $columnId TEXT PRIMARY KEY,
            $columnPatientId TEXT NOT NULL,
            $columnValue TEXT NOT NULL,
            $columnValue1 TEXT NOT NULL,
            $columnCondition, TEXT NULL,
            $columnDateTime TEXT NOT NULL,
            $columnTitle TEXT NOT NULL
          )
          ''');

    log("Table Created");
  }

  Future<int> insert(HealthModel? row) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(path);
    log(db.toString());
    try {
      log(row!.toMap().toString());
      var result = await db.insert(
        table,
        row.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      row = HealthModel();
      return result;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    String? patientId = await LocalDb().getPatientId();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(path);
    var list =
        await db.query(table, where: 'patientId =?', whereArgs: [patientId]);
    log(list.toString());
    return list;
  }

  Future<List<HealthModel>> queryAllRowsBasedOnTitle(String? title) async {
    if (title == 'الجلوكوز') {
      title = 'Glucose';
    }
    String? patientId = await LocalDb().getPatientId();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(path);

    List<Map<String, dynamic>> list = await db.query(table,
        where: 'patientId = ? AND title = ?', whereArgs: [patientId, title]);

    List<HealthModel> healthList = list.map((row) {
      return HealthModel(
        condition: row['condition'],
        patientId: row['patientId'],
        value1: row['value1'],
        id: row['id'],
        title: row['title'],
        value: row['value'],
        dateTime: row['dateTime'],
      );
    }).toList();

    return healthList;
  }

  Future<HealthModel> getLastHealthModelWithTitle(String title) async {
    String? patientId = await LocalDb().getPatientId();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(path);

    final result = await db.query(
      table,
      where: 'title = ? AND patientId =?',
      whereArgs: [title, patientId],
    );

    if (result.isNotEmpty) {
      return HealthModel.fromJson(result.last);
    } else {
      return HealthModel();
    }
  }

  Future<HealthModel>? getLastFastingAndNormalValue(
      String title, String condition) async {
    if (title == 'الجلوكوز') {
      title = 'Glucose';
    }
    if (condition == 'طبيعي') {
      condition = 'Normal';
    }
    if (condition == 'صيام') {
      condition = 'Fasting';
    }
    String? patientId = await LocalDb().getPatientId();
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(path);
    final result = await db.query(
      table,
      where: 'title = ? AND patientId =? AND condition = ?',
      whereArgs: [title, patientId, condition],
    );

    if (result.isNotEmpty) {
      return HealthModel.fromJson(result.last);
    } else {
      return HealthModel(); // No matching record found
    }
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
