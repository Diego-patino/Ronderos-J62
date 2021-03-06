import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? nombre;
  String? apellido;
  String? correo;
  String? foto;
  String? contrasena;
  String? familia;
  String? phonekey;
  String? urbanizacion;
  DateTime? creadoEn;
  

  UserModel({this.uid, this.nombre, this.apellido, this.correo, this.foto, this.contrasena, this.familia, this.phonekey, this.creadoEn, this.urbanizacion});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      correo: map['correo'],
      foto: map['foto'],
      contrasena: map['contrasena'],
      familia: map['familia'],
      phonekey: map['phonekey'],
      urbanizacion: map['urbanizacion'],
      creadoEn: (map['creadoEn'] as Timestamp).toDate(),
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'foto': foto,
      'contrasena': contrasena,
      'familia': familia,
      'phonekey': phonekey,
      'urbanizacion': urbanizacion,
      'creadoEn': creadoEn
    };
  }
}