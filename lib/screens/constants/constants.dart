import 'package:get_storage/get_storage.dart';

const ACCESS_TOKEN = "token";
const refresh_token="refresh_token";
const user_name="user_name";
const USER_LOGGED_IN = "user_logged_in";

String getToken() {
  final storage = GetStorage();

  var token = storage.read(ACCESS_TOKEN);
  String authorization = 'Bearer $token';
  return authorization;
}
String getReToken(){
  final storage = GetStorage();

  var retoken = storage.read(refresh_token);
  print(retoken);
  String reftoken = refresh_token;
  return reftoken;
}


bool getUserLogin() {
  final storage = GetStorage();

  var loggedIn = storage.read(USER_LOGGED_IN) ?? false;
  bool isLoggedIn = loggedIn;
  return isLoggedIn;
}