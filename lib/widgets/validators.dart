import 'package:flutter/material.dart';


String? validateEmail(String? Correoform){
  if (Correoform == null || Correoform.isEmpty) 
    return 'Porfavor ingrese un correo';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(Correoform)) return 'Porfavor ingrese un formato de correo valido';

  return null;
  
}

String? validatecontra(String? contraform){
  if(contraform == null || contraform.isEmpty)
  return 'Porfavor ingrese una contraseña';

  String pattern = 
    r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$';  //Tiene que tener =>(Minuscula)(Numero).{6 digitos}
    // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
    // Para Mayusculas es => ... (?=.*?[A-Z]) ...
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(contraform))
    return '''
    La contraseña tiene que tener por lo menos:
    6 digitos incluyendo un letras y números''';
    
  return null;
}

String? validatenombre(String? nombreform){
  if(nombreform == null || nombreform.isEmpty)
  return 'Porfavor coloque su nombre';

  String pattern = 
    r'^[a-zA-Z]+$';  //Tiene que NO tener => (simbolos)(numeros)
    // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
    // Para Mayusculas es => ... (?=.*?[A-Z]) ...
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(nombreform))
    return 'Ingresar solo letras sin espacio en el nombre';

  return null;
}

String? validateapellido(String? apellidoform){
  if(apellidoform == null || apellidoform.isEmpty)
  return 'Porfavor coloque su Apellido';

   String pattern = 
    r'^[a-zA-Z]+$';  //Tiene que NO tener => (simbolos)(numeros)
    // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
    // Para Mayusculas es => ... (?=.*?[A-Z]) ...
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(apellidoform))
    return 'Ingresar solo letras sin espacio en el apellido';

  return null;
}

String? validatecontraactual(String? contraform){
  if(contraform == null || contraform.isEmpty)
  return 'Porfavor coloque su contraseña';

  return null;
}

String? validatearbol(String? arbolform){
  if(arbolform == null || arbolform.isEmpty)
  return 'Porfavor ingrese que tipo de familiar es.';

    String pattern = 
    r'^[a-zA-Z]+$';  //Tiene que NO tener => (simbolos)(numeros)
    // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
    // Para Mayusculas es => ... (?=.*?[A-Z]) ...
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(arbolform))
    return 'Ingresar solo letras en el arbol';

  return null;
}

String? validategeneral(String? generalform){
  if(generalform == null || generalform.isEmpty)
  return 'Porfavor llena el recuadro.';

  return null;
}

String? validatefamilia(String? familiaform){
  if(familiaform == null || familiaform.isEmpty)
  return 'Porfavor llena el recuadro.';

  String pattern = 
  
    r'^[a-zA-Z]+$';  //Tiene que NO tener => (simbolos)(numeros)
    // Para simbolos es => ... (?=.*?[!@#\$&*~]) ...
    // Para Mayusculas es => ... (?=.*?[A-Z]) ...
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(familiaform))
    return """    Ingresa correctamente la familia: 
    Mayuscula al inicio y solo letras""";

  return null;
}