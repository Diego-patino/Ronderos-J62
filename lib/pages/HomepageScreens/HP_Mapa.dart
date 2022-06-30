import 'package:flutter/material.dart';

class MapaRonderos extends StatefulWidget {
  const MapaRonderos({Key? key}) : super(key: key);

  @override
  State<MapaRonderos> createState() => _MapaRonderosState();
}

class _MapaRonderosState extends State<MapaRonderos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Text('MapaGoogle'),
      )),
    );
  }
}