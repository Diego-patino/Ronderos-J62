import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/pages/ConfirmarDelito.dart';

class reportarDelito extends StatefulWidget {
  reportarDelito({Key? key}) : super(key: key);

  @override
  State<reportarDelito> createState() => _reportarDelitoState();
}

class _reportarDelitoState extends State<reportarDelito> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("RONDEROS", 
            style: GoogleFonts.bungeeShade(
              textStyle: TextStyle(
                color: Colors.black45), 
                fontSize: 32)),

            Text("¿Que es lo que quieres hacer ahora?", 
            textAlign: TextAlign.center,
            style: GoogleFonts.londrinaShadow(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70)),),

            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width*0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: RaisedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_)=> ConfirmarDelito());
                      },
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Alertar a los Vecinos",
                        style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: MediaQuery.of(context).size.width*0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: RaisedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_)=> ConfirmarDelito());
                      },
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Alertar tu familia",
                        style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: MediaQuery.of(context).size.width*0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: RaisedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_)=> ConfirmarDelito());
                      },
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Alertar a las autoridades",
                        style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 1.8,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green, width: 1.5),
              ),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Volver al Inicio",
                  style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2.2,
                      color: Color.fromARGB(255, 73, 51, 51)),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}