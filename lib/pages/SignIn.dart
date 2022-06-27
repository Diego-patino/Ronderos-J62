import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ronderos/models/Users.dart';
import 'package:ronderos/pages/Register.dart';
import 'package:ronderos/widgets/button_login.dart';
import 'package:ronderos/widgets/contra_TF.dart';
import 'package:ronderos/widgets/usuario_TF.dart';

import 'HomePage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  

  final UserModel Usuario_logeado = UserModel();
  final _formKey = GlobalKey<FormState>();
  bool cargando = false;

  final Color _color= const Color.fromARGB(255, 255, 255, 255);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: _color,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0,),
                    Image.network('https://media.discordapp.net/attachments/854848787763691550/983508331492704317/unknown.png',
                          height: 300.0,
                          width: 350.0,
                    
                          ),
                    const SizedBox(height: 20.0,),
                    
                    const userTextField(),
                    
                    const SizedBox(height: 30.0,),
                    
                    passwordtextfield(),
                    
                    const SizedBox(height: 30.0,),
                    
                    StreamBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        return RaisedButton(
                          
                          child:Container(
                          
                            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
                            child: cargando? Container(child:CircularProgressIndicator(color: Colors.lightGreen,) , height: 20, width: 20,) : Text('Login',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight:FontWeight.bold,
                            ),
                          
                            ),
                          
                          
                          ) ,
                          
                          elevation: 10.0, // sombreado al boton
                          color: Color.fromARGB(248, 255, 255, 255),
                          onPressed: cargando? null: () {
                            if (_formKey.currentState!.validate()) {
                              signIn2(
                                correo: correoController.text.trim(),
                                contrasena: contraController.text.trim(),
                              );
                            }
                          
                            }
                        );
                          
                      } 
                      ),
                              
                              const SizedBox(height: 15.0,),
                              
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                  const Text("Aun no tienes una cuenta? ",),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                  RegisterPage()));
                                                },
                                    child: const Text(
                                      "Registrate aquí",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                                ),
                                              )
                                            ])
                              
                  ],
                ),
              ),
            
          ),
        ),
      ),
    );
  }

   Future<String?> signIn2({ required String correo, required String contrasena}) async {
    setState(()=> cargando = true);
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: correo, password: contrasena)
            .then((uid) => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage123())),
                      print(Usuario_logeado.contrasena),
                });
      } on FirebaseAuthException catch (e){
        print(e);
        final text = 'Correo o contraseña incorrectos';
        final snackBar = SnackBar(content: Text(text));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        
                          
      }
      setState(()=> cargando = false);
  }

}
}