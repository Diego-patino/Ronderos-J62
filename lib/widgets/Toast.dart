import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void salirfamiliatoast() => Fluttertoast.showToast(
  msg: "Escapaste de tu familia con exito",
  
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 2,
  backgroundColor: Colors.green,
  textColor: Colors.white,
  fontSize: 15
  
);

void entrarfamiliatoast() => Fluttertoast.showToast(
  msg: "Bienvenido a la familia",
  
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 2,
  backgroundColor: Colors.green,
  textColor: Colors.white,
  fontSize: 15
  
);

void borrarcuentatoast() => Fluttertoast.showToast(
  msg: "Esperamos volverte a ver :)",
  
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 2,
  backgroundColor: Colors.green,
  textColor: Colors.white,
  fontSize: 15
  
);

void edicioncuentatoast() => Fluttertoast.showToast(
  msg: "Cambios guardados con exito, porfavor vuelve a logearte",
  
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 2,
  backgroundColor: Colors.green,
  textColor: Colors.white,
  fontSize: 15
  
);