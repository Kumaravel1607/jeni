// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Country({
    required this.countryId,
    required this.countryCode,
    required this.name,
    required this.phonecode,
    required this.status,
    required this.addBy,
  });

  String countryId;
  String countryCode;
  String name;
  String phonecode;
  String status;
  String addBy;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["country_id"],
        countryCode: json["country_code"],
        name: json["name"],
        phonecode: json["phonecode"],
        status: json["status"],
        addBy: json["add_by"],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "country_code": countryCode,
        "name": name,
        "phonecode": phonecode,
        "status": status,
        "add_by": addBy,
      };
}
