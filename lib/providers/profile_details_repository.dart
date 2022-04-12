import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/profileservices.dart';
import '../models/profile_data.dart';

class ProfileProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late ProfileEntity _profile = ProfileEntity();

  ProfileEntity get profile {
    return _profile;
  }

  Future<void> getProductList() async {
    var response = await ProfileDetails.profile();

    final responseData = json.decode(response.body);

    ProfileEntity repo = ProfileEntity(
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
      userPermissions: responseData['userPermissions'],
    );

    _profile = repo;
    notifyListeners();
  }
}

class StudentProfileProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late ProfileEntity _profile = ProfileEntity();

  ProfileEntity get profile {
    return _profile;
  }

  Future<void> getProductList() async {
    var response = await ProfileDetails.profile();

    final responseData = json.decode(response.body);

    ProfileEntity repo = ProfileEntity(
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
      userPermissions: responseData['userPermissions'],
    );

    _profile = repo;
    notifyListeners();
  }
}
