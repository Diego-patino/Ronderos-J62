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
import 'package:ronderos/widgets/Huerfano.dart';
import 'package:ronderos/widgets/validators.dart';
import 'dart:ffi';

import '../../models/Users.dart';


const Color _color1=  Color.fromARGB(255, 255, 255, 255);


class Administrar_familia extends StatefulWidget {
  Administrar_familia({Key? key,}) : super(key: key);

  @override
  State<Administrar_familia> createState() => _Administrar_familiaState();
}

class _Administrar_familiaState extends State<Administrar_familia> {

   UserModel Usuario_logeado = UserModel();
   Familiamodel familiamodel = Familiamodel();
   final user= FirebaseAuth.instance.currentUser!;
   
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
        
        FirebaseFirestore.instance
            .collection(Usuario_logeado.familia!)
            .doc("${Usuario_logeado.nombre} ${Usuario_logeado.apellido}")
            .get()
            .then((value) {
          this.familiamodel = Familiamodel.fromMap(value.data());
          setState(() {});
        });
        });
      }
   
  
  final style1 = TextStyle(fontSize: 12, color: Colors.black);
  final TextEditingController _nombrecontroller = TextEditingController();
  final TextEditingController _apellidocontroller = TextEditingController();
  final TextEditingController _arbolcontroller = TextEditingController();
  final TextEditingController _familiacontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

    @override
  void dispose() {
    _nombrecontroller.dispose();
    _apellidocontroller.dispose();
    _arbolcontroller.dispose();
    _familiacontroller.dispose();
    super.dispose();
  }

  
  Future _createData() async {
    print("Comenzando");
        print(_nombrecontroller.text);
        print(_apellidocontroller.text);

    if (_formKey.currentState!.validate()) {
      try {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    print(familiamodel.admin);
        // writing all the values
          familiamodel.nombre = _nombrecontroller.text;
          familiamodel.apellido = _apellidocontroller.text;
          familiamodel.arbol = _arbolcontroller.text;
          familiamodel.familia = Usuario_logeado.familia;
          familiamodel.foto = 'https://media.discordapp.net/attachments/856312697112756247/986066114364706836/unknown.png';
          familiamodel.uid = "";
          familiamodel.admin = false;
          await firebaseFirestore
              .collection('${Usuario_logeado.familia}')
              .doc("${_nombrecontroller.text} ${_apellidocontroller.text}")
              .set(familiamodel.toMap());
            
          final snackBar = SnackBar(content: Text("Familiar agregado"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
        } catch (e) {
            print(e);
            final snackBar = SnackBar(content: Text("Llena toda la informacion del familiar que quieres agregar"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
    } else {
      final snackBar = SnackBar(content: Text("Llena toda la informacion del familiar que quieres agregar"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
    }
     
        
  }

  /*DeleteData() {
    print("Eliminar");
    try {
      
    DocumentReference documentReference1 =
        FirebaseFirestore.instance.collection("${Usuario_logeado.familia}").doc('${_nombrecontroller.text} ${_apellidocontroller.text}');

    documentReference1
        .delete()
        .then((value) => print("Familiar eliminado"))
        .catchError((error) => print("Failed to delete student: $error"));

    DocumentReference documentReference2 =
        FirebaseFirestore.instance.collection("UsuariosApp").doc('${_nombrecontroller.text} ${_apellidocontroller.text}');

    documentReference2
        .delete()
        .then((value) => print("Familiar eliminado"))
        .catchError((error) => print("Failed to delete student: $error"));

    } catch (e) {
        final snackBar = SnackBar(content: Text("Familiar no encontrado"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
      
    }
  }*/


@override
  Widget build(BuildContext context) {
    return Material(
     // resizeToAvoidBottomInset: false,
      child: 
       Usuario_logeado.familia != ''?
      SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: 
                Column(
                  children: [

                    Text("Familia ${Usuario_logeado.familia}", style: GoogleFonts.kodchasan(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),                    

                    familiamodel.admin == true ?
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            validator: validatenombre,
                            controller: _nombrecontroller,
                            decoration: const InputDecoration(
                              labelText: "Nombre",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            validator: validateapellido,
                            controller: _apellidocontroller,
                            decoration: const InputDecoration(
                              labelText: "Apellido",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            validator: validatearbol,
                            controller: _arbolcontroller,
                            decoration: const InputDecoration(
                              labelText: "Arbol",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              padding: const EdgeInsets.symmetric(horizontal: 60),
                              onPressed: () {
                                _createData();
                              },
                              child: const Text("Crear", style: 
                                  TextStyle(color: Colors.white),),
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                            ),
                          ],
                        ),
                      ]
                    ): SizedBox(height: 0,),

                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("${Usuario_logeado.familia}")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index){
                                            
                                  DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                    //print(type);
                                  return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 4,
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 124.0,
                                            margin: EdgeInsets.only(left: 46),
                                            constraints: new BoxConstraints.expand(),
                                            child: Container(
                                            margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 4.0,),
                                                  
                                                  Text("${documentSnapshot["nombre"]} ${documentSnapshot["apellido"]}",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17.0, 
                                                      fontWeight: FontWeight.w600)
                                                    ),
                                                  ),

                                                  Text(documentSnapshot["arbol"],
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      color: Colors.white, 
                                                      fontSize: 16.0, 
                                                      fontWeight: FontWeight.w400)
                                                    ),
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF736AB7),
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(8.0),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 10.0),
                                                )
                                              ]
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 16),
                                            alignment: FractionalOffset.centerLeft,
                                            child: Container(
                                              height: 92,
                                              width: 92,
                                              child: CircleAvatar(
                                                radius: 90,
                                                backgroundImage: NetworkImage(
                                                    "${documentSnapshot["foto"]}",
                                                  ) 
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                    ),
                                  ),
                                ],
                              );
                                           }
                                           ) 
                            );
                                
                         /*   return ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];
                                      
                                 return Row(
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      Expanded(
                                          child: Text(documentSnapshot["StudentName"])),
                                      Expanded(
                                          child: Text(documentSnapshot["StudentID"])),
                                      Expanded(
                                          child:
                                              Text(documentSnapshot["StudentNotas"])),
                                      Expanded(
                                          child: Text(
                                              documentSnapshot["StudentProgramID"])),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data!.docs.length); */
                          } else {
                            return const Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    
                  ],
                )
              ),
            ),
          ),
        ),
      ): Huerfano()


    );

    
  }
}

/* class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network('https://img.wattpad.com/cover/180683311-288-k874977.jpg'),
            RaisedButton(onPressed: (){
              context.read<AuthenticationService>().signOut();
            },
            child: Text("Salir"), )
          ],
        )
        
        
        ),
    );
  }
} */