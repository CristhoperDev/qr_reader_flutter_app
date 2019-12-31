import 'package:flutter/material.dart';
import 'package:qr_reader_flutter_app/src/pages/directions_page.dart';
import 'package:qr_reader_flutter_app/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(_currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
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
