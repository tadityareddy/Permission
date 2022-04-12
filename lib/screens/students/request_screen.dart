import 'dart:convert';

import 'package:bvrit/models/permission_entity.dart';
import 'package:bvrit/screens/students/permission_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_services.dart';
import 'package:http/http.dart' as http;

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  Future<PermissionEntity> requestPermission() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    int id = int.parse(sharedPreferences.getString('id').toString());
    String roll = sharedPreferences.getString('roll').toString();
    String branch = sharedPreferences.getString('branch').toString();
    String url = "${Api.host}/permission/";
    PermissionEntity requestModel = PermissionEntity(
      date: "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}",
      fromTime: "${fromTime.hour}:${fromTime.minute}",
      outDate: "${toTime.hour}:${toTime.minute}",
      reason: reason.text,
      granted: false,
      studentRoll: roll,
      rollNumber: id,
      branch: branch,
    );
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "JWT $token",
        },
        body: jsonEncode(requestModel.toJson()));
    //   body: {
    //     "student_roll": "20211A6604",
    //     "attachment": null,
    //     "granted": false,
    //     "rejected": false,
    //     "slug": null,
    //     "phone": 9876543210,
    //     "date": "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}",
    //     "fromTime": "${fromTime.hour}:${fromTime.minute}",
    //     "outDate": "${toTime.hour}:${toTime.minute}",
    //     "reason": reason.text,
    //     "roll_number": id
    //   },
    // );
    // body: map);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> output = json.decode(response.body);
      var data = PermissionEntity.fromJson(
        json.decode(response.body),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => PermissionDetailsScreen(
                    id: '${data.id}',
                  )),
          (route) => false);

      return PermissionEntity.fromJson(
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

  late DateTime pickedDate;
  late TimeOfDay fromTime;
  late TimeOfDay toTime;
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    fromTime = TimeOfDay.now();
    toTime = TimeOfDay.now();
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        pickedDate = date;
      });
  }

  _pickfromTime() async {
    TimeOfDay? t =
        await showTimePicker(context: context, initialTime: fromTime);
    if (t != null) {
      setState(() {
        fromTime = t;
      });
    }
  }

  _picktoTime() async {
    TimeOfDay? t =
        await showTimePicker(context: context, initialTime: fromTime);
    if (t != null) {
      setState(() {
        toTime = t;
      });
    }
  }

  TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Color(0xff03045e),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "REQUEST A PERMISSION",
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
      backgroundColor: const Color(0xffCAF0F8),
      body: ListView(
        children: [
          SizedBox(
            width: width,
            child: Column(
              children: [
                // SizedBox(
                //   height: height * 0.02,
                // ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.7,
                  width: width * 0.9,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff03045e),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffCAF0F8),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                                "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                            trailing: const Icon(Icons.keyboard_arrow_down),
                            onTap: _pickDate,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff03045e),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffCAF0F8),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                                "From Time: ${fromTime.hour}:${fromTime.minute}"),
                            trailing: const Icon(Icons.keyboard_arrow_down),
                            onTap: _pickfromTime,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.07,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff03045e),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffCAF0F8),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                                "To Time: ${toTime.hour}:${toTime.minute}              (optional)"),
                            trailing: const Icon(Icons.keyboard_arrow_down),
                            onTap: _picktoTime,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "REASON",
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
                        height: height * 0.15,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff03045e),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffCAF0F8),
                        ),
                        child: TextFormField(
                          controller: reason,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Reason",
                            hintStyle: TextStyle(
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.038,
                                color: Color(0xff000000)),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(width * 0.0121),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         "PROOF",
                      //         style: TextStyle(
                      //             fontFamily: 'Barlow',
                      //             fontWeight: FontWeight.w800,
                      //             fontSize: width * 0.038,
                      //             color: Color(0xff000000)),
                      //       ),
                      //       Text(
                      //         "  (If any)",
                      //         style: TextStyle(
                      //             fontFamily: 'Barlow',
                      //             fontWeight: FontWeight.w400,
                      //             fontSize: width * 0.025,
                      //             color: Color(0xff000000)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   height: height * 0.07,
                      //   width: width * 0.85,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       width: 1,
                      //       color: Color(0xff03045e),
                      //     ),
                      //     borderRadius: BorderRadius.circular(8),
                      //     color: Color(0xffCAF0F8),
                      //   ),
                      //   child: GestureDetector(
                      //     onTap: () {},
                      //     child: Container(
                      //         width: width * 0.3,
                      //         height: 35,
                      //         decoration: BoxDecoration(
                      //           // borderRadius: BorderRadius.circular(40),
                      //           color: Color(0x727abbea),
                      //         ),
                      //         child: Icon(Icons.file_upload_outlined)),
                      //   ),
                      // )
                    ],
                  ),
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
                        requestPermission();
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
