import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spit_hackathon/backend/services/firebase_services/dynamic_links_services.dart';
import 'package:spit_hackathon/firebase_options.dart';
import 'package:spit_hackathon/frontend/navigation/routes.dart';
import 'package:spit_hackathon/frontend/screens/authentication/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spit_hackathon/frontend/screens/posts/create_posts.dart';
import 'package:spit_hackathon/frontend/screens/posts/post_screen.dart';

late SharedPreferences sharedPreference;
Set<Widget> pages = {const CreatePost(), const PostPage()};
var routenum = 1;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for importance notifications.',
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'mainFirebaseAccount',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Geolocator.requestPermission();
  sharedPreference = await SharedPreferences.getInstance();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  !sharedPreference.containsKey('firstRun')
      ? sharedPreference.setBool('firstRun', true)
      : null;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.generatedRoutes,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Uri? linkStr;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('A new onMessageOpenedApp event was published');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          routenum = int.parse(notification.toString().toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pages.elementAt(routenum),
            ),
          );
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => PostPage()));
          // showDialog(
          //   context: context,
          //   builder: (_) {
          //     return AlertDialog(
          //       title: Text(notification.title as String),
          //       content: SingleChildScrollView(
          //           child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           TextButton(
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => TestWid(),
          //                   ),
          //                 );
          //               },
          //               child: Text("Open")),
          //           Text(notification.body as String),
          //         ],
          //       )),
          //     );
          //   },
          // );
        }
      },
    );

    DynamicLinksServices.backgroundStateDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignupPage(),
    );
  }
}
