import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_services.dart';
import '../models/permission_entity.dart';

class RequestedPermissionListProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late List<PermissionEntity> _productList = [];

  List<PermissionEntity> get productList {
    return [..._productList];
  }

  Future<void> getProductList(String rollNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    var response = await http.get(
        Uri.parse(
            '${Api.host}/granted_roll/?student_roll=$rollNumber&granted=false'),
        headers: {
          "Authorization": "JWT $token",
        });
    print(response.body);
    List<PermissionEntity> productList = [];
    final responseData = json.decode(response.body) as List;

    for (int i = 0; i < responseData.length; i++) {
      PermissionEntity repo = PermissionEntity(
        date: responseData[i]['date'],
        fromTime: responseData[i]['from_time'],
        slug: responseData[i]['slug'],
        granted: responseData[i]['granted'],
        attachment: responseData[i]['attachment'],
        id: responseData[i]['id'],
        outDate: responseData[i]['out_date'],
        qrCode: responseData[i]['qr_code'],
        reason: responseData[i]['reason'],
        rollNumber: responseData[i]['roll_number'],
        branch: responseData[i]['branch'],
        phone: responseData[i]['phone'],
        studentRoll: responseData[i]['student_roll'],
        rejected: responseData[i]['rejected'],
      );

      productList.add(repo);
    }

    _productList = productList;
    notifyListeners();
  }
}

class GrantedPermissionListProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late List<PermissionEntity> _productList = [];

  List<PermissionEntity> get productList {
    return [..._productList];
  }

  Future<void> getProductList(String roll_number) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    var response = await http.get(
        Uri.parse(
            '${Api.host}/granted_roll/?student_roll=$roll_number&granted=true'),
        headers: {
          "Authorization": "JWT $token",
        });

    List<PermissionEntity> productList = [];
    final responseData = json.decode(response.body) as List;

    for (int i = 0; i < responseData.length; i++) {
      PermissionEntity repo = PermissionEntity(
        date: responseData[i]['date'],
        fromTime: responseData[i]['from_time'],
        slug: responseData[i]['slug'],
        granted: responseData[i]['granted'],
        attachment: responseData[i]['attachment'],
        id: responseData[i]['id'],
        outDate: responseData[i]['out_date'],
        qrCode: responseData[i]['qr_code'],
        reason: responseData[i]['reason'],
        rollNumber: responseData[i]['roll_number'],
        branch: responseData[i]['branch'],
        phone: responseData[i]['phone'],
        studentRoll: responseData[i]['student_roll'],
        rejected: responseData[i]['rejected'],
      );

      productList.add(repo);
    }

    _productList = productList;
    notifyListeners();
  }
}

class PermissionProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late PermissionEntity _product = PermissionEntity();

  PermissionEntity get product {
    return _product;
  }

  Future<void> getProductList(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    var response = await http.get(
      Uri.parse('${Api.host}/permission/$id'),
      headers: {"Authorization": "JWT $token"},
    );

    final responseData = json.decode(response.body);

    PermissionEntity repo = PermissionEntity(
      date: responseData['date'],
      fromTime: responseData['from_time'],
      slug: responseData['slug'],
      granted: responseData['granted'],
      attachment: responseData['attachment'],
      id: responseData['id'],
      outDate: responseData['out_date'],
      qrCode: responseData['qr_code'],
      reason: responseData['reason'],
      rollNumber: responseData['roll_number'],
      branch: responseData['branch'],
      phone: responseData['phone'],
      studentRoll: responseData['student_roll'],
      rejected: responseData['rejected'],
    );

    _product = repo;
    notifyListeners();
  }
}

class AdminRequestedPermissionListProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late List<PermissionEntity> _productList = [];

  List<PermissionEntity> get productList {
    return [..._productList];
  }

  Future<void> getProductList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    String branch = sharedPreferences.getString('branch').toString();
    var response = await http.get(
        Uri.parse('${Api.host}/branchgrant/?branch=$branch&granted=false'),
        headers: {
          "Authorization": "JWT $token",
        });
    print(response.body);
    List<PermissionEntity> productList = [];
    final responseData = json.decode(response.body) as List;

    for (int i = 0; i < responseData.length; i++) {
      PermissionEntity repo = PermissionEntity(
        date: responseData[i]['date'],
        fromTime: responseData[i]['from_time'],
        slug: responseData[i]['slug'],
        granted: responseData[i]['granted'],
        attachment: responseData[i]['attachment'],
        id: responseData[i]['id'],
        outDate: responseData[i]['out_date'],
        qrCode: responseData[i]['qr_code'],
        reason: responseData[i]['reason'],
        rollNumber: responseData[i]['roll_number'],
        branch: responseData[i]['branch'],
        phone: responseData[i]['phone'],
        studentRoll: responseData[i]['student_roll'],
        rejected: responseData[i]['rejected'],
      );

      productList.add(repo);
    }

    _productList = productList;
    notifyListeners();
  }
}

class AdminGrantedPermissionListProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late List<PermissionEntity> _productList = [];

  List<PermissionEntity> get productList {
    return [..._productList];
  }

  Future<void> getProductList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    String branch = sharedPreferences.getString('branch').toString();
    var response = await http.get(
        Uri.parse('${Api.host}/branchgrant/?branch=$branch&granted=true'),
        headers: {
          "Authorization": "JWT $token",
        });

    List<PermissionEntity> productList = [];
    final responseData = json.decode(response.body) as List;

    for (int i = 0; i < responseData.length; i++) {
      PermissionEntity repo = PermissionEntity(
        date: responseData[i]['date'],
        fromTime: responseData[i]['from_time'],
        slug: responseData[i]['slug'],
        granted: responseData[i]['granted'],
        attachment: responseData[i]['attachment'],
        id: responseData[i]['id'],
        outDate: responseData[i]['out_date'],
        qrCode: responseData[i]['qr_code'],
        reason: responseData[i]['reason'],
        rollNumber: responseData[i]['roll_number'],
        branch: responseData[i]['branch'],
        phone: responseData[i]['phone'],
        studentRoll: responseData[i]['student_roll'],
        rejected: responseData[i]['rejected'],
      );

      productList.add(repo);
    }

    _productList = productList;
    notifyListeners();
  }
}
