import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/clases/auth_service.dart';
import 'package:testfirebase/widgets/usuario_TF.dart';
import 'package:testfirebase/widgets/contra_TF.dart';
import 'package:testfirebase/widgets/button_login.dart';

  
final TextEditingController contraController = TextEditingController();

class passwordtextfield extends StatefulWidget {
  passwordtextfield({Key? key}) : super(key: key);

  @override
  State<passwordtextfield> createState() => _passwordtextfieldState();
}

class _passwordtextfieldState extends State<passwordtextfield> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder:(BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0),

          child: TextField(
            controller: contraController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,

            decoration: InputDecoration(

              icon: Icon(Icons.lock),
              hintText: 'Contraseña',
              labelText: 'Contraseña',

            ),

            onChanged: (value){

            },
          ),
        );

        } 
      );
  }
}