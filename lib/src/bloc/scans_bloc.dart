import 'dart:async';

import 'package:qr_reader_flutter_app/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Get scan from database

  }

  final _scansController = StreamController< List<ScanModel> >.broadcast();

  Stream< List<ScanModel> > get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }
}