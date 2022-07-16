import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/widgets/Toast.dart';

import '../models/Familia.dart';
import '../models/Users.dart';
import 'dart:math';


class DetallesFamiliar extends StatefulWidget {
  

  final String documentId;
  final String foto;
  final String agregadoEl;
  final String nombre;
  final String apellido;
  final String arbol;
  final String urbanizacion;
  final String familia;
  
  DetallesFamiliar({
    required this.foto,
    required this.documentId,
    required this.agregadoEl,
    required this.nombre,
    required this.apellido,
    required this.arbol,
    required this.urbanizacion,
    required this.familia,
  });

  @override
  State<DetallesFamiliar> createState() => _DetallesFamiliarState();
}



class _DetallesFamiliarState extends State<DetallesFamiliar> {
  
    Familiamodel familiamodel = Familiamodel();
    UserModel Usuario_logeado = UserModel();
    late String imagenURL;
    late int numerito;
    final user= FirebaseAuth.instance.currentUser!;

      numero() {
      var rng = Random();
      for (var i = 0; i < 1; i++) {
        // print(rng.nextInt(10));
        numerito = rng.nextInt(10);
      }
    }

    @override
    void initState() {
      numero();
      print(numerito);
        super.initState();
        imagenURL = "https://picsum.photos/12$numerito$numerito/8$numerito$numerito/?blur=2";
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
        });
        });
      }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.85,
          maxHeight: familiamodel.admin == true? MediaQuery.of(context).size.height*0.55:MediaQuery.of(context).size.height*0.5,
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              ),
            Image(
              image: NetworkImage(imagenURL),),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: familiamodel.admin==true? 265: 240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                      )
                    ),
                  ),
                  
                  Positioned(
                    top: 0,
                    right: 22,
                    child: Text(widget.agregadoEl),
                  ),

                  Positioned(
                    top: 0,
                    left  : 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: AutoSizeText(
                        widget.familia,
                        style: GoogleFonts.kumarOneOutline(),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        maxFontSize: 22,
                        minFontSize: 15,)),
                  ),

                   Padding(
                     padding: const EdgeInsets.only(top: 45.0),
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                         children: [
                          
                           Container(
                            width: MediaQuery.of(context).size.width*0.45,
                             child: AutoSizeText(
                              "${widget.nombre} ${widget.apellido}",
                              style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 30,
                              minFontSize: 24,),
                           ),
                           Text("${widget.arbol}",),

                           SizedBox(height: 20,),

                           Align(
                            alignment: Alignment.center,
                             child: Text(
                              "Urbanizacion",
                              style: GoogleFonts.lexendGiga(
                                textStyle: TextStyle(
                                  color: Colors.green,
                                  letterSpacing: 3,
                                  fontSize: 20,
                                )
                              )),
                           ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(widget.urbanizacion,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.majorMonoDisplay(
                                textStyle: TextStyle(
                                  fontSize: 30,
                                )
                              )),
                            ),
                         ],
                       ),
                     ),
                   ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.4),
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                  widget.foto.toString(),
                  
                ),
              ),
            ),
            

            familiamodel.admin==true?
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                      onPressed:() {
                          _Alertdialogconfirm(context);
                        },
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      elevation: 2,
                      child: const Text(
                        "Botar de Familia",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
  
  Future _Alertdialogconfirm(BuildContext context) async{
        
      final alertDialog = showDialog(
            context: context,
            builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(),
            title: Text("Confirmar", 
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),),
            content: Text("Desea expulsar a este miembro?", 
              style: GoogleFonts.prompt(
                textStyle: TextStyle(
                  fontSize: 15,
                )),),
            actions: <Widget>[
              Wrap(
                spacing: 70,
                children: [
                  FlatButton(
                    onPressed:  (){
                    botarfamilia();
                    Navigator.of(context, rootNavigator: true).pop();
                      },
                    child: Text(
                      'Si',
                      style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Colors.green
                      ),) 
                    )),
                  FlatButton(
                    onPressed: ()=>
                    Navigator.of(context, rootNavigator: true).pop(),
                    child: Text(
                      'No', 
                      style: GoogleFonts.poppins(textStyle:TextStyle(
                        color: Colors.red,
                      ), ) 
                    )
                  ),
              ],
            )
          ],
        ));
    }


  Future botarfamilia()async{
    try {
       final docuser = FirebaseFirestore.instance
            .collection("Urbanizaciones")
            .doc(Usuario_logeado.urbanizacion)
            .collection("Familias")
            .doc(Usuario_logeado.familia)
            .collection("Miembros")
            .doc(widget.documentId);
               docuser.delete();

              DocumentReference documentReference =
              FirebaseFirestore.instance
              .collection("UsuariosApp")
              .doc(widget.documentId);
              documentReference
              .update({
                "familia": "",
            });
            Navigator.pop(context);
            confirmarborrarfamiliar();
    } catch (e) {
      
    }
  }

}