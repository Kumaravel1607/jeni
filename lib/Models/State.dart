// To parse this JSON data, do
//
//     final States = StatesFromJson(jsonString);

import 'dart:convert';

List<States> StatesFromJson(String str) =>
    List<States>.from(json.decode(str).map((x) => States.fromJson(x)));

String StatesToJson(List<States> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class States {
  States({
    required this.id,
    required this.name,
    required this.countryId,
    required this.countryCode,
    required this.status,
    required this.addBy,
  });

  String id;
  String name;
  String countryId;
  String countryCode;
  String status;
  String addBy;

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
        status: json["status"],
        addBy: json["add_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country_code": countryCode,
        "status": status,
        "add_by": addBy,
      };
}
