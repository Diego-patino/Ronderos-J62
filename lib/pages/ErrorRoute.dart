import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class errorRoute extends StatefulWidget {
  const errorRoute({Key? key}) : super(key: key);

  @override
  State<errorRoute> createState() => errorRouteState();
}

class errorRouteState extends State<errorRoute> {
 final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourcelocation = LatLng(37.33500926, -122.03272188);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: Text("data"),
      ),
    );
  }
}