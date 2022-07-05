import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ronderos/models/Familia.dart';
import 'package:ronderos/pages/HomepageScreens/HP_Administrar_familia.dart';
import 'package:ronderos/pages/HomepageScreens/HP_Mapa.dart';
import 'package:ronderos/pages/HomepageScreens/HP_chat.dart';
import 'package:ronderos/pages/HomepageScreens/HP_test.dart';
import 'package:ronderos/pages/Unirse_familia.dart';
import 'package:ronderos/pages/homepage_drawer.dart';
import 'package:ronderos/pages/Edicion_usuario.dart';
import 'package:ronderos/widgets/Huerfano.dart';
import 'dart:ffi';

import '../models/Users.dart';
import 'SignIn.dart';


final FirebaseMessaging _fcm = FirebaseMessaging.instance;

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

  
   
    Familiamodel familiamodel = Familiamodel();
    UserModel Usuario_logeado = UserModel();
    final user= FirebaseAuth.instance.currentUser!;

   @override
    void initState() {
        super.initState();
        print('GAAAAAAAAAAAAAAAAAAAAAAAAAA');
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
          setState(() {});
        
        FirebaseFirestore.instance
            .collection("Familias")
            .doc(Usuario_logeado.familia!)
            .collection("Miembros")
            .doc("${Usuario_logeado.nombre}_${Usuario_logeado.apellido}_${Usuario_logeado.uid}")
            .get()
            .then((value) async{
          this.familiamodel = Familiamodel.fromMap(value.data());
          setState(() {});
      
        _fcm.unsubscribeFromTopic("Ronderos");
        String? fcmtoken = await _fcm.getToken();

          if (fcmtoken != Usuario_logeado.phonekey) {
            print("Comenzamos GAAAAAAAAAAAAAAAA");
            print("El token es: ${fcmtoken}");
            print("El antiguo Token es: ${Usuario_logeado.phonekey}");

            try {
              DocumentReference documentReference =
                  FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
              documentReference
                  .update({
                    "phonekey": fcmtoken
                  })
                  
                  .then((value) => print("Se cambio el Token en el UsuariosApp"))
                  .catchError((error) => print("Failed to update user: $error"));
            } catch (e) {
              print(e);
            }

            try {
              DocumentReference documentReference =
                  FirebaseFirestore.instance.collection("Familias").doc(Usuario_logeado.familia).collection("Miembros").doc("${Usuario_logeado.nombre}_${Usuario_logeado.apellido}_${Usuario_logeado.uid}");
              documentReference
                  .update({
                    "phonekey": fcmtoken
                  })
                  
                  .then((value) => print("Se cambio el Token en la familia/Miembros"))
                  .catchError((error) => print("Failed to update user: $error"));
            } catch (e) {
              print(e);
            }

            try {
                // writing all the values
              print(Usuario_logeado.familia);
              DocumentReference documentReference =
                  FirebaseFirestore.instance.collection("Familias").doc(Usuario_logeado.familia).collection("Tokens").doc(fcmtoken);
              documentReference
                  .set({
                    "nombre": "${Usuario_logeado.nombre}_${Usuario_logeado.apellido}",
                    "creadoEl": FieldValue.serverTimestamp(),
                    "uid": Usuario_logeado.uid,
                    "token": Usuario_logeado.phonekey,
                  })
                  
                  .then((value) => print("Se agrego un nuevo token en familia/Tokens"))
                  .catchError((error) => print("Failed to update user: $error"));
              print('Nombre: ${Usuario_logeado.nombre}_${Usuario_logeado.apellido}  ');
              } catch (e) {
                print(e);
              } 

          } if(fcmtoken == Usuario_logeado.phonekey){
            return print("Todo bien papi np pipipipipipi");
          }

        });
        });

      
      }
   
  
  final style1 = TextStyle(fontSize: 18, color: Colors.black);
  final PageController _pageController = PageController(initialPage: 0);
  
  int _page = 0;
  int gaa = 0;
    @override
  void dispose() {
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
    // resizeToAvoidBottomInset: false,
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
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (newindex){
          setState(() {
            _page = newindex;
          });
        },
        children: [
          Bienvenido(),
          Administrar_familia(),
          ChatRonderos(),
          MapaRonderos(),
        ],
      ),

    bottomNavigationBar:  Padding(
      padding: const EdgeInsets.all(12.0),
      child: GNav(
        hoverColor: Colors.black12,
        gap: 8,
        curve: Curves.ease,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        tabActiveBorder: Border.all(color: Colors.green, width: 1.5),
        tabBorderRadius: 40,
       // tabBackgroundGradient: LinearGradient(colors: [Colors.green.shade500,Colors.green.shade400, Colors.green.shade300,Colors.green.shade200,Colors.green.shade100,]),
        onTabChange: (index){
            _pageController.animateToPage(index, duration: Duration(milliseconds: 600), curve: Curves.ease);
            },
        selectedIndex: _page,
        activeColor: Colors.green,
        backgroundColor: Colors.transparent,
        tabs: [
          GButton(
            icon: Icons.home,
            iconColor: Colors.black54,
            text: "Principal",),
          GButton(
            icon: Icons.family_restroom_rounded,
            iconColor: Colors.black54,
            text: "Familia",),
          GButton(
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: Colors.black54,
            text: "Mensajes", ),
          GButton(
            icon: Icons.map_rounded,
            iconColor: Colors.black54,
            text: "Mapa", ),
        ]),
    ),  
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: (){}, 
          child: Icon(Icons.local_police, size: 45,),
            backgroundColor: Colors.green, 
            elevation: 6, ),
      ),  
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