import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qr_reader_flutter_app/src/models/scan_model.dart';
export 'package:qr_reader_flutter_app/src/models/scan_model.dart';

class DBProvider{

  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Scans ('
            '  id INTEGER PRIMARY KEY,'
            '  type TEXT,'
            '  value TEXT'
            ')'
        );
      }
    );
  }


  // CREATE Register
  Future<int> newScanRaw(ScanModel scanModel) async {
    final db = await database;

    final response = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES ( ${scanModel.id}, '${scanModel.type}', '${scanModel.value}' )"
    );

    return response;
  }

  Future<int> newScan(ScanModel scanModel) async{
    final db = await database;

    final response = await db.insert('Scans', scanModel.toJson());

    return response;
  }

  // SELECT - get information
  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final response = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  Future< List<ScanModel> > getAllScan() async {
    final db = await database;

    final response = await db.query('Scans');

    List<ScanModel> list =  response.isNotEmpty
                            ? response.map((scan) => ScanModel.fromJson(scan)).toList()
                            : [];

    return list;
  }

  Future< List<ScanModel> > getScanByType(String type) async {
    final db = await database;

    final response = await db.rawQuery("SELECT * FROM Scans where type = '$type'");

    List<ScanModel> list =  response.isNotEmpty
        ? response.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return list;
  }

  //Update register
  Future<int> updateScan(ScanModel scanModel) async{
    final db = await database;

    final response = await db.update('Scans', scanModel.toJson(), where: 'id = ?', whereArgs: [scanModel.id]);

    return response;
  }

  //Delete registers
  Future<int> deleteScan(int id) async {
    final db = await database;

    final response = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return response;
  }

  Future<int> deleteAllScan() async {
    final db = await database;

    final response = await db.rawDelete("DELETE FROM Scans");

    return response;
  }
}