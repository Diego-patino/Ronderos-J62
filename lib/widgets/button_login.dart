import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/widgets/usuario_TF.dart';
import 'package:ronderos/widgets/contra_TF.dart';
import 'package:ronderos/clases/auth_service.dart';


class buttonlogin extends StatefulWidget {
  buttonlogin({Key? key}) : super(key: key);

  @override
  State<buttonlogin> createState() => _buttonloginState();
}

class _buttonloginState extends State<buttonlogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(

          child:Container(

            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
            child: Text('Login',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight:FontWeight.bold,
            ),

            ),


          ) ,

          elevation: 10.0, // sombreado al boton
          color: Color.fromARGB(248, 255, 255, 255),

          onPressed: () {

              /*signIn2(
                correo: correoController.text.trim(),
                contrasena: contraController.text.trim(),
              );*/

            },
        );

      } 
      );
  }


}

