import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ronderos/pages/ReportarDelito.dart';

import '../models/Familia.dart';
import '../models/Users.dart';
import '../models/ubi_familia.dart';

class AvisoAlerta extends StatefulWidget {
  const AvisoAlerta({Key? key}) : super(key: key);

  @override
  State<AvisoAlerta> createState() => _AvisoAlertaState();
}

class _AvisoAlertaState extends State<AvisoAlerta> {

  Map<MarkerId, Marker> markers1 = <MarkerId, Marker>{};
  late GoogleMapController mycontroller;
  UbiFamilia ubiFamilia = UbiFamilia();
  Familiamodel familiamodel = Familiamodel();
  UserModel Usuario_logeado = UserModel();
  final user= FirebaseAuth.instance.currentUser!;
  late LatLng usuariolocal;
  @override
    void initState() {
      print("TENGO SUEÑO");
        super.initState();
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
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
          this.familiamodel = Familiamodel.fromMap(value.data());
          setState(() {});
          print("JAJAJAJAJJAJAJAJA ${familiamodel.urbanizacion}");
          getMarkerData();
        });
        });
      }
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
      FirebaseFirestore.instance.collection("Urbanizaciones").doc(familiamodel.urbanizacion).collection("Familias").get().then((mymockDoc){
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
            CameraPosition(target: LatLng(ubiFamilia.localization!.latitude, ubiFamilia.localization!.longitude), zoom: 17) 
              //17 is new zoom level
            )
          );
          setState(() {});
        });
    }
    
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(decoration: TextDecoration.none),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.9,
            maxHeight:MediaQuery.of(context).size.height*0.8,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.red.shade600,
                        Colors.redAccent.shade100,
                      ],
                    ), ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 10,
                          child: Icon(
                            Icons.warning_amber_rounded,
                            size: 160,
                            color: Colors.black87,)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Esta ocurriendo un delito",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubikMonoOne(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            )
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 80,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white24,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText("Se a registrado un allanamiento en su hogar de la urbanizacion ${Usuario_logeado.urbanizacion}",
                        textAlign: TextAlign.center,
                        maxFontSize: 20,
                        minFontSize: 10,
                        maxLines: 2,
                        style: GoogleFonts.muktaMahee(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )
                        ),),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 200,
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller){
                          mycontroller = controller;
                        },
                      markers: Set<Marker>.of(markers1.values),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(-12.144372692833945, -76.98833718779387),
                          zoom: 16)),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (_)=> reportarDelito()));
                      },
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "Reportar",
                      style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2.2,
                      color: Colors.black54),
                    ),
                                    ),
                  ],
                ),
              )
            ],
          ),),
      ),
    );
  }
}