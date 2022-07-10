import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ronderos/models/ubi_familia.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({Key? key}) : super(key: key);

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {

  UbiFamilia ubiFamilia = UbiFamilia(); 
  @override
  void initState() {
    FirebaseFirestore.instance
            .collection("Urbanizaciones")
            .doc("Calle 13")
            .get()
            .then((value) {
          this.ubiFamilia = UbiFamilia.fromMap(value.data());
          print(ubiFamilia.localization!.longitude);
          setState(() {});
        });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(onPressed: (){
          print("${ubiFamilia.localization!.longitude}");
        }),
      ),
    );
  }
}