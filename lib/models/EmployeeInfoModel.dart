// To parse this JSON data, do
//
//     final employeeInfo = employeeInfoFromJson(jsonString);

import 'dart:convert';

List<EmployeeInfo> employeeInfoFromJson(String str) => List<EmployeeInfo>.from(json.decode(str).map((x) => EmployeeInfo.fromJson(x)));

String employeeInfoToJson(List<EmployeeInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeInfo {
  EmployeeInfo({
    required this.fullName,
    required this.email,
    required this.idNumber,
    required this.phoneNumber,
  });

  String fullName;
  String email;
  String idNumber;
  String phoneNumber;

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) => EmployeeInfo(
    fullName: json["FullName"]??"",
    email: json["Email"]??"",
    idNumber: json["IDNumber"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "FullName": fullName,
    "Email": email,
    "IDNumber": idNumber,
    "PhoneNumber": phoneNumber,
  };
}
