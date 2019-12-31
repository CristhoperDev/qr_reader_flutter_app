import 'package:qr_reader_flutter_app/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(ScanModel scanModel) async {
  if (scanModel.type == 'http') {
    if (await canLaunch(scanModel.value)) {
      await launch(scanModel.value);
    } else {
      throw 'Could not launch ${scanModel.value}';
    }
  } else {
    print('GEO...');
  }
}