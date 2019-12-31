import 'dart:async';

import 'package:qr_reader_flutter_app/src/bloc/validators.dart';
import 'package:qr_reader_flutter_app/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Get scan from database
    getScans();

  }

  final _scansController = StreamController< List<ScanModel> >.broadcast();

  Stream< List<ScanModel> > get scansStream => _scansController.stream.transform(validateGeo);
  Stream< List<ScanModel> > get scansStreamHttp => _scansController.stream.transform(validateHttp);

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add( await DBProvider.db.getAllScan() );
  }

  insertScan(ScanModel scanModel) async {
    await DBProvider.db.newScan(scanModel);
    getScans();
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