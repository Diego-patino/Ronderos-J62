import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/clases/auth_service.dart';
import 'package:testfirebase/widgets/usuario_TF.dart';
import 'package:testfirebase/widgets/contra_TF.dart';
import 'package:testfirebase/widgets/button_login.dart';
import 'package:testfirebase/widgets/validators.dart';

  
final TextEditingController contraController = TextEditingController();

class passwordtextfield extends StatefulWidget {
  passwordtextfield({Key? key}) : super(key: key);

  @override
  State<passwordtextfield> createState() => _passwordtextfieldState();
}

class _passwordtextfieldState extends State<passwordtextfield> {

  

  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0),

          child: TextFormField(
            controller: contraController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            validator: validatecontra,
            decoration: InputDecoration(

              icon: Icon(Icons.lock),
              hintText: 'Contraseña',
              labelText: 'Contraseña',

            ),

            onChanged: (value){

            },
          )
      );
  }
}
