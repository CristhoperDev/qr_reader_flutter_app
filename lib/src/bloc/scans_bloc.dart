import 'dart:async';

import 'package:qr_reader_flutter_app/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Get scan from database
    getScans();

  }

  final _scansController = StreamController< List<ScanModel> >.broadcast();

  Stream< List<ScanModel> > get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add( await DBProvider.db.getAllScan() );
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScan() async {
    await DBProvider.db.deleteAllScan();
    getScans();
  }
}