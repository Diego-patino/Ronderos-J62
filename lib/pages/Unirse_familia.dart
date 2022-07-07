import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ronderos/models/Familia.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/pages/homepage_drawer.dart';
import 'package:ronderos/pages/Edicion_usuario.dart';
import 'package:ronderos/widgets/Toast.dart';
import 'package:ronderos/widgets/validators.dart';
import 'dart:ffi';

import '../models/Users.dart';
import 'SignIn.dart';

class Unirse_familia extends StatefulWidget {
  const Unirse_familia({Key? key}) : super(key: key);

  @override
  State<Unirse_familia> createState() => _Unirse_familiaState();
}

class _Unirse_familiaState extends State<Unirse_familia> {

   @override
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
    final TextEditingController _arbolcontroller = TextEditingController();
    final TextEditingController _familiacontroller = TextEditingController();
    final outlineInputBorder_enabled =OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 2.5),);
    final OutlineInputBorder_focused = OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3));
    final labelstyle1 = TextStyle(color: Colors.black45, fontSize: 18);
    final _formKey = GlobalKey<FormState>();
    String dropdownvalue = "";
    var selectedUrbanizacion, selectedType;
    var selectedFamilia, selectedType2;

  Future createData(BuildContext context) async {
    print("created"); 

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;

      Familiamodel familiamodel = Familiamodel();   

    if (_formKey.currentState!.validate()) {
      
      try {
          // writing all the values
        familiamodel.nombre = Usuario_logeado.nombre;
        familiamodel.apellido = Usuario_logeado.apellido;
        familiamodel.arbol = _arbolcontroller.text;
        familiamodel.familia = _familiacontroller.text;
        familiamodel.uid = Usuario_logeado.uid;
        familiamodel.foto = Usuario_logeado.foto;
        familiamodel.phonekey = Usuario_logeado.phonekey;
        familiamodel.agregadoEl = FieldValue.serverTimestamp();
        familiamodel.urbanizacion = selectedUrbanizacion;
        familiamodel.admin = false;
        

          await firebaseFirestore
            .collection("Urbanizaciones")
            .doc(selectedUrbanizacion)
            .collection("Familias")
            .doc(_familiacontroller.text)
            .collection("Miembros")
            .doc('${Usuario_logeado.uid}')
            .set(familiamodel.toMap());

            updateData(context);

           } catch (e) {

            final snackBar = SnackBar(content: Text("Porfavor ingresa el nombre de la familia y que miembro eres"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
        }

      try {
          // writing all the values
        print(_familiacontroller.text);
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("Urbanizaciones").doc(selectedUrbanizacion).collection("Familias").doc(_familiacontroller.text).collection("Tokens").doc(Usuario_logeado.phonekey);
        documentReference
            .set({
              "nombre": Usuario_logeado.nombre,
              "apellido": Usuario_logeado.apellido,
              "creadoEl": FieldValue.serverTimestamp(),
              "uid": Usuario_logeado.uid,
              "token": Usuario_logeado.phonekey,
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
        print('Nombre: ${Usuario_logeado.nombre}_${Usuario_logeado.apellido}  ');

              Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => HomePage123(),
              ),
              (route) => false,//if you want to disable back feature set to false

          ); 
              entrarfamiliatoast();
        } catch (e) {
          print(e);

            final snackBar = SnackBar(content: Text("Porfavor ingresa el nombre de la familia y que miembro eres"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } 
        

    /*  try {
        print(_familiacontroller.text);
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("Familias").doc(_familiacontroller.text);
        documentReference
            .set({
              "${Usuario_logeado.nombre}_${Usuario_logeado.apellido}": "Google Maps"
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
        print('Nombre: ${Usuario_logeado.nombre}_${Usuario_logeado.apellido}  ');
        } catch (e) {
          print(e);
        }
*/
        
    } 
  }

  Future updateData(BuildContext context) async {
    print("created");

        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        UserModel userModel = UserModel();

     try {
       
        DocumentReference documentReference =
          FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
          documentReference
          .update({
            "familia" : _familiacontroller.text,
            "urbanizacion": selectedUrbanizacion,
        })
                  
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
          print('Nueva contra: ${Usuario_logeado.contrasena}');

     } catch (e) {
       print(e);
     }
            final snackBar = SnackBar(content: Text("Bienvenido a la familia"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Ingresa a una Familia', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
        onPressed: (){
             Navigator.of(context).pop();
          },
        icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ), 
    
    body:
        SafeArea(
          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   /* Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child:  Text('Registrate a una familia!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(textStyle: TextStyle(fontSize: 30), fontWeight: FontWeight.bold) ),
                      
                      style: GoogleFonts.pacifico(textStyle: TextStyle(fontSize: 30)) ),
                    ),*/
              
                   
                    const SizedBox(height: 10.0,),
            
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text('¿Aun no cuentas con una familia?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bellota(textStyle: TextStyle(fontSize: 40), fontWeight: FontWeight.bold)),
                    ),

                  const SizedBox(height: 5.0,),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child:  Text('Sigue estos pasos para que puedas ser adoptado en una!',
                      textAlign: TextAlign.center,
                      
                      style: GoogleFonts.pacifico(textStyle: TextStyle(fontSize: 25)) ),
                    ),

                  const SizedBox(height: 45.0,),

                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:  Text('Selecciona tu urbanizacion!',
                      textAlign: TextAlign.center,
                      
                      style: GoogleFonts.comfortaa(textStyle: TextStyle(fontSize: 25), ) ),
                    ),
                              
                    const SizedBox(height: 10.0,),   

                    StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Urbanizaciones").snapshots(),
                builder: (context, snapshot){
                  if (!snapshot.hasData)
                    return const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap.id,
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add_location_alt_outlined,
                            size: 25.0, color: Color(0xff11b719)),
                        SizedBox(width: 25.0),
                        DropdownButton<dynamic>(
                          items: currencyItems,
                          onChanged: (urbValue) {
                            /*final snackBar = SnackBar(
                              content: Text(
                                'La Urbanizacion seleccionada es:  $UrbValue',
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);*/
                            setState(() {
                              selectedUrbanizacion = urbValue;
                              print(selectedUrbanizacion);
                              selectedFamilia = null;
                            });
                          },
                          value: selectedUrbanizacion,
                          isExpanded: false,
                          hint: const Text(
                            "Selecciona tu urbanizacion",
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                        ),
                      ],
                    );
                  }
                }),

            selectedUrbanizacion!=null?
              Column(
                children: [

                  SizedBox(height: 10,),
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child:  Text('Selecciona la familia a la que quieres ingresar!',
                      textAlign: TextAlign.center,
                      
                      style: GoogleFonts.comfortaa(textStyle: TextStyle(fontSize: 25),) ),
                    ),

                  SizedBox(height: 10,),

                  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Urbanizaciones").doc(selectedUrbanizacion).collection("Familias").snapshots(),
                builder: (context, snapshot2){
                  if (!snapshot2.hasData)
                    return const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> FamilyItems = [];
                    for (int i = 0; i < snapshot2.data!.docs.length; i++) {
                      DocumentSnapshot snap2 = snapshot2.data!.docs[i];
                      FamilyItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap2.id,
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                          value: "${snap2.id}",
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.family_restroom,
                            size: 25.0, color: Color(0xff11b719)),
                        SizedBox(width: 25.0),
                        DropdownButton<dynamic>(
                          
                          items: selectedUrbanizacion=="No tengo urbanizacion"? FamilyItems:null,
                          onChanged: (famValue) {
                            /*final snackBar = SnackBar(
                              content: Text(
                                'La Urbanizacion seleccionada es:  $UrbValue',
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);*/
                            setState(() {
                              selectedFamilia = famValue;
                              print(selectedFamilia);
                            });
                          },
                          value: selectedFamilia,
                          isExpanded: false,
                          hint: const Text(
                            "Selecciona tu Familia",
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                        ),
                      ],
                    );
                  }
                }),

                    SizedBox(height: 10,),
                          Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                                child: TextFormField(
                                  validator: validategeneral,
                                  controller: _familiacontroller,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                                    prefixIcon: Icon(Icons.groups_rounded, color: Colors.black54,),
                                    enabledBorder: outlineInputBorder_enabled,
                                    focusedBorder: OutlineInputBorder_focused,
                                    contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                    labelText: 'Nombre de Familia',
                                    labelStyle: labelstyle1,
                    
                                  ),
                                  onChanged: (value){
                    
                                  },
                                ),
                              ),
                        ],
                      ):Container(),
                      const SizedBox(height: 15.0,),
            
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: TextFormField(
                              validator: validategeneral,
                              controller: _arbolcontroller,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
                                prefixIcon: Icon(Icons.person_add, color: Colors.black54,),
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                labelText: 'Miembro de Familia',
                                labelStyle: labelstyle1,
                    
                              ),
                              onChanged: (value){
                    
                              },
                            ),
                          ),
            
                      const SizedBox(height: 25.0,),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        createData(context);
                      },
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "GUARDAR",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 40.0),
            
                     /* Padding(
                      padding:EdgeInsets.only(top: 20),
                      child: IconButton(
                        onPressed:() {
                          ChangeUserFoto();
                        },
                        icon: Icon(Icons.person_add, size: 20,),
                        iconSize: 30,
                      ), ),*/
                    
                              ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}