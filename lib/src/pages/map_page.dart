import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
      body: _createFlutterMap(scanModel)
    );
  }

  Widget _createFlutterMap(ScanModel scanModel) {
    return FlutterMap(
      options: MapOptions(
        center: scanModel.getLatLng(),
        zoom: 15
      ),
      layers: [
        _createMap(),
        _createMarkers(scanModel)
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken': 'pk.eyJ1IjoiY3Jpc3Rob3BlcjI1IiwiYSI6ImNrNHVkd3pibDBoOGQza3FiemM1b3VxYnYifQ.2goXCIK41LPitgh38vemCg',
          'id': 'mapbox.streets'
          //streets, dark, light, outdoors, satellite
        }
    );
  }

  _createMarkers(ScanModel scanModel) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scanModel.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );
  }
}
