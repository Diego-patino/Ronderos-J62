import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testfirebase/clases/auth_service.dart';
import 'package:testfirebase/pages/HomePage.dart';
import 'package:testfirebase/pages/SignIn.dart';
import 'package:testfirebase/widgets/contra_TF.dart';
import 'package:testfirebase/widgets/usuario_TF.dart';
import 'package:testfirebase/models/Users.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Color _color= const Color.fromARGB(255, 255, 255, 255);
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
  final TextEditingController _nombrecontroller = TextEditingController();
  final TextEditingController _apellidocontroller = TextEditingController();
  String MensajError1 = '';

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    _nombrecontroller.dispose();
    _apellidocontroller.dispose();
    super.dispose();
  }

  
  Future signUp(String email, String password) async{
    
    
      if (passwordConfirmed()) {
        try {
          
          //crea el usuario
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.trim(),

            );
            //agrega el usuario

              postDetailsToFirestore();

              MensajError1 ='';

            /* addUserDetails(
              nombre:_nombrecontroller.text.trim(),
              apellido: _apellidocontroller.text.trim(),
              correo: _emailcontroller.text.trim()); */
          } on FirebaseAuthException catch (error) {
            MensajError1 = error.message!;
            
            print(error);

              if (MensajError1 == 'Given String is empty or null') {
              final text = 'Porfavor ingrese los datos faltantes en los recuadros';
              final snackBar = SnackBar(content: Text(text));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } if (MensajError1 == 'The email address is already in use by another account.') {
              final text = 'El correo ingresado ya esta en uso';
              final snackBar = SnackBar(content: Text(text));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
          
          }
    } else {
        final text = 'Parametro de datos incorrectos';
        final snackBar = SnackBar(content: Text(text));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
        
  }

  Future postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.correo = user!.email;
    userModel.uid = user.uid;
    userModel.nombre = _nombrecontroller.text;
    userModel.apellido = _apellidocontroller.text;
    userModel.contrasena = _passwordcontroller.text;
    userModel.foto = 'https://media.discordapp.net/attachments/856312697112756247/986066114364706836/unknown.png';
    userModel.familia = '';

    await firebaseFirestore
        .collection("UsuariosApp")
        .doc(user.uid)
        .set(userModel.toMap());

   /* Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false); */
       Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomePage123()),
        (route) => false);
        
  }

 /* Future<String?> addUserDetails({ required String nombre, required String apellido, required String correo}) async{
    await FirebaseFirestore.instance.collection('UsuariosApp').add({
      'nombre' : nombre,
      'apellido': apellido,
      'correo': correo,
    });
  } */

  bool passwordConfirmed(){
    if (_passwordcontroller.text.trim() == _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 15.0,),
              
                  Container(
                        child:  Image.network('https://media.discordapp.net/attachments/856312697112756247/985693540619264071/unknown.png',
                        height: 100.0,
                        width: 130.0,
              
                        ),),
              
              
              const Text('Registro', style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 38),
                                ),
              
              const SizedBox(height: 35.0,),
               
              
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextField(
                    controller: _nombrecontroller,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.black54,),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                      contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                      border: OutlineInputBorder(),
                      hintText: '',
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: Colors.black45, fontSize: 18)
              
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
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.black54,),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                          contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                          border: OutlineInputBorder(),
                          hintText: '',
                          labelText: 'Apellido',
                          labelStyle: TextStyle(color: Colors.black45, fontSize: 18)
              
                        ),
                        onChanged: (value){
              
                        },
                      ),
                    ),
              
              const SizedBox(height: 15.0,),
              
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextFormField(
                        controller: _emailcontroller,
                        validator: validateEmail1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded, color: Colors.black54,),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                          contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                          hintText: 'ejemplo@correo.com',
                          labelText: 'Correo',
                          labelStyle: TextStyle(color: Colors.black45, fontSize: 18)
              
                        ),
                        onChanged: (value){
              
                        },
                      ),
                    ),
              
              const SizedBox(height: 15.0,),
              
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordcontroller,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                          contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                          hintText: '',
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.black45, fontSize: 18)
              
                        ),
                        onChanged: (value){
              
                        },
                      ),
                    ),
              
              const SizedBox(height: 15.0,),
              
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextField(
                        obscureText: true,
                        controller: _confirmpasswordcontroller,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 3),),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                          contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                          hintText: '',
                          labelText: 'Confirmar contraseña',
                          labelStyle: TextStyle(color: Colors.black45, fontSize: 18)
              
                        ),
                        onChanged: (value){
              
                        },
                      ),
                    ),
              
              const SizedBox(height: 30.0,),
              
                  RaisedButton(
              
              child:Container(
              
                    padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
                    child: const Text('Crear Cuenta',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight:FontWeight.bold,
                    ),
              
                    ),
              
              
                  ) ,
              
                  elevation: 10.0, // sombreado al boton
                  color: const Color.fromARGB(248, 255, 255, 255),
              
                  onPressed: () {
                      signUp(_emailcontroller.text, _passwordcontroller.text,);
              
                    },
                ),
                
              const SizedBox(height: 30.0,),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   const Text("¿Ya estas registrado? ", style: TextStyle(fontSize: 17),),
                   GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                  SignInPage()));
                                },
                    child: const Text(
                       "Inicia sesion",
                      style: TextStyle(
                         color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                              fontSize: 19),
                                ),
                              )
                            ]),

              
            ],
          ),
        ),
      ),
    );
  }
   }

  String? validateEmail1(String? Correoform){
  if (Correoform == null || Correoform.isEmpty) 
    return 'Porfavor ingrese un correo';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(Correoform)) return 'Porfavor ingrese un formato de correo valido';

  return null;
  
}