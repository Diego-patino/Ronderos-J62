import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testfirebase/pages/Borrar_cuenta.dart';

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
      }
      
  final Color _color= const Color.fromARGB(255, 255, 255, 255);
  final TextEditingController _passwordcontroller = TextEditingController();
  UserModel Usuario_logeado = UserModel();
  final user= FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();

    @override
    void dispose() {
    _passwordcontroller.dispose();  
      super.dispose();
    }

  Future BorrarCuentaAuth() async{
    print(_passwordcontroller.text);
    print(Usuario_logeado.contrasena);
    final password = Usuario_logeado.contrasena;
    if (_formKey.currentState!.validate()) {
      if (_passwordcontroller.text == password) {
        
        final alertDialog = showDialog(
          context: context,
          builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(),
          title: Text("¿Estas Seguro?"),
          content: Text("¿Realmente estas completamente Seguro? Te vamos a extrañar :("),
          actions: <Widget>[
            FlatButton(
              onPressed: (){}, 
              child: Text(
                'Mejor no;)',
              )),
            FlatButton(
              onPressed: (){},
              child: Text(
                'Si, borrame'
              ))
          ],
        ));
      } else {
        print("pinga");
      }
    }
  }

  Future BorrarCuentaConfirmar() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(email: Usuario_logeado.correo!, password: Usuario_logeado.contrasena!);

      await user!.reauthenticateWithCredential(credential).then((value) {
        value.user!.delete().then((res){
              
        } );
      });
    } on FirebaseAuthException catch (e) {
      print(e);
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
      body: Align(
        alignment: Alignment.center,
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
                            height: 220.0,
                            width: 120.0,
                  
                            ),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Confirma tu contraseña", textAlign: TextAlign.left,),
                            ],
                          ),
                        ),
                              Text("Para completar tu solicitud para eliminar tu cuenta, por favor ingresa tu contraseña actual", textAlign: TextAlign.left,),
                
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 35.0),
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
                              RaisedButton(
                            onPressed: () {
                              BorrarCuentaAuth();
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
                  ),
                ),
              ),
          ),
      ),
    );
  }
}