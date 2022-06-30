class Familiamodel {
  String? nombre;
  String? apellido;
  String? arbol;
  String? familia;
  String? uid;
  String? foto;
  bool? admin;
  

  Familiamodel({this.nombre, this.apellido, this.arbol, this.familia, this.uid, this.foto, this.admin,});

  // receiving data from server
  factory Familiamodel.fromMap(map) {
    return Familiamodel(
      nombre: map['nombre'],
      apellido: map['apellido'],
      arbol: map['arbol'],
      familia: map['familia'],
      uid: map['uid'],
      foto: map['foto'],
      admin: map['admin'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'arbol': arbol,
      'familia': familia,
      'uid': uid,
      'foto': foto,
      'admin': admin,
    };
  }
}