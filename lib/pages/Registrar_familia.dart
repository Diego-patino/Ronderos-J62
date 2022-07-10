import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/widgets/Toast.dart';

import '../models/Users.dart';
import '../models/ubi_familia.dart';
import '../widgets/validators.dart';

class RegistrarFamilia extends StatefulWidget {
  const RegistrarFamilia({Key? key}) : super(key: key);

  @override
  State<RegistrarFamilia> createState() => _RegistrarFamiliaState();
}


class _RegistrarFamiliaState extends State<RegistrarFamilia> {
  UbiFamilia ubiFamilia = UbiFamilia();
  UserModel Usuario_logeado = UserModel();
  final user= FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _familiacontroller = TextEditingController();
  final outlineInputBorder_enabled =OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 2.5),);
  final OutlineInputBorder_focused = OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3));
  final labelstyle1 = TextStyle(color: Colors.black45, fontSize: 18);
  var selectedUrbanizacion, selectedType; 
  var selectedFamilia, selectedType2;
  late GoogleMapController mycontroller;
  final Completer<GoogleMapController> controller2 = Completer();
  Map<MarkerId, Marker> markers1 = <MarkerId,  Marker>{};
  late LatLng finallocation;
  static const LatLng sourcelocation = LatLng(-12.093607080095207, -77.00150082033403);
  late LatLng usuariolocal;
  String dropdownvalue = "";
  LatLng newlatlang = LatLng(-12.093607080095207, -77.00150082033403  );
  
  
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
              zoom: 14.5)
          )
        );
      });
    });

  }

  Future ConfirmarUrb() async{
    if (selectedUrbanizacion==null) {
      confirmarUrbToast();
      Navigator.of(context, rootNavigator: true).pop();
    } if(selectedUrbanizacion!=null){
      ConfirmarFamilia();
    } 
  }

  Future ConfirmarFamilia() async{
    if (_familiacontroller.text== '') {
      confirmarFamiliaToast();
      Navigator.of(context, rootNavigator: true).pop();
    } if (_familiacontroller.text != '') {
      MandarFirestore();
    }
  }

  Future MandarFirestore() async{
    try {
          // writing all the values
        print("COMENZAMOS ${_familiacontroller.text}");
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("Urbanizaciones").doc(selectedUrbanizacion).collection("Familias").doc(_familiacontroller.text);
        documentReference
            .set({
              "address": _familiacontroller.text,
              "location":GeoPoint(finallocation.latitude, finallocation.longitude),
            })
            
            .then((value) => print("Familia creada con exito"))
            .catchError((error) => print("Failed to update user: $error"));
            print('Localizacion: ${finallocation.latitude} , ${finallocation.longitude}  ');
              
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => HomePage123(),
              ),
              (route) => false,//if you want to disable back feature set to false

          ); 
              entrarfamiliatoast();
        } catch (e) {
          print(e);
        } 
  }

  Future ConfirmarForm() async{
        final alertDialog = showDialog(
          context: context,
          builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(),
          title: Text("¿Estas Seguro?", 
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25)),),
          content: Text("Quieres agregar a la Familia ${_familiacontroller.text== ''? 'Sin Nombre': _familiacontroller.text} a la urbanizacion ${selectedUrbanizacion==null? 'de los desconocidos': selectedUrbanizacion}", 
            style: GoogleFonts.prompt(
              textStyle: TextStyle(
                fontSize: 15,
              )),),
          actions: <Widget>[
            Wrap(
              spacing: 20,
              children: [
                FlatButton(
                  onPressed: (){
                    setState(() {
                      visible = false;
                    });
                  Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    'Mejor no',
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Colors.red
                    ),) 
                  )),
                FlatButton(
                  onPressed: (){
                    ConfirmarUrb();
                     },
                  child: Text(
                    'Oh si agregalo!', 
                    style: GoogleFonts.poppins(textStyle:TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                    ), ) 
                  )),
              ],
            )
          ],
        ));
      }

    


  List<Marker> mymarker = [];
  bool visible = false;

    _handletap(LatLng tappedPoint) {
      print("Position: ${tappedPoint.latitude}");
      setState((){
        visible = true;
        mymarker = [];
        mymarker.add(
          Marker(
            markerId: MarkerId(
              tappedPoint.toString(),),
            position: tappedPoint,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen))
        
        );
        finallocation = tappedPoint;
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
    setState(() {
      markers1={};
    });
    
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection("Urbanizaciones").doc(selectedUrbanizacion).collection("Familias").get().then((mymockDoc){
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
    Navigator.of(context, rootNavigator: true).pop();
      
    }
  }

  Future getfamiliaposition() async{
    FirebaseFirestore.instance
            .collection("Urbanizaciones")
            .doc(selectedUrbanizacion)
            .get()
            .then((value) {
          this.ubiFamilia = UbiFamilia.fromMap(value.data());
          print("POSITION DE LA FAMILY ${ubiFamilia.localization!.longitude}");
          
    
          visible = false;
          mycontroller.animateCamera( 
            CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(ubiFamilia.localization!.latitude, ubiFamilia.localization!.longitude), zoom: 17) 
              //17 is new zoom level
            )
          );
          setState(() {});
        });
    }

  dialogInfo(){
    showDialog(
          context: context,
          builder: (_) => Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return Form(
                    key: _formKey,
                    child: AlertDialog(
                            shape: RoundedRectangleBorder(),
                            title: Text("Pasos a Seguir", 
                              style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                    Text("Brindanos tu urbanizacion y el nombre de tu familia", 
                      style: GoogleFonts.prompt(
                        textStyle: TextStyle(
                          fontSize: 15,
                        )),),
                    const SizedBox(height: 10,),
                              StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("Urbanizaciones").snapshots(),
                                    builder: (context, snapshot){
                                      if (!snapshot.hasData)
                                            return const Text("Loading.....");
                                      else {
                                            List<DropdownMenuItem> currencyItems = [];
                                            for (int i = 0; i < snapshot.data!.docs.length; i++) {
                                              DocumentSnapshot snap = snapshot.data!.docs[i];
                                              currencyItems.add(
                                                DropdownMenuItem(
                                                  child: Text(
                                                    snap.id,
                                                    style: TextStyle(color: Color(0xff11b719)),
                                                  ),
                                                  value: "${snap.id}",
                                                ),
                                              );
                                            }
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: DropdownButtonFormField<dynamic>(
                                              menuMaxHeight: 300,
                                              iconSize: 0,
                                              decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                                                prefixIcon: Icon(Icons.location_on_outlined, color: Colors.black54,),
                                                enabledBorder: outlineInputBorder_enabled,
                                                focusedBorder: OutlineInputBorder_focused,
                                                contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 3),
                                              ),
                                              items: currencyItems,
                                              onChanged: (urbValue) {
                                                /*final snackBar = SnackBar(
                                                  content: Text(
                                                    'La Urbanizacion seleccionada es:  $UrbValue',
                                                    style: TextStyle(color: Color(0xff11b719)),
                                                  ),
                                                );
                                                Scaffold.of(context).showSnackBar(snackBar);*/
                                                setState(() {
                                                  selectedUrbanizacion = urbValue;
                                                  print(selectedUrbanizacion);
                                                  selectedFamilia = null;
                                                });
                                              },
                                              value: selectedUrbanizacion,
                                              isExpanded: false,
                                              hint: const AutoSizeText(
                                                "Urbanizacion",
                                                style: TextStyle(color: Colors.black45,),
                                                maxFontSize: 18,
                                                minFontSize: 9,
                                                maxLines: 1,
                                              ),
                                              validator: (value){
                                                if (selectedUrbanizacion==null) 
                                                  return 'Selecciona una urbanizacion';
                                                  return null; 
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextFormField(
                                  scrollPhysics: BouncingScrollPhysics(),
                                  style: TextStyle(
                                    color: Colors.green
                                  ),
                                  validator: validatefamilia,
                                  controller: _familiacontroller,
                                  decoration: InputDecoration(
                                    
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                                    prefixIcon: Icon(Icons.family_restroom, color: Colors.black54,),
                                    enabledBorder: outlineInputBorder_enabled,
                                    focusedBorder: OutlineInputBorder_focused,
                                    contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 3),
                                    labelText: 'Familia',
                                    labelStyle: labelstyle1,
                                                
                                        ),
                                      onChanged: (value){
                                                    
                                      },
                                    ),
                              ),
                                )
                              
                              ],
                            ),
                            actions: <Widget>[
                              Align(
                              alignment: Alignment.center,
                              child: Wrap(
                                spacing: 70,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        getfamiliaposition();
                                        getMarkerData();
                                      });
                                    },
                                    child: Text(
                                      'Busca a mi urbanizacion!',
                                      style: GoogleFonts.poppins(textStyle: TextStyle(
                                        color: Colors.white
                                      ),) 
                                    )),
                                
                                ],
                              ),
                                        )
                            ],
                          ),
                  );
                },
              ),
            ),
          ),);
  }

  @override
  void initState() {

    getUserCurrentPosition();
    // TODO: implement initState
    
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
          print("Fuiste creado en: ${Usuario_logeado.creadoEn.toString()}");
          setState(() {});
        });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(),
          title: Text("Bienvenido", 
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25)),),
          content: Text("Recuerda seguir los pasos para poder registrar a tu familia", 
            style: GoogleFonts.prompt(
              textStyle: TextStyle(
                fontSize: 15,
              )),),
          actions: <Widget>[
            Wrap(
              spacing: 70,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green
                  ),
                  onPressed: (){
                    setState(() {
                      visible = false;
                      //getMarkerData();
                    });
                  Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    'Llevame adentro!',
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Colors.white
                    ),) 
                  )),
              ],
            )
          ],
        ));
    });
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
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: _handletap,
            initialCameraPosition: CameraPosition(
              
              target: sourcelocation,
              zoom: 15.5,
              ),
              onMapCreated: (GoogleMapController controller){
                mycontroller = controller;
              },
            markers: visible== false? Set<Marker>.of(markers1.values): visible== true? Set.from(mymarker): Set.from(mymarker)
            ),
          Padding(
            padding: const EdgeInsets.only(top:80.0,right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  heroTag: "info",
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.info, size: 40, color: Colors.deepPurple,),
                  elevation: 12,
                  onPressed: (){ 
                    dialogInfo();
                    }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: 
            visible== true?
            Padding(
              padding: const EdgeInsets.only(left:38.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    heroTag: "Confirmar",
                    backgroundColor: Colors.green.shade800,
                    child: Icon(Icons.add, size: 40,),
                    elevation: 10,
                    onPressed: (){ 
                      ConfirmarForm();
                      }),
                ),
              ),
            ):null,  
    );
    
  }
  /*
  void showAlert(BuildContext context){
    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>  WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            
            shape: RoundedRectangleBorder(),
            title: Text("Registra tu familia", 
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),),
            content: Column(
              mainAxisSize: MainAxisSize.min ,
              children: [
                Text("Porfavor selecciona tu urbanizacion y el nombre de tu familia para poder registrarlos", 
                  style: GoogleFonts.prompt(
                    textStyle: TextStyle(
                      fontSize: 15,
                    )),),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Urbanizaciones").snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData)
                       return const Text("Loading.....");
                        else {
                          List<DropdownMenuItem> currencyItems = [];
                           for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            currencyItems.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap.id,
                                   style: TextStyle(color: Color(0xff11b719)),
                                  ),
                                value: "${snap.id}",
                               ),
                             );
                           }
                            return Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_location_alt_outlined,
                                      size: 25.0, color: Color(0xff11b719)),
                                  SizedBox(width: 20,),
                                  Container(
                                    width: 200,
                                    child: DropdownButton<dynamic>(
                                      items: currencyItems,
                                      onChanged: (urbValue) {
                                        /*final snackBar = SnackBar(
                                          content: Text(
                                            'La Urbanizacion seleccionada es:  $UrbValue',
                                            style: TextStyle(color: Color(0xff11b719)),
                                          ),
                                        );
                                        Scaffold.of(context).showSnackBar(snackBar);*/
                                        
                                           selectedUrbanizacion = urbValue;
                                          print(selectedUrbanizacion);
                                           selectedFamilia = null;
                                        
                                      },
                                      value: selectedUrbanizacion,
                                      isExpanded: true,
                                      hint: const Text(
                                        "Selecciona tu urbanizacion",
                                        style: TextStyle(color: Color(0xff11b719),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                       }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: TextFormField(
                validator: validatefamilia,
                controller: _familiacontroller,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                  prefixIcon: Icon(Icons.person_add, color: Colors.black54,),
                  enabledBorder: outlineInputBorder_enabled,
                  focusedBorder: OutlineInputBorder_focused,
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                  labelText: 'Miembro de Familia',
                  labelStyle: labelstyle1,
                              
                ),
                onChanged: (value){
                              
                 },
                ),
              ),
              ],
            ),
            actions: <Widget>[
              Wrap(
                spacing: 70,
                children: [
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        visible = false;
                      });
                    Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      'Mejor no ;)',
                      style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Colors.green
                      ),) 
                    )),
                  FlatButton(
                    onPressed: (){
                      
                       },
                    child: Text(
                      'Si, borrame', 
                      style: GoogleFonts.poppins(textStyle:TextStyle(
                        color: Colors.red,
                      ), ) 
                    )),
                ],
              )
            ],
          ),
        )
      );
  }
}*/

/*
class _RegistrarFamiliaState extends State<RegistrarFamilia> {

  List<Marker> mymarker = [];

  _handletap(LatLng tappedPoint) {
    print("Position: $tappedPoint");
    setState((){
      mymarker = [];
      mymarker.add(
        Marker(
          markerId: MarkerId(
            tappedPoint.toString(),),
          position: tappedPoint )
      );
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.from(mymarker),
        initialCameraPosition: 
        CameraPosition(
          target: LatLng(-12.144372692833945, -76.98833718779387,),
          zoom: 14.0),
          onTap: _handletap,));
  }
}
*/ 

}