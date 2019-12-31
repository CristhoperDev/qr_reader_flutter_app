import 'package:flutter/material.dart';
import 'package:qr_reader_flutter_app/src/models/scan_model.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coords QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text(scanModel.value),
      ),
    );
  }
}
