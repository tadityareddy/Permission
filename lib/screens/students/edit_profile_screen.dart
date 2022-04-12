import 'dart:convert';
import 'package:bvrit/models/profile_data.dart';
import 'package:bvrit/screens/students/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_services.dart';
import 'package:http/http.dart' as http;
import '../../providers/profile_details_repository.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<ProfileEntity> editProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    String password = sharedPreferences.getString('password').toString();
    String email = sharedPreferences.getString('email').toString();
    String lastname = sharedPreferences.getString('lastName').toString();
    print(lastname);
    String url = "${Api.host}/auth/users/me/";
    ProfileEntity requestModel = ProfileEntity(
      firstName: firstName.text,
      lastName: lastName.text,
      rollNo: rollNo.text,
      email: email,
      branch: branch.text,
      hostler: hosteler,
      parentPhone: int.parse(parentPhone.text),
      studentPhone: int.parse(studentPhone.text),
    );
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "JWT $token",
        },
        body: jsonEncode(requestModel.toJson(password, lastname)));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      var data = ProfileEntity.fromJson(
        json.decode(response.body),
      );
      sharedPreferences.setString(
        "roll",
        "${data.rollNo}",
      );
      sharedPreferences.setString(
        "id",
        "${data.id}",
      );
      sharedPreferences.setString(
        "branch",
        "${data.branch}",
      );
      sharedPreferences.setString(
        "email",
        "${data.email}",
      );
      sharedPreferences.setString(
        "lastName",
        "${data.lastName}",
      );
      var roll = sharedPreferences.getString("roll").toString();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    roll: roll,
                  )),
          (route) => false);

      return ProfileEntity.fromJson(
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

  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfileProvider>(context).getProductList().then((value) {
        var profile =
            Provider.of<ProfileProvider>(context, listen: false).profile;

        setState(() {
          _isLoading = false;
          firstName.text = profile.firstName!;
          lastName.text = profile.lastName!;
          branch.text = profile.branch!;
          parentPhone.text = "${profile.parentPhone!}";
          studentPhone.text = "${profile.parentPhone!}";
          rollNo.text = "${profile.rollNo!}";
          hosteler = profile.hostler!;
        });
      });
    }
    _init = false;
  }

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();
  TextEditingController rollNo = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController studentPhone = TextEditingController();
  TextEditingController parentPhone = TextEditingController();

  bool hosteler = false;

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<StudentProfileProvider>(context).profile;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Color(0xff03045e),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontFamily: "Barlow",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      backgroundColor: const Color(0xff03045E),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: height * 1.2,
                      width: width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: height * 0.1,
                            child: Container(
                              height: height * 1.2,
                              width: width,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(25),
                                color: Color(0xffCAF0F8),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: width * 0.85,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: width * 0.2,
                                      ),
                                      Text(
                                        "Change picture",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Name",
                                          style: TextStyle(
                                            color: Color(0xff03045e),
                                            fontSize: width * 0.04,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff03045e),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffCAF0F8),
                                        ),
                                        child: TextFormField(
                                          controller: firstName,
                                          // initialValue:
                                          //     "${profile.firstName} ${profile.lastName}",
                                          decoration: InputDecoration(
                                            hintText: "Username",
                                            hintStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.038,
                                                color: Color(0xff000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.0121),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Roll no",
                                          style: TextStyle(
                                            color: Color(0xff03045e),
                                            fontSize: width * 0.04,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff03045e),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffCAF0F8),
                                        ),
                                        child: TextFormField(
                                          controller: rollNo,
                                          // initialValue: "${profile.rollNo}",
                                          decoration: InputDecoration(
                                            hintText: "Roll number",
                                            hintStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.038,
                                                color: Color(0xff000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.0121),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Branch",
                                          style: TextStyle(
                                            color: Color(0xff03045e),
                                            fontSize: width * 0.04,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff03045e),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffCAF0F8),
                                        ),
                                        child: TextFormField(
                                          controller: branch,
                                          // initialValue: "${profile.branch}",
                                          decoration: InputDecoration(
                                            hintText: "Branch",
                                            hintStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.038,
                                                color: Color(0xff000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.0121),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Contact number(Student)",
                                          style: TextStyle(
                                            color: Color(0xff03045e),
                                            fontSize: width * 0.04,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff03045e),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffCAF0F8),
                                        ),
                                        child: TextFormField(
                                          controller: studentPhone,
                                          // initialValue:
                                          //     "${profile.studentPhone}",
                                          decoration: InputDecoration(
                                            hintText:
                                                "Student's contact number",
                                            hintStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.038,
                                                color: Color(0xff000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.0121),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Contact number(Parent)",
                                          style: TextStyle(
                                            color: Color(0xff03045e),
                                            fontSize: width * 0.04,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff03045e),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffCAF0F8),
                                        ),
                                        child: TextFormField(
                                          controller: parentPhone,
                                          // initialValue:
                                          //     "${profile.parentPhone}",
                                          decoration: InputDecoration(
                                            hintText: "Parent's contact number",
                                            hintStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.038,
                                                color: Color(0xff000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.0121),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Day Scholar/Hosteler",
                                          style: TextStyle(
                                            color: Color(0xff03045e),
                                            fontSize: width * 0.04,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.85,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff03045e),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffCAF0F8),
                                        ),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: "Day Scholar",
                                            hintStyle: TextStyle(
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.038,
                                                color: Color(0xff000000)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.0121),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: width * 0.65,
                                        height: 51,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                          color: const Color(0xff030359),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            editProfile();
                                          },
                                          child: const Center(
                                            child: Text(
                                              "Update",
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height * 0.02,
                            child: GestureDetector(
                              onTap: () {},
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
