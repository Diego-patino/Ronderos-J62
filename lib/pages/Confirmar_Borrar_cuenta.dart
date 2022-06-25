import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testfirebase/models/Familia.dart';
import 'package:testfirebase/pages/Borrar_cuenta.dart';
import 'package:testfirebase/pages/SignIn.dart';

import '../models/Users.dart';
import '../widgets/validators.dart';

class ConfirmarBorrarCuenta extends StatefulWidget {
  const ConfirmarBorrarCuenta({Key? key}) : super(key: key);

  @override
  State<ConfirmarBorrarCuenta> createState() => _ConfirmarBorrarCuentaState();
}

class _ConfirmarBorrarCuentaState extends State<ConfirmarBorrarCuenta> {
  


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
            .collection("${Usuario_logeado.familia}")
            .doc('${Usuario_logeado.nombre}_${Usuario_logeado.apellido}')
            .get()
            .then((value) {
          this.familiamodel = Familiamodel.fromMap(value.data());
          print('aaaaaaaaaaaaaaaaaaaaaa: ${familiamodel.arbol}');
          setState(() {});

        
        });
      }
      
      
  final Color _color= const Color.fromARGB(255, 255, 255, 255);
  final TextEditingController _passwordcontroller = TextEditingController();
  UserModel Usuario_logeado = UserModel();
  final user= FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  Familiamodel familiamodel = Familiamodel();
    @override
    void dispose() {
    _passwordcontroller.dispose();  
      super.dispose();
    }

  Future BorrarCuentaConfirmar() async{
    print(_passwordcontroller.text);
    print(Usuario_logeado.contrasena);
    final password = Usuario_logeado.contrasena;
    if (_formKey.currentState!.validate()) {
      if (_passwordcontroller.text == password) {
        final alertDialog = showDialog(
          context: context,
          builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(),
          title: Text("¿Estas Seguro?", 
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25)),),
          content: Text("¿Realmente estas completamente Seguro? Te vamos a extrañar :(", 
            style: GoogleFonts.prompt(
              textStyle: TextStyle(
                fontSize: 15,
              )),),
          actions: <Widget>[
            Wrap(
              spacing: 70,
              children: [
                FlatButton(
                  onPressed: ()=>
                  Navigator.of(context, rootNavigator: true).pop(), 
                  child: Text(
                    'Mejor no ;)',
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Colors.green
                    ),) 
                  )),
                FlatButton(
                  onPressed: (){
                    BorrarCuentaAuth();
                  Navigator.of(context, rootNavigator: true).pop();
                     },
                  child: Text(
                    'Si, borrame', 
                    style: GoogleFonts.poppins(textStyle:TextStyle(
                      color: Colors.red,
                    ), ) 
                  )),
              ],
            )
          ],
        ));
      } else {
        final text = 'La contraseña no coincide';
              final snackBar = SnackBar(content: Text(text));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future BorrarCuentaAuth() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(email: Usuario_logeado.correo!, password: Usuario_logeado.contrasena!);

      await user!.reauthenticateWithCredential(credential).then((value) {
        value.user!.delete().then((res){
          
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignInPage()));
        } );
      });

       BorrarCuentaFirestore();

    } on FirebaseAuthException catch (e) {
      print(e);
    }

        final snackBar = SnackBar(content: Text("Nos vemos pronto:)"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

Future BorrarCuentaFirestore() async{
  try {
      
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("UsuariosApp").doc('${Usuario_logeado.uid}');

    documentReference
        .delete()
        .then((value) => print("Usuario eliminado"))
        .catchError((error) => print("Failed to delete student: $error"));

        BorrarCuentaFamilia();
    } catch (e) {
        print(e);
      
      
    }
}

Future BorrarCuentaFamilia() async{
  if (Usuario_logeado.familia != '') {
    
  try {
      
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("${Usuario_logeado.familia}").doc('${Usuario_logeado.nombre}_${Usuario_logeado.apellido}');

    documentReference
        .delete()
        .then((value) => print("Familiar eliminado"))
        .catchError((error) => print("Failed to delete student: $error"));
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
      backgroundColor: _color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                  BorrarCuenta()));
          },
          icon: Icon(Icons.cancel, color: Colors.redAccent, size: 30,)),
      ),
      body: Container(

        child: Align(
          alignment: Alignment(0,-0.5),
          child: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            
                            Container(
                                child:  Image.network('https://media.discordapp.net/attachments/856312697112756247/985693540619264071/unknown.png',
                                width: 120.0,
                      
                                ),),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Confirma tu contraseña", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ), textAlign: TextAlign.left,),
                                      ],
                                    ),
                                ),
        
                              SizedBox(height: 10,),
                                  Text("Para completar tu solicitud y poder eliminar tu cuenta, por favor ingresa tu contraseña actual.", 
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54
                                    )
                                  ),),
                              SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: validatecontra,
                                      controller: _passwordcontroller,
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)) ,
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
                                  
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
                            onPressed: () {
                              BorrarCuentaConfirmar();
                            },
                            backgroundColor: Colors.red,
                            
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            label: const Text(
                              "Borrar Cuenta",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
    );
  }
}