import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/main.dart';
import 'package:ronderos/models/usuarios123.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/widgets/Huerfano.dart';
import 'package:ronderos/widgets/Toast.dart';

import '../models/Familia.dart';
import '../models/Users.dart';
import 'SignIn.dart';

class SalirseFamilia extends StatefulWidget {
  const SalirseFamilia({Key? key}) : super(key: key);

  @override
  State<SalirseFamilia> createState() => _SalirseFamiliaState();
}

class _SalirseFamiliaState extends State<SalirseFamilia> {
  
   UserModel Usuario_logeado = UserModel();
   Familiamodel familiamodel = Familiamodel();
   final user= FirebaseAuth.instance.currentUser!;

  @override
    void initState() {
        super.initState();
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
          print('aaaaaaaaaaaaaaaaaaaaaa: ${Usuario_logeado.contrasena}');
          setState(() {});
          
        });
        FirebaseFirestore.instance
            .collection("Urbanizaciones")
            .doc(Usuario_logeado.urbanizacion)
            .collection("Familias")
            .doc("${Usuario_logeado.familia}")
            .collection("Miembros")
            .doc('${Usuario_logeado.nombre}_${Usuario_logeado.apellido}_${Usuario_logeado.uid}')
            .get()
            .then((value) {
          this.familiamodel = Familiamodel.fromMap(value.data());
          print('aaaaaaaaaaaaaaaaaaaaaa: ${familiamodel.arbol}');
          setState(() {});

        
        });
      }
      
  Future Alertdialogconfirm_Salir(BuildContext context) async{
      
    final alertDialog = showDialog(
          context: context,
          builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(),
          title: Text("Confirmar", 
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25)),),
          content: Text("Estas seguro que deseas salirte de tu familia?", 
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
                    SalirFamilia(context);
                    Navigator.of(context, rootNavigator: true).pop();
                    salirfamiliatoast();
                 //   Scroll123(context);
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

  Future SalirFamilia(BuildContext context) async{
    
    try {
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
        documentReference
            .update({
              "familia": ""
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));

             final snackBar = SnackBar(content: Text("Escapaste de tu familia con exito, porfavor vuelva a logearse"));
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
                  

    _BorrarCuentaFamilia();
      
      Navigator.pushAndRemoveUntil(
        context,   
        MaterialPageRoute(builder: (BuildContext context) => HomePage123()), 
        ModalRoute.withName('/'));
  }

  Future _BorrarCuentaFamilia() async{
    if (Usuario_logeado.familia != '') {
      
      try {
          
        DocumentReference documentReference =
            FirebaseFirestore.instance
            .collection("Urbanizaciones").doc(Usuario_logeado.urbanizacion).collection("Familias").doc("${Usuario_logeado.familia}").collection("Miembros").doc(Usuario_logeado.uid);

        documentReference
            .delete()
            .then((value) => print("Familiar eliminado"))
            .catchError((error) => print("Failed to delete: $error"));
        } catch (e) {
            final snackBar = SnackBar(content: Text("aaaaaaaaaa"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
          
        }
       /*
        try {
           DocumentReference documentReference =
            FirebaseFirestore.instance.collection("Familias").doc(Usuario_logeado.familia);
        documentReference
            .update({
              "${Usuario_logeado.nombre}_${Usuario_logeado.apellido}": FieldValue.delete()
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
        } catch (e) {
          print(e);
        }*/

        try {
          
        DocumentReference documentReference =
            FirebaseFirestore.instance
            .collection("Urbanizaciones").doc(Usuario_logeado.urbanizacion).collection("Familias").doc("${Usuario_logeado.familia}").collection("Tokens").doc(Usuario_logeado.phonekey);

        documentReference
            .delete()
            .then((value) => print("Token de Familiar eliminado"))
            .catchError((error) => print("Failed to delete: $error"));
        } catch (e) {
            final snackBar = SnackBar(content: Text("aaaaaaaaaa"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
          
        }
    } else{
      return null;
    }
      
      

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Salirse de Familia', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body:
        Usuario_logeado.familia != ''? 
        Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Actualmente eres miembro de:", 
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                          ) 
                        ), 
                      textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.black54,
                  child: Text(
                    "Familia ${Usuario_logeado.familia}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontSize: 32,
                        color: Colors.white
                      )
                    )
                    )),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Los miembros son:", 
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18, 
                          ) 
                        ), 
                      textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection("Urbanizaciones")
                  .doc(Usuario_logeado.urbanizacion)
                  .collection("Familias")
                  .doc("${Usuario_logeado.familia}")
                  .collection("Miembros")
                  .snapshots(),
                builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot)   {
                    if (snapshot.hasData) {
                      return Container(
                        height: 100,
                        child:ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){
                            DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                              return Row(
                                children: [
                                  SizedBox(width: 20,),

                                  Center(
                                    child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 10.0),
                                                )
                                              ],
                                        color: Colors.black87,
                                        ),
                                        width: 250,
                                        height: 55,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${documentSnapshot["nombre"]} ${documentSnapshot["apellido"]}",
                                            style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 20, color: Colors.white),
                                          )),
                                      ),
                                    ],
                                  )),
                                ],
                              );
                          })
                      );
                    } else {
                       return const Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),

              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "Si quieres salirte de esta familia, presiona aqui",
                              style: GoogleFonts.gowunDodum(
                                textStyle: TextStyle(
                                  fontSize: 20
                                )
                              ),
                              textAlign: TextAlign.center,),
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 20,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Wrap(
                        spacing: 75,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Alertdialogconfirm_Salir(context);
                            },
                            color: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "SALIR DE FAMILIA",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                  ],
                ),
              )
            ],
          ),
        ),
      ): Huerfano()
    );
  }
}