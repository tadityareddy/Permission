import 'dart:convert';

import 'package:bvrit/api/profileservices.dart';
import 'package:bvrit/screens/admins/home_screen.dart';
import 'package:bvrit/screens/students/edit_profile_screen.dart';
import 'package:bvrit/screens/students/home_screen.dart';
import 'package:bvrit/screens/students/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../api/api_services.dart';
import '../../../models/login_request_model.dart';
import '../../../models/login_response_model.dart';
import '../../../models/profile_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<LoginResponseModel> login(String email, String password) async {
    String url = "${Api.host}/auth/jwt/create/";
    LoginRequestModel requestModel =
        LoginRequestModel(email: email, password: password);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {
      Map<String, dynamic> output = json.decode(response.body);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        "password",
        password,
      );
      sharedPreferences.setString("token", output['access']);
      print(output['access']);
      var profile = await ProfileDetails.profile();
      final responseData = json.decode(profile.body);
      ProfileEntity repo = ProfileEntity(
        id: responseData["id"],
        firstName: responseData['first_name'],
        lastName: responseData['last_name'],
        email: responseData['email'],
        branch: responseData['branch'],
        dp: responseData['dp'],
        grantedby: responseData['grantedby'],
        hostler: responseData['hosteler'],
        parentPhone: responseData['parent_phone'],
        rollNo: responseData['roll_no'],
        studentPhone: responseData['student_phone'],
        typeOfAccount: responseData['type_of_account'],
      );
      if (repo.branch == null ||
          repo.parentPhone == null ||
          repo.rollNo == null ||
          repo.studentPhone == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen()),
            (route) => false);
      }
      sharedPreferences.setString(
        "roll",
        "${repo.rollNo}",
      );
      sharedPreferences.setString(
        "id",
        "${repo.id}",
      );

      sharedPreferences.setString(
        "branch",
        "${repo.branch}",
      );
      sharedPreferences.setString(
        "type",
        "${repo.typeOfAccount}",
      );
      sharedPreferences.setString(
        "email",
        "${repo.email}",
      );
      sharedPreferences.setString(
        "lastName",
        "${repo.lastName}",
      );
      var roll = sharedPreferences.getString("roll").toString();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => repo.typeOfAccount == "STUDENT"
                  ? HomeScreen(
                      roll: roll,
                    )
                  : repo.typeOfAccount == "ADMIN"
                      ? AdminHomeScreen()
                      : HomeScreen(
                          roll: roll,
                        )),
          (route) => false);
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                json.decode(response.body)["detail"],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
      throw Exception('Failed to load data!');
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _emailTC = TextEditingController();
  final TextEditingController _passwordTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xffA3DEEB),
        body: ListView(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: width * 0.74,
                height: height,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.35,
                        child: Center(
                          child: Image.asset("assets/images/finallogo.png"),
                        ),
                      ),
                      const Text(
                        "Log in to your account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: width * 0.74,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xffffffff),
                        ),
                        child: TextFormField(
                          controller: _emailTC,
                          validator: (val) {
                            MultiValidator([
                              RequiredValidator(
                                  errorText: "Email is required to login"),
                              EmailValidator(
                                  errorText:
                                      "Enter a valid mail Id(check whether any extra character added)"),
                            ]);
                            if (!val!.contains("@bvrit.ac.in")) {
                              return "Please login with college mail id";
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: "Enter your Mail ID",
                            hintStyle: TextStyle(
                              fontFamily: 'Barlow',
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.038,
                              color: const Color(0xff000000),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.0121),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: width * 0.74,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xffffffff),
                        ),
                        child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Enter password to login"),
                          ]),
                          controller: _passwordTC,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: "Enter your Password",
                            hintStyle: TextStyle(
                              fontFamily: 'Barlow',
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.038,
                              color: const Color(0xff000000),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.0121),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      Container(
                        width: width * 0.5,
                        height: 51,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3f000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: const Color(0xff030359),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: MaterialButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                final String email = _emailTC.text;
                                final String password = _passwordTC.text;
                                showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    useSafeArea: false,
                                    builder: (context) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 0, 157, 255),
                                        ),
                                      );
                                    });
                                await login(email, password);
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account yet?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpPassword()),
                                      (route) => false);
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Color(0xff030359),
                                    fontSize: 14,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
