import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('MapaGoogle'),
              RaisedButton(onPressed: _GetToken, child: Text("data"))
            ],
          ),
        ),
      )),
    );
  }
}