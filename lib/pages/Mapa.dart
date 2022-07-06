import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaFamilia extends StatefulWidget {
  const MapaFamilia({Key? key}) : super(key: key);

  @override
  State<MapaFamilia> createState() => _MapaFamiliaState();
}

class _MapaFamiliaState extends State<MapaFamilia> {

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourcelocation = LatLng(-12.144372692833945, -76.98833718779387);

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      initialCameraPosition: CameraPosition(
        target: sourcelocation,
        zoom: 14.5,
        ),
      markers: {
        Marker(
          markerId: MarkerId("Casa"),
          position: sourcelocation )
      },);
  }
}