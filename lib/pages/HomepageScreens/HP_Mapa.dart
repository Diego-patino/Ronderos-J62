import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/pages/ErrorRoute.dart';
import 'package:ronderos/pages/Mapa.dart';

class MapaRonderos extends StatefulWidget {
  const MapaRonderos({Key? key}) : super(key: key);

  @override
  State<MapaRonderos> createState() => _MapaRonderosState();
}

class _MapaRonderosState extends State<MapaRonderos> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    // TODO: implement initState
    super.initState();
  }

  Future _GetToken() async {
    User? user = FirebaseAuth.instance.currentUser;

    _fcm.unsubscribeFromTopic("Ronderos");
    String? fcmtoken = await _fcm.getToken();

    print("El token esa: ${fcmtoken}");

  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Revisa el mapa y sigue las novedades de tu familia en tiempo real',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kumarOneOutline(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40
                    )
                  ) 
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width*0.6,
              decoration: const ShapeDecoration(
                shadows:[
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    color: Colors.green,
                    blurRadius: 2,
                  ),
                ],
                shape: StadiumBorder(),
                gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.green,
                  Colors.greenAccent,
                ],
              ),),
              child: FlatButton(
                focusColor: Colors.green,
                height: 40,
                  shape: StadiumBorder(),
                  color: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                        MapaFamilia()));
                    },
                  padding: const EdgeInsets.symmetric(horizontal: 65),
                  child: const Text(
                    "Mapa",

                    style: TextStyle(
                      wordSpacing: 10,
                        fontSize: 15,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                ),
            ),
            ],
          ),
        ),
      )),
    );
  }
}