// To parse this JSON data, do
//
//     final variants = variantsFromJson(jsonString);

import 'dart:convert';

List<Variants> variantsFromJson(String str) =>
    List<Variants>.from(json.decode(str).map((x) => Variants.fromJson(x)));

String variantsToJson(List<Variants> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Variants {
  Variants({
    required this.variantId,
    required this.variantName,
    required this.variantShortName,
    required this.status,
    required this.addBy,
  });

  String variantId;
  String variantName;
  String variantShortName;
  String status;
  String addBy;

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        variantId: json["variant_id"],
        variantName: json["variant_name"],
        variantShortName: json["variant_short_name"],
        status: json["status"],
        addBy: json["add_by"],
      );

  Map<String, dynamic> toJson() => {
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_short_name": variantShortName,
        "status": status,
        "add_by": addBy,
      };
}
