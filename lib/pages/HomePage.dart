import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
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
  final PageController _pageController = PageController(initialPage: 0);
  int _page = 0;
  int gaa = 0;
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