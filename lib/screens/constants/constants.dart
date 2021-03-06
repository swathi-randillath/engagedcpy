import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

const ACCESS_TOKEN = "token";
const refresh_token="refresh_token";
const user_name="user_name";
const password="password";
const USER_LOGGED_IN = "user_logged_in";
const IMAGE_PATH="image_path";

String getToken() {
  final storage = GetStorage();

  var token = storage.read(ACCESS_TOKEN);
  String authorization = 'Bearer $token';


  return authorization;
}
String getReToken(){
  final storage = GetStorage();

  debugPrint("accessToken :${storage.read(ACCESS_TOKEN)}");
  debugPrint("refresh_token :${storage.read(refresh_token)}");

  var retoken = storage.read(refresh_token);
  print(retoken);
  //String reftoken = refresh_token;
  return retoken;
}


bool getUserLogin() {
  final storage = GetStorage();

  var loggedIn = storage.read(USER_LOGGED_IN) ?? false;
  bool isLoggedIn = loggedIn;
  return isLoggedIn;
}