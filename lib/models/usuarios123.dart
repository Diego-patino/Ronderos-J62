/*class usuarios123 {
  String? FotoMomentanea;

  usuarios123({this.FotoMomentanea});

}*/

class usuarios123 {
  String? FotoMomentanea;
  

  usuarios123({this.FotoMomentanea,});

  // receiving data from server
  factory usuarios123.fromMap(map) {
    return usuarios123(
      FotoMomentanea: map['FotoMomentanea'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'FotoMomentanea': FotoMomentanea,
    };
  }
}