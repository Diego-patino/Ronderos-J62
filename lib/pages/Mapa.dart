import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaFamilia extends StatefulWidget {
  const MapaFamilia({Key? key}) : super(key: key);

  @override
  State<MapaFamilia> createState() => _MapaFamiliaState();
}

class _MapaFamiliaState extends State<MapaFamilia> {

  late GoogleMapController mycontroller;
  final Completer<GoogleMapController> controller2 = Completer();
  Map<MarkerId, Marker> markers1 = <MarkerId, Marker>{};

  static const LatLng sourcelocation = LatLng(-12.144372692833945, -76.98833718779387);


  void initMarker(specify, specifyId) async{
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: 'Familia', snippet: specify['address']),
      );
      setState(() {
        markers1[markerId] = marker;
      });
  }
  getMarkerData() async{
    FirebaseFirestore.instance.collection("Familias").get().then((mymockDoc){
      if (mymockDoc.docs.isNotEmpty) {
        print("Comenzamos");
        for (int i = 0; i < mymockDoc.docs.length; i++) {;
          initMarker(mymockDoc.docs[i].data(), mymockDoc.docs[i].id);
          print("A VER QUE PASO AQUI: ${mymockDoc.docs.length.toString()}");
        }
      } else{
        print("RECONTRA MAAAAAAAAAAAL");
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    // TODO: implement initState
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    /*
    Set<Marker> GetMarker(){
      return <Marker>[
        Marker(
          markerId: MarkerId("value"),
          position: LatLng(-12.144372692833945, -76.98833718779387),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "tumama"),
          )
      ].toSet();
    }
    */
    return  Scaffold(
      body: GoogleMap(

        initialCameraPosition: CameraPosition(
          
          target: sourcelocation,
          zoom: 14.5,
          ),
          onMapCreated: (GoogleMapController controller){
            mycontroller = controller;
          },
        markers: Set<Marker>.of(markers1.values)
        ),
    );
  }
}