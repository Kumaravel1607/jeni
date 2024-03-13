// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.categoryId,
    required this.parentCategoryId,
    required this.categoryName,
    required this.categoryTagName,
    required this.categoryImage,
    required this.status,
    required this.addBy,
  });

  String categoryId;
  String parentCategoryId;
  String categoryName;
  String categoryTagName;
  String categoryImage;
  String status;
  String addBy;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        parentCategoryId: json["parent_category_id"],
        categoryName: json["category_name"],
        categoryTagName: json["category_tag_name"],
        categoryImage:
            json["category_image"] == null ? null : json["category_image"],
        status: json["status"],
        addBy: json["add_by"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "parent_category_id": parentCategoryId,
        "category_name": categoryName,
        "category_tag_name": categoryTagName,
        "category_image": categoryImage == null ? null : categoryImage,
        "status": status,
        "add_by": addBy,
      };
}
