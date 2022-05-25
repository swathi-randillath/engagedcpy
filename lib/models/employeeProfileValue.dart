

import 'dart:convert';

List<ProfileValue> profileValueFromJson(String str) => List<ProfileValue>.from(json.decode(str).map((x) => ProfileValue.fromJson(x)));

String profileValueToJson(List<ProfileValue> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileValue {
  ProfileValue({
    required this.description,
    required this.value,
  });

  String description;
  int value;

  factory ProfileValue.fromJson(Map<String, dynamic> json) => ProfileValue(
    description: json["Description"]??"",
    value: json["Value"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Description": description,
    "Value": value,
  };
}
