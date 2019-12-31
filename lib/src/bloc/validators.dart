import 'dart:async';

import 'package:qr_reader_flutter_app/src/models/scan_model.dart';

class Validators {
  final validateGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScan = scans.where((s) => s.type == 'geo').toList();
      sink.add(geoScan);
    }
  );

  final validateHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScan = scans.where((s) => s.type == 'http').toList();
      sink.add(geoScan);
    }
  );
}