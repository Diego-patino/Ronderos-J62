import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/clases/auth_service.dart';
import 'package:testfirebase/widgets/usuario_TF.dart';
import 'package:testfirebase/widgets/contra_TF.dart';
import 'package:testfirebase/widgets/button_login.dart';



  class userTextField extends StatefulWidget {
    const userTextField({Key? key}) : super(key: key);

    @override
    State<userTextField> createState() => userTextFieldState();
}

final TextEditingController correoController = TextEditingController();


class userTextFieldState extends State<userTextField> {

    @override
    Widget build(BuildContext context) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          child: TextFormField(
            controller: correoController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo Electronico',

            ),
            onChanged: (value){

            },
          ),
        ); 
    }
}

String? validateEmail(String? Correoform){
  if (Correoform == null || Correoform.isEmpty) 
    return 'Porfavor ingrese un correo';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(Correoform)) return 'Porfavor ingrese un formato de correo valido';

  return null;
  
}