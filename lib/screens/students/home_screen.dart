import 'package:bvrit/providers/product_repository.dart';
import 'package:bvrit/providers/profile_details_repository.dart';
import 'package:bvrit/screens/students/granted_screen.dart';
import 'package:bvrit/screens/students/permission_details.dart';
import 'package:bvrit/screens/students/profile_screen.dart';
import 'package:bvrit/screens/students/request_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../widgets/requesttile.dart';
import 'edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.roll}) : super(key: key);
  String roll;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<StudentProfileProvider>(context)
          .getProductList()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<RequestedPermissionListProvider>(context)
          .getProductList("${widget.roll}")
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<GrantedPermissionListProvider>(context)
          .getProductList("${widget.roll}")
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

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
    var profile = Provider.of<StudentProfileProvider>(context).profile;
    var requested =
        Provider.of<RequestedPermissionListProvider>(context).productList;
    var granted =
        Provider.of<GrantedPermissionListProvider>(context).productList;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff03045E),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: height +
                          height *
                              0.15 *
                              (_isGranted ? granted.length : requested.length),
                      width: width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: height * 0.1,
                            child: Container(
                              height: height +
                                  height *
                                      0.15 *
                                      (_isGranted
                                          ? granted.length
                                          : requested.length),
                              width: width,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(25),
                                color: Color(0xffCAF0F8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: width * 0.2,
                                  ),
                                  Text(
                                    "${profile.firstName} ${profile.lastName}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${profile.rollNo}",
                                    style: TextStyle(
                                      color: Color(0xad000000),
                                      fontSize: 15,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${profile.branch}",
                                    style: TextStyle(
                                      color: Color(0xad000000),
                                      fontSize: 15,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w500,
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
                                                  builder: (context) =>
                                                      RequestScreen()),
                                              (route) => true);
                                        },
                                        child: const Text(
                                          "REQUEST FOR PERMISSION",
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width * 0.9,
                                      height: 57,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0x33000000),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.9,
                                            height: 57,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => _request(),
                                                  child: Container(
                                                    height: height * 0.045,
                                                    width: width * 0.38,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      _isRequested
                                                          ? "         "
                                                          : "REQUESTED",
                                                      style: TextStyle(
                                                        color: _isRequested
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily: "Barlow",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.04,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => _granted(),
                                                  child: Container(
                                                    height: height * 0.045,
                                                    width: width * 0.38,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      _isGranted
                                                          ? "       "
                                                          : "GRANTED",
                                                      style: TextStyle(
                                                        color: _isGranted
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily: "Barlow",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.04,
                                                      ),
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: AnimatedAlign(
                                              alignment: _isRequested == true
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                              duration:
                                                  Duration(milliseconds: 200),
                                              child: Container(
                                                width: width * 0.43,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xff03045e),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  _isRequested == true
                                                      ? "REQUESTED"
                                                      : "GRANTED",
                                                  style: TextStyle(
                                                    fontFamily: "Barlow",
                                                    color: Color(0xFFFFFFFF),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.04,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  StreamBuilder(builder: (context, snapshot) {
                                    return Container();
                                  }),
                                  Container(
                                    height: height *
                                        0.15 *
                                        (_isGranted
                                            ? granted.length
                                            : requested.length),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _isGranted
                                            ? granted.length
                                            : requested.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              _isGranted
                                                                  ? GrantedDetailsScreen(
                                                                      id: "${granted[index].id}",
                                                                    )
                                                                  : PermissionDetailsScreen(
                                                                      id: "${requested[index].id}",
                                                                    )),
                                                      (route) => true);
                                                },
                                                child: _isGranted
                                                    ? StudentRequestTile(
                                                        date:
                                                            "${granted[index].date}",
                                                        reason:
                                                            "${granted[index].reason}",
                                                      )
                                                    : StudentRequestTile(
                                                        date:
                                                            "${requested[index].date}",
                                                        reason:
                                                            "${requested[index].reason}",
                                                      ),
                                              ));
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.02,
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
                                  // child: Image.asset(
                                  //   "assets/images/profile.jpeg",
                                  //   fit: BoxFit.cover,
                                  // ),
                                  child: CachedNetworkImage(
                                      imageUrl: '${profile.dp}',
                                      fit: BoxFit.contain),
                                ),
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
