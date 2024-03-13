// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

List<Brand> brandFromJson(String str) =>
    List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));

String brandToJson(List<Brand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brand {
  Brand({
    required this.brandId,
    required this.brandName,
    required this.brandTagName,
    required this.brandImage,
    required this.status,
    required this.addBy,
  });

  String brandId;
  String brandName;
  String brandTagName;
  String brandImage;
  String status;
  String addBy;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        brandTagName:
            json["brand_tag_name"] == null ? null : json["brand_tag_name"],
        brandImage: json["brand_image"],
        status: json["status"],
        addBy: json["add_by"],
      );

  Map<String, dynamic> toJson() => {
        "brand_id": brandId,
        "brand_name": brandName,
        "brand_tag_name": brandTagName == null ? null : brandTagName,
        "brand_image": brandImage,
        "status": status,
        "add_by": addBy,
      };
}
