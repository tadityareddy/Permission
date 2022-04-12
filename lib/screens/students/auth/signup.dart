import 'package:bvrit/screens/admins/profile_screen.dart';
import 'package:bvrit/screens/students/auth/login_screen.dart';
import 'package:bvrit/screens/students/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../api/auth_api.dart';

class SignUpPassword extends StatefulWidget {
  const SignUpPassword({Key? key}) : super(key: key);

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController _emailTC = TextEditingController();
  TextEditingController _passwordTC = TextEditingController();
  TextEditingController _repasswordTC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffA3DEEB),
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
                        height: height * 0.3,
                        child: Center(
                          child: Image.asset("assets/images/finallogo.png"),
                        ),
                      ),
                      const Text(
                        "Create an account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
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
                                  errorText: "Enter the college email"),
                              EmailValidator(errorText: "Enter a valid mail id")
                            ]);
                            if (!val!.contains("@bvrit.ac.in")) {
                              return "Use college email";
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
                          color: Color(0xffffffff),
                        ),
                        child: TextFormField(
                          controller: _passwordTC,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Enter a password"),
                          ]),
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
                          "Confirm Password",
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
                          controller: _repasswordTC,
                          validator: (val) {
                            MultiValidator([
                              RequiredValidator(
                                  errorText: "Enter the password again"),
                            ]);
                            if (val != _passwordTC.text) {
                              return "Enter the same password you have used above";
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: "Re-enter your Password",
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

                      SizedBox(
                        height: height * 0.17,
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
                            onPressed: () {
                              print("ok");

                              if (formkey.currentState!.validate()) {
                                print("ok");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpDetails(
                                        confirmPassword: _repasswordTC.text,
                                        email: _emailTC.text,
                                        password: _passwordTC.text,
                                      ),
                                    ),
                                    (route) => true);
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Next",
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
                                "Already have an account?",
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
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: Text(
                                  "Log in",
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

class SignUpDetails extends StatefulWidget {
  late String email;
  late String password;
  late String confirmPassword;
  SignUpDetails(
      {Key? key,
      required this.confirmPassword,
      required this.email,
      required this.password})
      : super(key: key);

  @override
  State<SignUpDetails> createState() => _SignUpDetailsState();
}

class _SignUpDetailsState extends State<SignUpDetails> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController _rollNo = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffA3DEEB),
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
                        height: height * 0.3,
                        child: Center(
                          child: Image.asset("assets/images/finallogo.png"),
                        ),
                      ),
                      const Text(
                        "Create an account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Roll no",
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
                          controller: _rollNo,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: "Enter your Roll no",
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
                          "First name",
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
                          controller: _firstName,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Enter a valid name")
                          ]),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: "Enter your First name",
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
                          "Last name",
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
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Enter a valid name")
                          ]),
                          controller: _lastName,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hintText: "Enter your Last name",
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
                      SizedBox(
                        height: height * 0.17,
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
                                showDialog(
                                    barrierDismissible: false,
                                    useRootNavigator: false,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 0, 238, 255),
                                        ),
                                      );
                                    });
                                await createUserSignup(
                                    widget.email,
                                    widget.password,
                                    widget.confirmPassword,
                                    _firstName.text,
                                    _lastName.text);
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Sign Up",
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
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: Text(
                                  "Log in",
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

  Future<void> createUserSignup(String email, String password,
      String confirmPassword, String firstName, String lastName) async {
    print("ok");
    final response = await AuthApi.signUp(
        email, password, confirmPassword, firstName, lastName);
    if (response != null) {
      if (response == '400') {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: Text("Email is already avaliable"),
              );
            });
      }
      print(response);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}

class SignUpcontactinfo extends StatefulWidget {
  const SignUpcontactinfo({Key? key}) : super(key: key);

  @override
  State<SignUpcontactinfo> createState() => _SignUpcontactinfoState();
}

class _SignUpcontactinfoState extends State<SignUpcontactinfo> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _contactNo1 = TextEditingController();
  TextEditingController _contactNo2 = TextEditingController();
  TextEditingController _hosteler = TextEditingController();
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
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.3,
                    ),
                    const Text(
                      "Create an account",
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
                        "Contact number(Student)",
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
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hintText: "Enter your Contact number(Student)",
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
                        "Contact number(Parent)",
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
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hintText: "Enter your Contact number(Parent)",
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
                        "Hostler/Day Scholar",
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
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hintText: "Type of student",
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

                    SizedBox(
                      height: height * 0.17,
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
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: Center(
                            child: Text(
                              "Sign up",
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
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                "Log in",
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
            )
          ],
        ));
  }
}
