import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/pages/SignIn.dart';
import 'package:ronderos/pages/Register.dart';
// import 'package:testfirebase/pages/usuarios123.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RONDEROS',
     theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'RONDEROS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AuthenticationService>(
        create: (_)=> AuthenticationService(FirebaseAuth.instance),
         ),

         StreamProvider(create: (context)=> context.read<AuthenticationService>().authStateChanges, initialData: null)
    ],
    child: MaterialApp(
           initialRoute: '/',
          title: 'Ronderos',
          theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthentiacionWrapper(),
        ),
      );
  }

  
}

class AuthentiacionWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp( home 
    : StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return HomePage123();
        } else {
          return SignInPage();
        }
      } ),
  );
  
}

/*
class AuthenticationWrapper extends StatelessWidget{
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if (firebaseuser != null) {
      return HomePage123();      
    }
    return SignInPage();
  }
}*/