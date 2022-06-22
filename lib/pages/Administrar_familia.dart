import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/clases/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testfirebase/models/Familia.dart';
import 'package:testfirebase/pages/HomePage.dart';
import 'package:testfirebase/pages/homepage_drawer.dart';
import 'package:testfirebase/pages/Edicion_usuario.dart';
import 'package:testfirebase/widgets/Huerfano.dart';
import 'dart:ffi';

import '../models/Users.dart';
import 'SignIn.dart';
import 'Unirse_familia.dart';


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
        });
      }
   
  
  final style1 = TextStyle(fontSize: 18, color: Colors.black);
  final TextEditingController _nombrecontroller = TextEditingController();
  final TextEditingController _apellidocontroller = TextEditingController();
  final TextEditingController _arbolcontroller = TextEditingController();
  final TextEditingController _familiacontroller = TextEditingController();

    @override
  void dispose() {
    _nombrecontroller.dispose();
    _apellidocontroller.dispose();
    _arbolcontroller.dispose();
    _familiacontroller.dispose();
    super.dispose();
  }

  
  Future createData() async {
    print("created");

        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        Familiamodel familiamodel = Familiamodel();

        // writing all the values
        familiamodel.nombre = _nombrecontroller.text;
        familiamodel.apellido = _apellidocontroller.text;
        familiamodel.arbol = _arbolcontroller.text;
        familiamodel.familia = Usuario_logeado.familia;
        await firebaseFirestore
            .collection('${Usuario_logeado.familia}')
            .doc(_arbolcontroller.text)
            .set(familiamodel.toMap());
  }

  DeleteData() {
    print("Eliminar");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("${Usuario_logeado.familia}").doc('${_arbolcontroller.text}');

    documentReference
        .delete()
        .then((value) => print("Familiar eliminado"))
        .catchError((error) => print("Failed to delete student: $error"));
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer( child: MainDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                  HomePage123())); 
                                },
          splashColor: Colors.black26,
          child: Text("RONDEROS", style: GoogleFonts.bungeeShade(textStyle: TextStyle(color: Colors.black), fontSize: 26)
            )
          ),
        actions: [
        Builder(
          builder: (context){
            return IconButton(
          
          onPressed: ()=> Scaffold.of(context).openEndDrawer(),
          icon: CircleAvatar(
                  backgroundImage: NetworkImage(
                    Usuario_logeado.foto.toString(),
                  ),
                ));
          })
      ],), 
      
      
      body: 
       Usuario_logeado.familia != ''?
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: 
              
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
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
                    child: TextField(
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
                    child: TextField(
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
                          createData();
                        },
                        child: const Text("Crear", style: 
                            TextStyle(color: Colors.white),),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        onPressed: () {
                         DeleteData();
                        },
                        child: const Text("Borrar", style: 
                            TextStyle(color: Colors.white),),
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("${Usuario_logeado.familia}")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 3, ), 
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index){
                                        
                                        DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                       //print(type);
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 7),
                                          child: Container(
                                                        decoration: BoxDecoration(
                                                          color:Colors.redAccent[200],
                                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                          
                                          child: Stack(
                                          children: [
                                                                
                              Stack(
                              children: [
                                Center(
                                  child: Stack(
                                  alignment: Alignment(0.0, -0.2),
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      width: 200,
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment(0.0, -0.2),
                                      child: Text(
                                        (documentSnapshot["nombre"]),
                                          style: GoogleFonts.righteous(textStyle: style1
                                        )),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            Stack(
                              children: [
                                Center(
                                  child: Stack(
                                  alignment: Alignment(0.0, 0.2),
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      width: 200,
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment(0.0, 0.2),
                                      child: Text(
                                        (documentSnapshot["apellido"]),
                                          style: GoogleFonts.righteous(textStyle: style1
                                        )),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                               
                              Positioned(
                                  top: 6,
                                  left: 2,
                                  child: Text((documentSnapshot["arbol"]),style: GoogleFonts.kronaOne(
                                    textStyle: 
                                    TextStyle(
                                      fontSize: 14,
                                      color: Colors.white)),)),
                              Positioned(
                                  bottom: 6,
                                  right: 2,
                                  child: Text((documentSnapshot["familia"]),style: GoogleFonts.kronaOne(
                                    textStyle: 
                                    TextStyle(
                                      fontSize: 14,
                                      color: Colors.white)),)),
                                                            
                                                          ]),
                                          )  
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
                  
                ],
              )
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