

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.issued,
    required this.expires,
  });

  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  int issued;
  int expires;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    refreshToken: json["refresh_token"],
    issued: json[".issued"],
    expires: json[".expires"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "refresh_token": refreshToken,
    ".issued": issued,
    ".expires": expires,
  };
}
