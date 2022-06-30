import 'package:flutter/material.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({Key? key}) : super(key: key);

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("PlaceHolder"),
      ),
    );
  }
}