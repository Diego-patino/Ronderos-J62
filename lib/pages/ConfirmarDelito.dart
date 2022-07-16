import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/pages/HomePage.dart';

class ConfirmarDelito extends StatefulWidget {
  ConfirmarDelito({Key? key}) : super(key: key);

  @override
  State<ConfirmarDelito> createState() => _ConfirmarDelitoState();
}

class _ConfirmarDelitoState extends State<ConfirmarDelito> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(),
        title: Text("Reporte enviado correctamente",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25)),),
        content: Icon(
          Icons.thumb_up_sharp,
          color: Colors.green,
          size: 200,
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
              onPressed: ()=> Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => HomePage123(),
                  ),
                  (route) => false,//if you want to disable back feature set to false

              ),
              child: Text(
                'Regresar al inicio', 
                style: GoogleFonts.poppins(textStyle:TextStyle(
                  color: Colors.white,
                ), ) 
              )
            ),
          )
      ],
    );
  }
}