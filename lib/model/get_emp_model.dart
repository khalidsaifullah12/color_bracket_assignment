// To parse this JSON data, do
//
//     final getemployees = getemployeesFromJson(jsonString);

import 'dart:convert';

Getemployees getemployeesFromJson(String str) => Getemployees.fromJson(json.decode(str));

String getemployeesToJson(Getemployees data) => json.encode(data.toJson());

class Getemployees {
  Getemployees({
    required this.id,
    required this.name,
    required this.company,
    required this.designation,
    required this.companyLogo,
  });

  int id;
  String name;
  String company;
  String designation;
  String companyLogo;

  factory Getemployees.fromJson(Map<String, dynamic> json) => Getemployees(
    id: json["id"],
    name: json["name"],
    company: json["company"],
    designation: json["designation"],
    companyLogo: json["company_logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company": company,
    "designation": designation,
    "company_logo": companyLogo,
  };
}
