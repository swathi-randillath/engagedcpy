import 'package:flutter/cupertino.dart';
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
      getRefreshToken();
      return pageAccessModelFromJson("");
    } else {
      throw Exception("failed to load");
    }
  }

  Future<List<EmployeeInfo>> getInfo() async {
    final response = await client.get(Uri.parse(profileInfoUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authorization
    });
    debugPrint(response.body);
    print("token=$authorization");


    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return employeeInfoFromJson(response.body);
    } else {
      throw Exception("failed to load");
    }
  }

  Future<List<EmployeeReport>> getReport() async {
    final response = await client.get(Uri.parse(profileReportUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authorization
    });
    debugPrint(response.body);
    print("token=$authorization");



    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return employeeReportFromJson(response.body);
    } else {
      throw Exception("failed to load");
    }
  }

  Future<List<ProfileValue>> getProfileValue() async {
    final response = await client.get(Uri.parse(profileValueUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authorization
    });
    debugPrint(response.body);
    print("token=$authorization");

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return profileValueFromJson(response.body);
    } else {
      throw Exception("failed to load");
    }
  }

  static Future<void> getRefreshToken() async {
    debugPrint(getReToken());
    var body = {"Refresh_token": getReToken(), "grant_type": "refresh_token"};
    final response = await client.post(Uri.parse(loginUrl), body: body);
    debugPrint('body:' + response.body);
    debugPrint('status:' + response.statusCode.toString());
    if (response.statusCode == 400) {
      toastMessage("	invalid user credentials");
    }
    if (response.statusCode == 200) {
      final box = GetStorage();
      var refreshBody = refreshFromJson(response.body);
      box.write(refresh_token, refreshBody.accessToken);
      toastMessage("Refresh success");
    } else {
      throw Exception('Failed to load');
    }
  }
}
