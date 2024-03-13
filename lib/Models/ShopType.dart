// To parse this JSON data, do
//
//     final shoptype = shoptypeFromJson(jsonString);

import 'dart:convert';

Shoptype shoptypeFromJson(String str) => Shoptype.fromJson(json.decode(str));

String shoptypeToJson(Shoptype data) => json.encode(data.toJson());

class Shoptype {
  Shoptype({
    required this.serviceCategoryId,
    required this.serviceCategoryName,
    required this.serviceCategoryImage,
    required this.status,
    required this.image,
  });

  String serviceCategoryId;
  String serviceCategoryName;
  String serviceCategoryImage;
  String status;
  String image;

  factory Shoptype.fromJson(Map<String, dynamic> json) => Shoptype(
        serviceCategoryId: json["service_category_id"],
        serviceCategoryName: json["service_category_name"],
        serviceCategoryImage: json["service_category_image"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "service_category_id": serviceCategoryId,
        "service_category_name": serviceCategoryName,
        "service_category_image": serviceCategoryImage,
        "status": status,
        "image": image,
      };
}
