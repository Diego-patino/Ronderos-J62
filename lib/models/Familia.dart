class Familiamodel {
  String? nombre;
  String? apellido;
  String? arbol;
  String? familia;
  

  Familiamodel({this.nombre, this.apellido, this.arbol, this.familia,});

  // receiving data from server
  factory Familiamodel.fromMap(map) {
    return Familiamodel(
      nombre: map['nombre'],
      apellido: map['apellido'],
      arbol: map['arbol'],
      familia: map['familia'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'arbol': arbol,
      'familia': familia,
    };
  }
}