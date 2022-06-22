import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testfirebase/models/Users.dart';
import 'package:testfirebase/pages/HomePage.dart';
import 'package:testfirebase/pages/Administrar_familia.dart';
import 'package:testfirebase/pages/Unirse_familia.dart';

import 'Edicion_usuario.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
  
}


class _MainDrawerState extends State<MainDrawer> {

   /* ReadData() {
    print("Lectura");

    FirebaseFirestore.instance
        .collection('UsuariosApp')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print('Document data: ${data["nombre"]}');

        AlertDialog alerta = AlertDialog(
          title: const Text('Detalles del Usuario:'),
          content: Column(
            children: [
              Text('uid: ${data["uid"]}'),
              Text('nombre: ${data["nombre"]}'),
              Text('correo: ${data["correo"]}'),
            ],
          ),
        );
        showDialog(context: context, builder: (BuildContext context) => alerta);
      } else {
        AlertDialog alerta2 = const AlertDialog(
          title: Text('NO EXISTE DATOS'),
          content: Text("F por ti"),
        );
        showDialog(
            context: context, builder: (BuildContext context) => alerta2);
      }
    });
  } */



    UserModel Usuario_logeado = UserModel();
    User? user1 = FirebaseAuth.instance.currentUser!;
    final user= FirebaseAuth.instance.currentUser!;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final style1 = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

    @override
    void initState() {
        super.initState();
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
          print(Usuario_logeado.contrasena);
          setState(() {});
        });
      }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 90.0,
                    backgroundImage: NetworkImage(
                      Usuario_logeado.foto.toString(),
                      
                    ),
                  ),
            
                  const SizedBox(height: 25.0,),
            
                  Stack(
                    children: [
                      Center(
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.black87,
                            width: 500,
                            height: 55,
                          ),
                           Container(
                            alignment: Alignment.center,
                             child: Text(
                              "${Usuario_logeado.nombre}",
                                style: GoogleFonts.lato(textStyle: style1
                              )),
                           ),
                        ],
                      )),
                    ],
                  ),
                  
                  const SizedBox(height: 5.0,),
            
                  Stack(
                    children: [
                      Center(
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.black87,
                            width: 500,
                            height: 55,
                          ),
                           Container(
                            alignment: Alignment.center,
                             child: Text(
                              "${Usuario_logeado.apellido}",
                                style: GoogleFonts.lato(textStyle: style1
                              )),
                           ),
                        ],
                      )),
                    ],
                  ),
            
                  const SizedBox(height: 5.0,),

                  Usuario_logeado.familia != ''?
                  Stack(
                    children: [
                      Center(
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.black87,
                            width: 500,
                            height: 55,
                          ),
                           Container(
                            alignment: Alignment.center,
                             child: Text(
                              "Familia ${Usuario_logeado.familia}",
                                style: GoogleFonts.lato(textStyle: 
                                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                              )),
                           ),
                        ],
                      )),
                    ],
                  ): const SizedBox(height: 55.0,),

                  const SizedBox(height: 35.0,),


                  Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(horizontal: 73),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                    Unirse_familia()));},
                            child: const Text("UNIRSE",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.2,
                              color: Colors.black)), ),
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(horizontal: 43),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                    Administrar_familia()));},
                            child: const Text("ADMINISTRAR",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.2,
                              color: Colors.black)), ),
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(horizontal: 33),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                    Edicion_usuario()));},
                            child: const Text("CONFIGURACION",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.2,
                              color: Colors.black)), ),
                          RaisedButton(
                            onPressed: () {
                              signOut(context);
                            },
                            color: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "SALIR",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  
                ],
              ),
            ), ),
        )
      ],
    );
  }
  
}
