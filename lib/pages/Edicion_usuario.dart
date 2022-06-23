import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testfirebase/models/Users.dart';
import 'package:testfirebase/models/usuarios123.dart';
import 'package:testfirebase/pages/HomePage.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:testfirebase/pages/SignIn.dart';

class Edicion_usuario extends StatefulWidget {
  const Edicion_usuario({Key? key}) : super(key: key);

  @override
  State<Edicion_usuario> createState() => _Edicion_usuarioState();
}

class _Edicion_usuarioState extends State<Edicion_usuario> {
    File? image;
    UploadTask? uploadTask;

  Future pickImage() async{
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return ;
  
    final imagetemporary = File(image.path);
          setState(() => this.image = imagetemporary);
        } on PlatformException catch (e) {
          print('Fallo');
        }
      print('la ruta es: ${image}');
  }
    
  Future uploadFile(BuildContext context) async{
   usuarios123 userModel = usuarios123();

         if (image != null) {
           final path = 'UsuariosAppFotos/${Usuario_logeado.correo}/${Usuario_logeado.uid}.png';
           final file = File(image!.path);
           final ref = FirebaseStorage.instance.ref().child(path);
          setState(() {
            uploadTask =  ref.putFile(file);
          });

          final snapshot = await uploadTask!.whenComplete(() {});
          final URLFoto = await snapshot.ref.getDownloadURL();

              userModel.FotoMomentanea = URLFoto;

        if (userModel.FotoMomentanea != null) {
              print('salio bien:  ${userModel.FotoMomentanea}');
        } else {
          print('nada loco pipipippippipi');
        }
            setState(() {
              uploadTask = null;
            });
         } if (image == null){
          userModel.FotoMomentanea = Usuario_logeado.foto;
         }
         
      
        print("Modificación");
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
        documentReference
            .update({
              if(userModel.FotoMomentanea != null)
              "foto" : userModel.FotoMomentanea.toString(),
              if(userModel.FotoMomentanea == null)
              "foto" : Usuario_logeado.foto,
              if(_nombrecontroller.text.isNotEmpty)
              "nombre" : _nombrecontroller.text,
              if(_nombrecontroller.text.isEmpty)
              "nombre" : Usuario_logeado.nombre,
              if(_apellidocontroller.text.isNotEmpty)
              "apellido": _apellidocontroller.text,
              if(_apellidocontroller.text.isEmpty)
              "apellido": Usuario_logeado.apellido,
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
            
          print('Nueva Foto: ${userModel.FotoMomentanea}');

          
    final newPassword = _passwordcontroller.text;
   if (passwordConfirmed()) {
        try {
        FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email!, password: Usuario_logeado.contrasena!)
        .then((userCredential) {
            if(_passwordcontroller.text.isNotEmpty )
            userCredential.user!.updatePassword(newPassword);
            if(_passwordcontroller.text.isEmpty )
            userCredential.user!.updatePassword(Usuario_logeado.contrasena!);
            print(Usuario_logeado.contrasena);
            print('dale papi todo good');
        });
      } catch (e) {
        print(' loco:(');
        
      }
    }
    print("Modificación");
         documentReference =
            FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
        documentReference
            .update({
            if(_passwordcontroller.text.isNotEmpty || _confirmpasswordcontroller.text.isNotEmpty)
              "contrasena" : _passwordcontroller.text,
            if(_passwordcontroller.text.isEmpty || _confirmpasswordcontroller.text.isEmpty)
              "contrasena" : Usuario_logeado.contrasena,
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
            print('Nueva contra: ${Usuario_logeado.contrasena}');

    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInPage()));

  }

 /* ChangeUserFoto() {
    print("Modificación");
    usuarios123 userModel2 = usuarios123();
       print(userModel2.FotoMomentanea);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
    documentReference
        .update({
          "foto" : userModel2.FotoMomentanea.toString(),
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  } */

    UserModel Usuario_logeado = UserModel();
    // User? user1 = FirebaseAuth.instance.currentUser!;
    final user= FirebaseAuth.instance.currentUser!;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final style1 = TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
    usuarios123 userModel123 = usuarios123();
    final outlineInputBorder_enabled =OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 2.5),);
    final OutlineInputBorder_focused = OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3));
    final labelstyle1 = TextStyle(color: Colors.black45, fontSize: 18);
    final TextEditingController _passwordcontroller = TextEditingController();
    final TextEditingController _confirmpasswordcontroller = TextEditingController();
    final TextEditingController _nombrecontroller = TextEditingController();
    final TextEditingController _apellidocontroller = TextEditingController();
    @override
    void dispose() {
      _passwordcontroller.dispose();
      _confirmpasswordcontroller.dispose();
      _apellidocontroller.dispose();
      _nombrecontroller.dispose();
      super.dispose();
    }

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

  

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Editar Perfil', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                  HomePage123()));
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body:
        SafeArea(
          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  const SizedBox(height: 10.0,),
                  Stack(
                    children:<Widget>[
                      Stack(
                        children:[
                      image!= null?
                          ClipOval(
                            child: Image.file(image!,
                            width: 220,
                            height: 220,
                            fit: BoxFit.cover,),
                          ): CircleAvatar(
                                  radius: 110.0,
                                  backgroundImage: NetworkImage(
                                    Usuario_logeado.foto.toString(),
                                    
                                  ),
                                ),
                          
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [],
                              ),
                            ),
                          Container(
                            width: 220,
                            height: 220,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.white,
                                    child: InkWell(
                                      onTap:() {
                                          pickImage();
                                          },
                                      child: Icon(Icons.photo_camera, size: 70, color: Colors.greenAccent,),
                                    ),
                                  ),
                                ],
                              )
                            
                          ),
                        
                        ]
                      )
                      //Image.file(image!, width: 100, height: 100,) 
                                             
                    ],
                  ),
                  
                    const SizedBox(height: 30.0,),
                  
                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextField(
                            controller: _nombrecontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.black54,),
                              enabledBorder: outlineInputBorder_enabled,
                              focusedBorder: OutlineInputBorder_focused,
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                              labelText: 'Nombre',
                              semanticCounterText: 'sasdas',
                              hintText: "${Usuario_logeado.nombre}",
                              labelStyle: labelstyle1,
                              hintStyle: TextStyle(color: Colors.black87, fontSize: 18),
                  
                            ),
                            onChanged: (value){
                  
                            },
                          ),
                        ),
                    const SizedBox(height: 15.0,),

                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextField(
                            controller: _apellidocontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.black54,),
                              enabledBorder: outlineInputBorder_enabled,
                              focusedBorder: OutlineInputBorder_focused,
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                              labelText: 'Apellido',
                              hintText: "${Usuario_logeado.apellido}",
                              labelStyle: labelstyle1,
                              hintStyle: TextStyle(color: Colors.black87, fontSize: 18),
                  
                            ),
                            onChanged: (value){
                  
                            },
                          ),
                        ),
                    const SizedBox(height: 15.0,),

                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextField(
                            controller: _passwordcontroller,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                              enabledBorder: outlineInputBorder_enabled,
                              focusedBorder: OutlineInputBorder_focused,
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                              labelText: 'Nueva Contraseña',
                              labelStyle: labelstyle1,
                  
                            ),
                            onChanged: (value){
                  
                            },
                          ),
                        ),
                    const SizedBox(height: 15.0,),

                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: TextField(
                            controller: _confirmpasswordcontroller,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                              enabledBorder: outlineInputBorder_enabled,
                              focusedBorder: OutlineInputBorder_focused,
                              contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                              labelText: 'Repetir Contraseña',
                              labelStyle: labelstyle1,
                  
                            ),
                            onChanged: (value){
                  
                            },
                          ),
                        ),

                    const SizedBox(height: 45.0,),
                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                  HomePage123()));
                    },
                    child: const Text("CANCELAR",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      uploadFile(context);
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
      
    );
  }
  

  bool passwordConfirmed(){
    if (_passwordcontroller.text.trim() == _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  } 
  
}