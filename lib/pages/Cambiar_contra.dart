import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/pages/Configuracion.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/widgets/Toast.dart';
import 'package:ronderos/widgets/validators.dart';

import '../main.dart';
import '../models/Users.dart';
import 'SignIn.dart';

class Cambiarcontra extends StatefulWidget {
  const Cambiarcontra({Key? key}) : super(key: key);

  @override
  State<Cambiarcontra> createState() => _CambiarcontraState();
}

class _CambiarcontraState extends State<Cambiarcontra> {
  
    void initState() {
        super.initState();
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
          setState(() {});
        });
      }
  
    UserModel Usuario_logeado = UserModel();
    final user= FirebaseAuth.instance.currentUser!;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final outlineInputBorder_enabled =OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 2.5),);
    final OutlineInputBorder_focused = OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3));
    final labelstyle1 = TextStyle(color: Colors.black45, fontSize: 18);
    final TextEditingController _newpasswordcontroller = TextEditingController();
    final TextEditingController _passwordcontroller = TextEditingController();
    final TextEditingController _confirmpasswordcontroller = TextEditingController();
    final TextEditingController _nombrecontroller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String MensajError1 = '';
    bool cargando = false;
    bool _secureText1 = true;
    bool _secureText2 = true;
    bool _secureText3 = true;

    @override
    void dispose() {
      _passwordcontroller.dispose();
      _confirmpasswordcontroller.dispose();
      _nombrecontroller.dispose();
      _newpasswordcontroller.dispose();
      super.dispose();
    }

  Future _Alertdialogconfirm() async {
    final oldPassword = _passwordcontroller.text;
    if (_formKey.currentState!.validate()) {
        if (passwordConfirmed()) {
          if (Usuario_logeado.contrasena == oldPassword) {
              setState(()=> cargando = true);
              
                final alertDialog = showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                      shape: RoundedRectangleBorder(),
                      title: Text("Confirmar", 
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),),
                      content: Text("??Deseas guardar los cambios?", 
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            fontSize: 15,
                          )),),
                      actions: <Widget>[
                        Wrap(
                          spacing: 70,
                          children: [
                            FlatButton(
                              onPressed:  (){
                                Cambiarcontrasena_FirebaseAuth();
                              Navigator.of(context, rootNavigator: true).pop();
                                },
                              child: Text(
                                'Si',
                                style: GoogleFonts.poppins(textStyle: TextStyle(
                                  color: Colors.green
                                ),) 
                              )),
                            FlatButton(
                              onPressed: ()=>
                              Navigator.of(context, rootNavigator: true).pop(),
                              child: Text(
                                'No', 
                                style: GoogleFonts.poppins(textStyle:TextStyle(
                                  color: Colors.red,
                                ), ) 
                              )
                            ),
                        ],
                      )
                    ],
                  ));
        
           } else {
              final text = 'La contrase??a actual ingresada no coincide';
              final snackBar = SnackBar(content: Text(text));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);  }

          } else {
              final text = 'Las contrase??as no coinciden';
              final snackBar = SnackBar(content: Text(text));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }
        setState(()=> cargando = false);
      }
      
  }

    Future Cambiarcontrasena_FirebaseAuth() async{

    final newpassword = _newpasswordcontroller.text;
          try {
              FirebaseAuth.instance
              .signInWithEmailAndPassword(email: user.email!, password: Usuario_logeado.contrasena!)
              .then((userCredential) {
                  userCredential.user!.updatePassword(newpassword);
                  print('dale papi todo good');
              });

              Cambiarcontrasena_FirebaseFirestore();
              
              MensajError1 ='';
            } on FirebaseAuthException catch (error) {
              MensajError1 = error.message!;
              print(error);
              final snackBar = SnackBar(content: Text(error.message!));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
            }

        edicioncuentatoast();
            

  }

  Future Cambiarcontrasena_FirebaseFirestore() async {
    
          print("Modificaci??n");

            try {

                DocumentReference documentReference =
                  FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
                documentReference
                  .update({
                    "contrasena" : _newpasswordcontroller.text,
                  })
                  
                  .then((value) => print("User Updated"))
                  .catchError((error) => print("Failed to update user: $error"));
                  
                  await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,   
                      MaterialPageRoute(builder: (BuildContext context) => SignInPage()), 
                      ModalRoute.withName('/')
                  );
                  

            } on FirebaseAuthException catch (error) {
              print(error);
              final snackBar = SnackBar(content: Text(error.message!));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
      }
 }

    bool passwordConfirmed(){
    if (_newpasswordcontroller.text == _confirmpasswordcontroller.text) {
      return true;
    } else {
      return false;
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text('', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child:  Text('Actualiza tu contrase??a',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredokaOne(textStyle: TextStyle(fontSize: 27), ) ), ),
            
                    SizedBox(height: 8,),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child:  Text('Introduce tu contrase??a actual y tu nueva contrase??a',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(textStyle: TextStyle(fontSize: 15), ) ), ),
                    SizedBox(height: 20,),
            
                       const SizedBox(height: 15.0,),
            
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: TextFormField(
                              controller: _passwordcontroller,
                              validator: validatecontraactual,
                              obscureText: _secureText1,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _secureText1 = !_secureText1;
                                    });
                                  }, 
                                  icon: Icon(
                                    _secureText1? Icons.no_encryption_gmailerrorred : Icons.remove_red_eye,
                                    color: _secureText1? Colors.red : Colors.green,
                                    )),
                                prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)) ,
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                labelText: 'Contrase??a Actual',
                                labelStyle: labelstyle1,
                    
                              ),
                              onChanged: (value){
                    
                              },
                            ),
                          ),
            
                      const SizedBox(height: 15.0,),
            
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: TextFormField(
                              validator: validatecontra,
                              controller: _newpasswordcontroller,
                              obscureText: _secureText2,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)) ,
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _secureText2 = !_secureText2;
                                    });
                                  }, 
                                  icon: Icon(
                                    _secureText2? Icons.no_encryption_gmailerrorred : Icons.remove_red_eye,
                                    color: _secureText2? Colors.red : Colors.green,
                                    )),
                                prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                labelText: 'Nueva Contrase??a',
                                labelStyle: labelstyle1,
                    
                              ),
                              onChanged: (value){
                    
                              },
                            ),
                          ),
            
                      const SizedBox(height: 15.0,),
            
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: TextFormField(
                              validator: validatecontra,
                              controller: _confirmpasswordcontroller,
                              obscureText: _secureText3,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)) ,
                                prefixIcon: Icon(Icons.key_rounded, color: Colors.black54,),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _secureText3 = !_secureText3;
                                    });
                                  }, 
                                  icon: Icon(
                                    _secureText3? Icons.no_encryption_gmailerrorred : Icons.remove_red_eye,
                                    color: _secureText3? Colors.red : Colors.green,
                                    )),
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                labelText: 'Repetir Contrase??a',
                                labelStyle: labelstyle1,
                    
                              ),
                              onChanged: (value){
                    
                              },
                            ),
                          ),

                      const SizedBox(height: 25.0,),

                      RaisedButton(
                          onPressed: cargando? null: () {
                            _Alertdialogconfirm();
                          },
                          color: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 55),
                          elevation: 2,
                          child: cargando? Container(child:CircularProgressIndicator(color: Colors.lightGreen,) , height: 20, width: 20,) : const Text(
                            "CAMBIAR CONTRASE??A",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
            

            
                  ],
                  
                      ),
            )),
      ),
    );
  }
}