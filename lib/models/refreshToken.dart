

import 'dart:convert';

Refresh refreshFromJson(String str) => Refresh.fromJson(json.decode(str));

String refreshToJson(Refresh data) => json.encode(data.toJson());

class Refresh {
  Refresh({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.issued,
    this.expires,
  });

  String? accessToken;
  String? tokenType;
  int? expiresIn;
  int? issued;
  int? expires;

  factory Refresh.fromJson(Map<String, dynamic> json) => Refresh(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    issued: json[".issued"],
    expires: json[".expires"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    ".issued": issued,
    ".expires": expires,
  };
}
