import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:ronderos/widgets/usuario_TF.dart';
import 'package:ronderos/widgets/contra_TF.dart';
import 'package:ronderos/widgets/button_login.dart';
import 'package:ronderos/widgets/validators.dart';

  
final TextEditingController contraController = TextEditingController();

class passwordtextfield extends StatefulWidget {
  passwordtextfield({Key? key}) : super(key: key);

  @override
  State<passwordtextfield> createState() => _passwordtextfieldState();
}

class _passwordtextfieldState extends State<passwordtextfield> {

  bool _secureText1 = true;
  

  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0),

          child: TextFormField(
            controller: contraController,
            keyboardType: TextInputType.emailAddress,
            obscureText: _secureText1,
            validator: validatecontra,
            decoration: InputDecoration(
            suffixIcon: IconButton(
               onPressed: (){
                  setState(() {
                     _secureText1 = !_secureText1;
                     });
                    }, 
                  icon: Icon(
                _secureText1? Icons.no_encryption_gmailerrorred : Icons.remove_red_eye,
                 color: _secureText1? Colors.black54 : Colors.green,
              )),
            icon: Icon(Icons.key),
            hintText: 'Contraseña',
            labelText: 'Contraseña',

            ),

            onChanged: (value){

            },
          )
      );
  }
}
