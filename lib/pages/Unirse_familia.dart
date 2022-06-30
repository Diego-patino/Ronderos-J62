import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ronderos/models/Familia.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/pages/homepage_drawer.dart';
import 'package:ronderos/pages/Edicion_usuario.dart';
import 'package:ronderos/widgets/validators.dart';
import 'dart:ffi';

import '../models/Users.dart';
import 'SignIn.dart';

class Unirse_familia extends StatefulWidget {
  const Unirse_familia({Key? key}) : super(key: key);

  @override
  State<Unirse_familia> createState() => _Unirse_familiaState();
}

class _Unirse_familiaState extends State<Unirse_familia> {

    UserModel Usuario_logeado = UserModel();
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
          setState(() {});
        });
      }

    final TextEditingController _arbolcontroller = TextEditingController();
    final TextEditingController _familiacontroller = TextEditingController();
    final outlineInputBorder_enabled =OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 2.5),);
    final OutlineInputBorder_focused = OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3));
    final labelstyle1 = TextStyle(color: Colors.black45, fontSize: 18);
    final _formKey = GlobalKey<FormState>();

  Future createData(BuildContext context) async {
    print("created");    

    if (_formKey.currentState!.validate()) {
      
      try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
          User? user = FirebaseAuth.instance.currentUser;

          Familiamodel familiamodel = Familiamodel();

          // writing all the values
        familiamodel.nombre = Usuario_logeado.nombre;
        familiamodel.apellido = Usuario_logeado.apellido;
        familiamodel.arbol = _arbolcontroller.text;
        familiamodel.familia = _familiacontroller.text;
        familiamodel.uid = Usuario_logeado.uid;
        familiamodel.foto =Usuario_logeado.foto;
        familiamodel.admin = false;
        

          await firebaseFirestore
            .collection(_familiacontroller.text)
            .doc('${Usuario_logeado.nombre} ${Usuario_logeado.apellido}')
            .set(familiamodel.toMap());

            updateData(context);

           } catch (e) {

            final snackBar = SnackBar(content: Text("Porfavor ingresa el nombre de la familia y que miembro eres"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
        } 
    }     
  }

  Future updateData(BuildContext context) async {
    print("created");

        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        UserModel userModel = UserModel();

     try {
       
        // writing all the values
        userModel.correo = user.email;
        userModel.uid = user.uid;
        userModel.nombre = Usuario_logeado.nombre;
        userModel.apellido = Usuario_logeado.apellido;
        userModel.contrasena = Usuario_logeado.contrasena;
        userModel.foto = Usuario_logeado.foto;
        userModel.familia = _familiacontroller.text;
        await firebaseFirestore
            .collection('UsuariosApp')
            .doc(user.uid)
            .set(userModel.toMap());

        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage123()));

     } catch (e) {
       print(e);
     }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer( child: MainDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                  HomePage123())); 
                                },
          splashColor: Colors.black26,
          child: Text("RONDEROS", style: GoogleFonts.bungeeShade(textStyle: TextStyle(color: Colors.black), fontSize: 26)
            )
          ),
        actions: [
        Builder(
          builder: (context){
            return IconButton(
          
          onPressed: ()=> Scaffold.of(context).openEndDrawer(),
          icon: CircleAvatar(
                  backgroundImage: NetworkImage(
                    Usuario_logeado.foto.toString(),
                  ),
                ));
          })
      ],
      
      ), 
    
    body:
        Center(
          child: SafeArea(
            child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child:  Text('Registrate a una familia!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(textStyle: TextStyle(fontSize: 30), fontWeight: FontWeight.bold) ),
                      ),
                
                     
                      const SizedBox(height: 10.0,),
              
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text('Si aun no cuentas con una familia, ingresa el nombre de la familia y que integrante eres',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pacifico(textStyle: TextStyle(fontSize: 30)) ),
                      ),
              
                      
                      const SizedBox(height: 80.0,),
                      
                        Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35.0),
                              child: TextFormField(
                                validator: validategeneral,
                                controller: _familiacontroller,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                                  prefixIcon: Icon(Icons.groups_rounded, color: Colors.black54,),
                                  enabledBorder: outlineInputBorder_enabled,
                                  focusedBorder: OutlineInputBorder_focused,
                                  contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                  labelText: 'Nombre de Familia',
                                  labelStyle: labelstyle1,
                      
                                ),
                                onChanged: (value){
                      
                                },
                              ),
                            ),
                        const SizedBox(height: 15.0,),
              
                        Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35.0),
                              child: TextFormField(
                                validator: validategeneral,
                                controller: _arbolcontroller,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                                  prefixIcon: Icon(Icons.person_add, color: Colors.black54,),
                                  enabledBorder: outlineInputBorder_enabled,
                                  focusedBorder: OutlineInputBorder_focused,
                                  contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                  labelText: 'Miembro de Familia',
                                  labelStyle: labelstyle1,
                      
                                ),
                                onChanged: (value){
                      
                                },
                              ),
                            ),
              
                        const SizedBox(height: 25.0,),
                        Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          createData(context);
                        },
                        color: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "GUARDAR",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )
                       /* Padding(
                        padding:EdgeInsets.only(top: 20),
                        child: IconButton(
                          onPressed:() {
                            ChangeUserFoto();
                          },
                          icon: Icon(Icons.person_add, size: 20,),
                          iconSize: 30,
                        ), ),*/
                      
                                ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}