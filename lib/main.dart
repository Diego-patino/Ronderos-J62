import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ronderos/clases/auth_service.dart';
import 'package:ronderos/pages/Alerta.dart';
import 'package:ronderos/pages/AuthWrapper.dart';
import 'package:ronderos/pages/ErrorRoute.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:ronderos/pages/SignIn.dart';
import 'package:ronderos/pages/Register.dart';

import 'dart:async';


// import 'package:testfirebase/pages/usuarios123.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FirebaseMessaging _fcm = FirebaseMessaging.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey(
  debugLabel: "Main Navigator");
  
String? payload;
//String? routeToGo = '/';
late String routeToGo = '/';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // titletion
  importance: Importance.high,

  
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

  print("_firebaseMessagingBackgroundHandler Clicked!");
   routeToGo = '/second';
   print(message.notification!.body);

   /*
   flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
        ),
      ));
      */
}

Future<void> selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
    navigatorKey.currentState?.pushNamed('/second');
    print('JAAJAJAJAJJA ${payload.toString()}');
    print(navigatorKey.currentState);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

        var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();


    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

        StreamController<String> _messageStream =
            new StreamController.broadcast();
            
        Stream<String> messagesStream = _messageStream.stream;

        Future _backgroundHandler(RemoteMessage message) async {
          print('onBackground Handler ${message.messageId}');
          print("HTREGEGF: ${message.data}");
          _messageStream.add(message.data['Ronderos'] ?? 'No data');
        }

        Future _onMessageHandler(RemoteMessage message) async {
          // print( 'onMessage Handler ${ message.messageId }');
          print("HTREGEGF: ${message.data}");
          _messageStream.add(message.data['Ronderos'] ?? 'No data');
        }

        Future _onMessageOpenApp(RemoteMessage message) async {
          // print( 'onMessageOpenApp Handler ${ message.messageId }');
          print("HTREGEGF: ${message.data}");
          _messageStream.add(message.data['Ronderos'] ?? 'No data');
        }

          // Push Notifications
      /*    await Firebase.initializeApp();
          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );*/
          // Handlers
          FirebaseMessaging.onMessage.listen(_onMessageHandler);
          FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp); 

    print('payload=$payload');
    payload= notificationAppLaunchDetails!.payload;
      if(payload != null){
        routeToGo = '/second';
        navigatorKey.currentState?.pushNamed('/second');
        print(routeToGo);
        print('GAAAAAAAA $payload');
      }

      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.notification!.body != null);
        if (message.notification!.body != null) {
          navigatorKey.currentState?.pushNamed('/second');
          routeToGo ='/second';
        }
    });

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
              icon: android.smallIcon,
            ),
          ),
        );
        
          print("Titulo ${notification.title}");
          
          print("Cuerpo ${notification.body}");
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
          navigatorKey: navigatorKey,
          initialRoute: (routeToGo!= null)? routeToGo = '/':routeToGo,
          title: 'Ronderos',
          theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute:(RouteSettings settings) {
          switch (settings.name) {
            case '/second':
              return MaterialPageRoute(
                builder: (_) => const Alerta(),
              );
              break;
            case '/':
              return MaterialPageRoute(
                builder: (_) => const AuthenticationWrapper() );
            default:
              return MaterialPageRoute(builder: (_) => const errorRoute());
          }},
        ),
      );
  }

  
}

Future _GetToken() async {
  try {
    
    User? user = FirebaseAuth.instance.currentUser;

    _fcm.unsubscribeFromTopic("Ronderos");
    String? fcmtoken = await _fcm.getToken();

    print("El token es: ${fcmtoken}");
  } catch (e) {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAA: ${e}");
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