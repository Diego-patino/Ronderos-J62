
import 'package:cloud_firestore/cloud_firestore.dart';

class UbiFamilia {
  String? nombre;
  GeoPoint? localization;

  UbiFamilia({this.nombre, this.localization});

  // receiving data from server
  factory UbiFamilia.fromMap(map) {
    return UbiFamilia(
      nombre: map['nombre'],
      localization: (map['localization'] as GeoPoint),
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'localization': localization
    };
  }
}