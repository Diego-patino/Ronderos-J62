class UserModel {
  String? uid;
  String? nombre;
  String? apellido;
  String? correo;
  String? foto;
  String? contrasena;
  String? familia;
  

  UserModel({this.uid, this.nombre, this.apellido, this.correo, this.foto, this.contrasena, this.familia});

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
    };
  }
}