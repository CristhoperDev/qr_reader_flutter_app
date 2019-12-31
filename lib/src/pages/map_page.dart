import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader_flutter_app/src/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = MapController();
  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coords QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapController.move(scanModel.getLatLng(), 15);
            },
          ),
        ],
      ),
      body: _createFlutterMap(scanModel),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        //streets, dark, light, outdoors, satellite

        switch (mapType) {
          case 'streets':
            mapType = 'dark';break;
          case 'dark':
            mapType = 'light';break;
          case 'light':
            mapType = 'outdoors';break;
          case 'outdoors':
            mapType = 'satellite';break;
          default:
            mapType = 'streets';break;
        }

        setState(() {});
      },
    );
  }

  Widget _createFlutterMap(ScanModel scanModel) {
    return FlutterMap(
      mapController: mapController,
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
          'id': 'mapbox.$mapType'
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
