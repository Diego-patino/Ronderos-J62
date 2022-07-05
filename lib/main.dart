import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/pages/SignIn.dart';
import 'package:ronderos/pages/Register.dart';
// import 'package:testfirebase/pages/usuarios123.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
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
        primaryColor: Colors.green
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
  void initState() {
    super.initState();
   /* FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(
          context,
          '/message',
          arguments: MessageArguments(message, true),
        );
      }
    });*/
    
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

   /* FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/message',
        arguments: MessageArguments(message, true),
      );
    });*/
    _GetToken();
    
  }


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

Future _GetToken() async {
  try {
    
    User? user = FirebaseAuth.instance.currentUser;

    _fcm.unsubscribeFromTopic("Ronderos");
    String? fcmtoken = await _fcm.getToken();

    print("El token es: ${fcmtoken}");
  } catch (e) {
    print("PUTASUMARE: ${e}");
  }

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