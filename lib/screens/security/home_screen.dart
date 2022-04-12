import 'package:bvrit/screens/security/scan_qr.dart';
import 'package:bvrit/screens/students/permission_details.dart';
import 'package:bvrit/screens/students/profile_screen.dart';
import 'package:bvrit/screens/students/request_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import '../../widgets/requesttile.dart';
import '../admins/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
                // channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                //  channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  int itemcount = 2;
  bool _isRequested = true;
  bool _isGranted = false;
  void _request() {
    setState(() {
      if (_isRequested == false) {
        itemcount = 2;
        _isRequested = true;
        _isGranted = false;
      }
    });
  }

  void _granted() {
    setState(() {
      if (_isGranted == false) {
        itemcount = 5;

        _isRequested = false;
        _isGranted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff03045E),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.7 + height * 0.15 * itemcount,
                width: width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: height * 0.15,
                      child: Container(
                        height: height * 0.7 + height * 0.15 * itemcount,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffCAF0F8),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: width * 0.2,
                            ),
                            Text(
                              "USERNAME",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: width * 0.85,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: const Color(0xff03045e),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScanScreen()),
                                        (route) => true);
                                  },
                                  child: const Text(
                                    "SCAN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                                width: width * 0.9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "HISTORY",
                                      style: TextStyle(
                                        color: Color(0xff03045e),
                                        fontSize: 20,
                                        fontFamily: "Barlow",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(Icons.filter_alt_outlined)
                                  ],
                                )),
                            Container(
                              height: height * 0.15 * itemcount,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: itemcount,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PermissionDetailsScreen(
                                                          id: '',
                                                        )),
                                                (route) => true);
                                          },
                                          child: StudentRequestTile(
                                            date: '',
                                            reason: '',
                                          ),
                                        ));
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.07,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                              (route) => true);
                        },
                        child: Container(
                          height: width * 0.35,
                          width: width * 0.35,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: const Color(0xffCAF0F8),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/profile.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.12,
                      right: width * 0.05,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff03045E),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xffCAF0F8),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()),
                                (route) => true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
