import 'package:get_storage/get_storage.dart';

const ACCESS_TOKEN = "token";
const USER_LOGGED_IN = "user_logged_in";

String getToken() {
  final storage = GetStorage();

  var token = storage.read(ACCESS_TOKEN);
  String authorization = 'Bearer $token';
  return authorization;
}

bool getUserLogin() {
  final storage = GetStorage();

  var loggedIn = storage.read(USER_LOGGED_IN) ?? false;
  bool isLoggedIn = loggedIn;
  return isLoggedIn;
}