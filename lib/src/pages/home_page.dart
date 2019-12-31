import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader_flutter_app/src/models/scan_model.dart';
import 'package:qr_reader_flutter_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_flutter_app/src/pages/directions_page.dart';
import 'package:qr_reader_flutter_app/src/pages/maps_page.dart';
import 'package:qr_reader_flutter_app/src/utils/utils.dart' as utils;

import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scanBloc = ScansBloc();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => scanBloc.deleteAllScan(),
          )
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () =>_scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    // https://cristhoper.dev
    // geo:40.67425780940018,-73.96748915156252

    String futureString = 'https://cristhoper.dev';
    /*try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }*/

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      //DBProvider.db.newScan(scan);
      scanBloc.insertScan(scan);

      final scan2 = ScanModel(value: 'geo:40.67425780940018,-73.96748915156252');
      //DBProvider.db.newScan(scan);
      scanBloc.insertScan(scan2);
      
      if (Platform.isIOS) {
        Future.delayed(Duration(microseconds: 750));
        utils.openScan(context, scan);
      } else {
        utils.openScan(context, scan);
      }

    }
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0: return MapsPage(); break;
      case 1: return DirectionsPage(); break;
      default:
        return MapsPage();
    }
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        )
      ],
    );
  }
}
