import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/models/Familia.dart';
import 'package:ronderos/models/Users.dart';
import 'package:ronderos/pages/Configuracion.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/pages/HomepageScreens/HP_Administrar_familia.dart';
import 'package:ronderos/pages/Unirse_familia.dart';

import 'Edicion_usuario.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
  
}


class _MainDrawerState extends State<MainDrawer> {

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
            content: Text("Desea salir del aplicativo?", 
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
                    Navigator.of(context, rootNavigator: true).pop();
                      signOut(context);
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
    Familiamodel familiamodel = Familiamodel();
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
      
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      body: Column(
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
    
                    Usuario_logeado.familia == ''? Container()
                    :Usuario_logeado.familia != '' ?Stack(
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
                    ) : Container(),
                    
                    familiamodel.admin == true  ?
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Administrador",
                            style: GoogleFonts.padauk(textStyle: TextStyle(fontSize: 20)),)),
                      ),
                    ): familiamodel.arbol != null ? Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${familiamodel.arbol}",
                            style: GoogleFonts.padauk(textStyle: TextStyle(fontSize: 20)),)),
                      ),
                    ): Container()
                  ],
                ),
              ), ),
          )
        ],
      ),
      floatingActionButton:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                  Configuracion()));},
            child: const Text("CONFIGURACION",
            style: TextStyle(
            fontSize: 15,
            letterSpacing: 2.2,
            color: Colors.black)), ),

          RaisedButton(
            onPressed: () {
              _Alertdialogconfirm(context);
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
    );
    
  }
  
}
