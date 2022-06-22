import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/clases/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testfirebase/models/Familia.dart';
import 'package:testfirebase/pages/Unirse_familia.dart';
import 'package:testfirebase/pages/homepage_drawer.dart';
import 'package:testfirebase/pages/Edicion_usuario.dart';
import 'package:testfirebase/widgets/Huerfano.dart';
import 'dart:ffi';

import '../models/Users.dart';
import 'SignIn.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) { 
    runApp( HomePage123());
  });
}

const Color _color1=  Color.fromARGB(255, 255, 255, 255);

class HomePage123 extends StatelessWidget {
  const HomePage123({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(title: ""),
    );
  }
}


class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   UserModel Usuario_logeado = UserModel();
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

@override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer( child: MainDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: InkWell(
          onTap: () {
                       /*  Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                  imagenprueba())); */
                                },
          splashColor: Colors.black26,
          child: Text("RONDEROS", style: GoogleFonts.bungeeShade(textStyle: TextStyle(color: Colors.black), fontSize: 26))),
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
        Center(
          child: Text('Bienvenido')
          ): Huerfano()     
    );

    
  }
}


 
Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInPage()));
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