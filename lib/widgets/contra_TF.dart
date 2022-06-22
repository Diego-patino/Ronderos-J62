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

String? validatecontra(String? contraform){
  if(contraform == null || contraform.isEmpty)
  return 'Porfavor ingrese una contraseña';

  String pattern = 
    r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$';  //Tiene que tener => (Mayuscula)(Minuscula)(Numero).{6 digitos}
    // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
    // Para Mayusculas es => ... (?=.*?[A-Z]) ...
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(contraform))
    return '''
    La contraseña tiene que tener por lo menos:
    6 digitos incluyendo un número''';
  return null;
}