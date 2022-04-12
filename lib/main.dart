import 'package:bvrit/providers/product_repository.dart';
import 'package:bvrit/providers/profile_details_repository.dart';
import 'package:bvrit/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:bvrit/screens/students/auth/login_screen.dart';
import 'package:bvrit/screens/students/edit_profile_screen.dart';
import 'package:bvrit/screens/students/granted_screen.dart';
import 'package:bvrit/screens/students/home_screen.dart';
import 'package:bvrit/screens/students/profile_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String task = '';
  String uid = '';
  String token = '';
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      initialLink().then(
        (value) => {
          deepLinkURL = value,
          verify(deepLinkURL),
          task = value.split('/')[3]
        },
      );
      print(deepLinkURL);
    }
  }

  Future<String> initialLink() async {
    try {
      final initialLink = await getInitialLink();
      return initialLink!;
    } on PlatformException {
      final initialLink = await getInitialLink();
      return initialLink!;
    }
  }

  Future<Null> verify(String link) async {
    var spl = link.split('/');
    print(spl);
    print(spl[spl.length - 1]);
    print(spl[spl.length - 2]);
    print(spl[3]);
    setState(() {
      task = spl[3];
      token = spl[spl.length - 1];
      uid = spl[spl.length - 2];
    });
  }

  String deepLinkURL = '';
  @override
  void initState() {
    initialLink().then(
      (value) => {
        deepLinkURL = value,
        verify(deepLinkURL),
      },
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // ignore: deprecated_member_use
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: StudentProfileProvider()),
        ChangeNotifierProvider.value(value: RequestedPermissionListProvider()),
        ChangeNotifierProvider.value(value: PermissionProvider()),
        ChangeNotifierProvider.value(value: GrantedPermissionListProvider()),
        ChangeNotifierProvider.value(value: StudentProfileProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(
            value: AdminGrantedPermissionListProvider()),
        ChangeNotifierProvider.value(
            value: AdminRequestedPermissionListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(
          task: task,
          token: token,
          uid: uid,
        ),
      ),
    );
  }
}
