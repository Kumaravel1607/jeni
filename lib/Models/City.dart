// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.id,
    required this.city,
    required this.stateId,
    required this.status,
    required this.addBy,
  });

  String id;
  String city;
  String stateId;
  String status;
  String addBy;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        city: json["city"],
        stateId: json["state_id"],
        status: json["status"],
        addBy: json["add_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "state_id": stateId,
        "status": status,
        "add_by": addBy,
      };
}
