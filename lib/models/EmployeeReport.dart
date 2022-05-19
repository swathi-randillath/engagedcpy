

import 'dart:convert';

List<EmployeeReport> employeeReportFromJson(String str) => List<EmployeeReport>.from(json.decode(str).map((x) => EmployeeReport.fromJson(x)));

String employeeReportToJson(List<EmployeeReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeReport {
  EmployeeReport({
    this.employee,
    this.targetValue,
    this.forecastValue,
    this.actualValue,
  });

  String? employee;
  double? targetValue;
  double? forecastValue;
  double? actualValue;

  factory EmployeeReport.fromJson(Map<String, dynamic> json) => EmployeeReport(
    employee: json["Employee"],
    targetValue: json["TargetValue"],
    forecastValue: json["ForecastValue"],
    actualValue: json["ActualValue"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Employee": employee,
    "TargetValue": targetValue,
    "ForecastValue": forecastValue,
    "ActualValue": actualValue,
  };
}