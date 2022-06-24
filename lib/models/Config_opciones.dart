import 'package:flutter/material.dart';
import 'package:testfirebase/pages/Cambiar_contra.dart';
import 'package:testfirebase/pages/Edicion_usuario.dart';

class Config1 {
  String configuracion;
  String descripcion;
  Icon boton;
  String materialPageRoute;

  Config1(
    {
      required this.configuracion,
      required this.descripcion,
      required this.boton,
      required this.materialPageRoute});
}

List<Config1> Config1List = [
  Config1(
     configuracion: "Mi cuenta", 
     descripcion: "Ajustes de Usuario.",
     boton: Icon(Icons.person_pin, size: 40,), 
     materialPageRoute: "cuenta"),
  Config1(
     configuracion: "Contraseña", 
     descripcion: "Cambiar de Contraseña.",
     boton: Icon(Icons.password_outlined, size: 40,),
     materialPageRoute: "contra"),
  Config1( 
     configuracion: "Familia",
     descripcion: "Administra tu Familia.",
     boton: Icon(Icons.family_restroom_rounded, size: 40,),
     materialPageRoute: "family"
     ),
];

class Config2 {
  String configuracion;
  String descripcion;
  Icon boton;
  String materialPageRoute;

  Config2(
    {
      required this.configuracion,
      required this.descripcion,
      required this.boton,
      required this.materialPageRoute});
}

List<Config2> Config2List = [
  Config2(
     configuracion: "Salirse de Familia", 
     descripcion: "Escapa de tu actual familia.", 
     boton: Icon(Icons.face_retouching_off_rounded, size: 40,),
     materialPageRoute: "salirfamily"
     ),

  Config2(
     configuracion: "Borrar Cuenta", 
     descripcion: "Elimina tu cuenta por completo.", 
     boton: Icon(Icons.person_off, size: 40,),
     materialPageRoute: "borrarcuenta"
     ),
];