
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/EmployeeInfoModel.dart';
import '../models/EmployeeReport.dart';
import '../models/employeeProfileValue.dart';
import '../models/homePageResponse.dart';
import '../models/login_model.dart';
import '../models/refreshToken.dart';
import '../screens/constants/constants.dart';
import '../screens/constants/toast.dart';
import '../screens/login.dart';

class ApiService {
  static var client = http.Client();
  static var baseurl = "http://demo5.scarecrow.co.za/";

  static String loginUrl = baseurl + "token";
  static String pageAccessUrl = baseurl + "api/employees/authenticate";
  static String profileInfoUrl = baseurl + "api/employees/profileInfo";
  static String profileReportUrl = baseurl + "api/employees/profileReport";
  static String profileValueUrl = baseurl + "api/employees/profileValues";
  var authorization = getToken();

  static Future<LoginResponse> loginAccount(String username, String password,
      String grant_type, String latitude, String longitude) async {
    var body = {
      "username": username,
      "password": password,
      "grant_type": grant_type,
      "latitude": latitude,
      "longitude": longitude
    };
    final response = await client.post(Uri.parse(loginUrl), body: body);
    debugPrint('body:' + response.body);
    debugPrint('status:' + response.statusCode.toString());
    if (response.statusCode == 400) {
      toastMessage("	invalid user credentials");
    }
    if (response.statusCode == 200) {
      toastMessage("Login Success");

      return loginResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<PageAccessModel>> getData() async {
    debugPrint("accessToken ------->>>>> :$authorization");
    final response = await client.get(Uri.parse(pageAccessUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authorization
    });
    debugPrint(response.body);

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return pageAccessModelFromJson(response.body);
    } else if (response.statusCode == 401) {
      await getRefreshToken();
      getData();
      return pageAccessModelFromJson("");
    } else {
      throw Exception("failed to load");
    }
  }

  getResults(url, [OptionalHeaders, OptionalBody]) async {
    var headers =  {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': getToken()
    };
    if(OptionalHeaders != null) {
      headers = {...headers, ...OptionalHeaders};
    }
    print("B4 200");
    final response = await client.get(Uri.parse(url), headers:{...headers});
    if (response.statusCode == 200) {
      print("success 200");
      return response.body.toString();
    } else if (response.statusCode == 401) {
      print("unsuccess");
      print(response.statusCode);
      var success= await getRefreshToken();
      if(success){
        print("refreshed!!");
        //call getInfo again after refresh token
        // getInfo();
        // return employeeInfoFromJson("");
      }
      return false;
    } else {

      throw Exception("Refresh token failed");
    }
  }

  Future<List<EmployeeInfo>> getInfo() async {

    var responseBody = await getResults(profileInfoUrl);
    if(responseBody != "") {
      return employeeInfoFromJson(responseBody.toString());
    } else {
      throw Exception("Employee Info Failed");
    }
  }

  Future<List<EmployeeReport>> getReport() async {

    var responseBody = await getResults(profileReportUrl);
    if(responseBody != "") {
      return employeeReportFromJson(responseBody.toString());
    } else {
      throw Exception("Employee report Failed");
    }
  }

  Future<List<ProfileValue>> getProfileValue() async {
    var responseBody = await getResults(profileReportUrl);
    if(responseBody != "") {
      return profileValueFromJson(responseBody.toString());
    } else {
      throw Exception("Employee report Failed");
    }
  }
  Future<bool> getRefreshToken() async {
    debugPrint(getReToken());
    var body = {"Refresh_token": getReToken(), "grant_type": "refresh_token"};
    final response = await client.post(Uri.parse(loginUrl), body: body);
    debugPrint('body:' + response.body);
    debugPrint('status:' + response.statusCode.toString());
    if (response.statusCode == 400) {
      // _refreshExpired(context);
      toastMessage("	refresh expired");

      return false;
    } else if (response.statusCode == 200) {
      final box = GetStorage();
      var refreshBody = refreshFromJson(response.body);
      box.write(ACCESS_TOKEN, refreshBody.accessToken);
      toastMessage("Refresh success");
      print("swathiii refresh - accessToken :: ${refreshBody.accessToken}");
      return true;
    } else {
      throw Exception(response.statusCode.toString() + 'Failed to load');
    }
  }

  void _refreshExpired(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }
}
