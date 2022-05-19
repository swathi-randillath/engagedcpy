
import 'dart:convert';

List<PageAccessModel> pageAccessModelFromJson(String str) => List<PageAccessModel>.from(json.decode(str).map((x) => PageAccessModel.fromJson(x)));

String pageAccessModelToJson(List<PageAccessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PageAccessModel {
  PageAccessModel({
    required this.employeeId,
    required this.elementId,
    required this.description,
    required this.subDescription,
    required this.iconDescription,
    required this.isActive,
  });

  int employeeId;
  int elementId;
  String description;
  String subDescription;
  String iconDescription;
  bool isActive;

  factory PageAccessModel.fromJson(Map<String, dynamic> json) => PageAccessModel(
    employeeId: json["EmployeeID"],
    elementId: json["ElementID"],
    description: json["Description"],
    subDescription: json["SubDescription"],
    iconDescription: json["IconDescription"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "EmployeeID": employeeId,
    "ElementID": elementId,
    "Description": description,
    "SubDescription": subDescription,
    "IconDescription": iconDescription,
    "IsActive": isActive,
  };
}
