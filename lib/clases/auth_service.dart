import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ronderos/pages/Register.dart';
import 'package:ronderos/widgets/usuario_TF.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  

  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn({ required String correo, required String contrasena}) async {
    try {
      await _firebaseAuth .signInWithEmailAndPassword(email: correo, password: contrasena);
      return "Bienvenido";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }



}

 /* Future<String?> signUp({ required String correo, required String contrasena}) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: correo, password: contrasena);
      return "Hasta Luego";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

*/