import 'package:bvrit/providers/product_repository.dart';
import 'package:bvrit/screens/students/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionDetailsScreen extends StatefulWidget {
  String id;
  PermissionDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PermissionDetailsScreen> createState() =>
      _PermissionDetailsScreenState();
}

class _PermissionDetailsScreenState extends State<PermissionDetailsScreen> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<PermissionProvider>(context)
          .getProductList(widget.id)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  bool _isDayScholar = true;
  bool _isHosteler = false;
  @override
  Widget build(BuildContext context) {
    var permission = Provider.of<PermissionProvider>(context).product;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Color(0xff03045e),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "PERMISSION DETAILS",
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
      backgroundColor: Color(0xffCAF0F8),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Center(
                  child: SizedBox(
                    width: width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${permission.date}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "From time",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${permission.fromTime}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "To time",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${permission.outDate}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reason",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${permission.reason}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.15,
                        ),

                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "PROOF(If any)",
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 18,
                        //       fontFamily: "Lato",
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 8.0),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "${permission.attachment}",
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 16,
                        //         fontFamily: "Lato",
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                var roll = sharedPreferences
                                    .getString("roll")
                                    .toString();

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                              roll: roll,
                                            )),
                                    (route) => false);
                              },
                              child: const Center(
                                child: Text(
                                  "Go Home",
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
