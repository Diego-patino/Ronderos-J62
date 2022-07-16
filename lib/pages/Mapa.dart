import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Familia.dart';
import '../models/Users.dart';
import '../models/ubi_familia.dart';

class MapaFamilia extends StatefulWidget {
  const MapaFamilia({Key? key}) : super(key: key);

  @override
  State<MapaFamilia> createState() => _MapaFamiliaState();
}

class _MapaFamiliaState extends State<MapaFamilia> {

   UbiFamilia ubiFamilia = UbiFamilia();
   late GoogleMapController mycontroller;
   final Completer<GoogleMapController> controller2 = Completer();
   Map<MarkerId, Marker> markers1 = <MarkerId, Marker>{};
   Familiamodel familiamodel = Familiamodel();
   UserModel Usuario_logeado = UserModel();
   late String imagenURL;
   late int numerito;
   final user= FirebaseAuth.instance.currentUser!;
  late LatLng usuariolocal;

  static const LatLng sourcelocation = LatLng(-12.144372692833945, -76.98833718779387);

  @override
    void initState() {
      getUserCurrentPosition();
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          Usuario_logeado = UserModel.fromMap(value.data());
          setState(() {});
        
        FirebaseFirestore.instance
            .collection("Urbanizaciones")
            .doc(Usuario_logeado.urbanizacion)
            .collection("Familias")
            .doc(Usuario_logeado.familia)
            .collection("Miembros")
            .doc(Usuario_logeado.uid)
            .get()
            .then((value) {
          familiamodel = Familiamodel.fromMap(value.data());
          print("LA URBI ES AAAAAAAAAAAAAAAA:  ${Usuario_logeado.urbanizacion}");
          getMarkerData();
          setState(() {});
        });
        });
        super.initState();
      }

  // void initMarker(specify, specifyId) async{
  //   var markerIdVal = specifyId;
  //   final MarkerId markerId = MarkerId(markerIdVal);
  //   final Marker marker = Marker(
  //     markerId: markerId,
  //     position: LatLng(specify['location'].latitude, specify['location'].longitude),
  //     infoWindow: InfoWindow(title: 'Familia', snippet: specify['address']),
  //     );
  //     setState(() {
  //       markers1[markerId] = marker;
  //     });
  // }
  // getMarkerData() async{
  //   FirebaseFirestore.instance.collection("Familias").get().then((mymockDoc){
  //     if (mymockDoc.docs.isNotEmpty) {
  //       print("Comenzamos");
  //       for (int i = 0; i < mymockDoc.docs.length; i++) {;
  //         initMarker(mymockDoc.docs[i].data(), mymockDoc.docs[i].id);
  //         print("A VER QUE PASO AQUI: ${mymockDoc.docs.length.toString()}");
  //       }
  //     } else{
  //       print("RECONTRA MAAAAAAAAAAAL");
  //     }
  //   });
  // }

  Future getUserCurrentPosition() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("ERROR"+ error.toString());
    });

    return await Geolocator.getCurrentPosition().then((value){
      setState(() {
        usuariolocal = LatLng(value.latitude, value.longitude);
        print("LOCALIZACION: ${usuariolocal.latitude} ${usuariolocal.longitude}");
        mycontroller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: usuariolocal,
              zoom: 16.5)
          )
        );
      });
    });

  }


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
    print("VAMOS BIEN VAMOS BIEN VAMOS BIEN");
    print(Usuario_logeado.urbanizacion);      
      getfamiliaposition();
      FirebaseFirestore.instance.collection("Urbanizaciones").doc(Usuario_logeado.urbanizacion).collection("Familias").get().then((mymockDoc){
        if (mymockDoc.docs.isNotEmpty) {
          print("Comenzamos");
            for (int i = 0; i < mymockDoc.docs.length; i++) {
                initMarker(mymockDoc.docs[i].data(), mymockDoc.docs[i].id);
                print("A VER QUE PASO AQUI: ${mymockDoc.docs.length.toString()}");
              }
        } else{
          print("RECONTRA MAAAAAAAAAAAL");
        }
      
      });
    }



  Future getfamiliaposition() async{
    print("A VER LOCO QUE ESTA PASANDO");
    FirebaseFirestore.instance
            .collection("Urbanizaciones")
            .doc(Usuario_logeado.urbanizacion)
            .get()
            .then((value) {
          this.ubiFamilia = UbiFamilia.fromMap(value.data());
          print("POSITION DE LA FAMILY ${ubiFamilia.localization!.latitude} ${ubiFamilia.localization!.longitude}");
          
            mycontroller.animateCamera( 
            CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(ubiFamilia.localization!.latitude, ubiFamilia.localization!.longitude), zoom: 18) 
              //17 is new zoom level
            )
          );
          setState(() {});
        });
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
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
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