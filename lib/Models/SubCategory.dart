// To parse this JSON data, do
//
//     final subcategory = subcategoryFromJson(jsonString);

import 'dart:convert';

Subcategory subcategoryFromJson(String str) =>
    Subcategory.fromJson(json.decode(str));

String subcategoryToJson(Subcategory data) => json.encode(data.toJson());

class Subcategory {
  Subcategory({
    required this.subCategoryId,
    required this.categoryId,
    required this.subCategoryName,
    required this.subCategoryTagName,
    required this.subCategoryImage,
    required this.status,
    required this.addBy,
    required this.parentCategoryId,
    required this.categoryName,
    required this.categoryTagName,
    required this.categoryImage,
  });

  String subCategoryId;
  String categoryId;
  String subCategoryName;
  String subCategoryTagName;
  String subCategoryImage;
  String status;
  String addBy;
  dynamic parentCategoryId;
  String categoryName;
  String categoryTagName;
  String categoryImage;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        subCategoryId: json["sub_category_id"],
        categoryId: json["category_id"],
        subCategoryName: json["sub_category_name"],
        subCategoryTagName: json["sub_category_tag_name"],
        subCategoryImage: json["sub_category_image"],
        status: json["status"],
        addBy: json["add_by"],
        parentCategoryId: json["parent_category_id"],
        categoryName: json["category_name"],
        categoryTagName: json["category_tag_name"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toJson() => {
        "sub_category_id": subCategoryId,
        "category_id": categoryId,
        "sub_category_name": subCategoryName,
        "sub_category_tag_name": subCategoryTagName,
        "sub_category_image": subCategoryImage,
        "status": status,
        "add_by": addBy,
        "parent_category_id": parentCategoryId,
        "category_name": categoryName,
        "category_tag_name": categoryTagName,
        "category_image": categoryImage,
      };
}
