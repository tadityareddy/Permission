import 'dart:async';
import 'package:bvrit/screens/admins/home_screen.dart';
import 'package:bvrit/screens/students/auth/login_screen.dart';
import 'package:bvrit/screens/students/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/auth_api.dart';

String? finalToken;
// ignore: non_constant_identifier_names

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key? key,
    required this.task,
    required this.uid,
    required this.token,
  }) : super(key: key);
  String task;
  String uid;
  String token;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (widget.task == 'activation') {
      AuthApi.activation(widget.uid, widget.token);
    }
    // verify(deepLinkURL);
    getToken().whenComplete(() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var type = sharedPreferences.getString("type").toString();
      var roll = sharedPreferences.getString("roll").toString();
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => finalToken == null
                    ? LoginScreen()
                    : type == "STUDENT"
                        ? HomeScreen(
                            roll: roll,
                          )
                        : AdminHomeScreen()),
            (route) => false),
      );
    });

    super.initState();
  }

  Future getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getString("token");
    finalToken = obtainedToken;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }
}
