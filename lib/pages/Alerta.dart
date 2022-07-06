import 'package:flutter/material.dart';

class Alerta extends StatefulWidget {
  const Alerta({Key? key}) : super(key: key);

  @override
  State<Alerta> createState() => _AlertaState();
}

class _AlertaState extends State<Alerta> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Bien"),
      ),
    );
  }
}