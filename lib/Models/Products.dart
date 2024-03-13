// To parse this JSON data, do
//
//     final Products = ProductsFromJson(jsonString);

import 'dart:convert';

List<Products> ProductsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String ProductsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    required this.ProductsId,
    required this.ProductsName,
    required this.ProductsImage,
    required this.category,
    required this.subcategory,
    required this.subcategoryId,
    required this.brand,
    required this.status,
    required this.categoryID,
    required this.brandID,
  });

  String ProductsId;
  String category;
  String ProductsName;
  String subcategory;
  String subcategoryId;
  String ProductsImage;
  String status;
  String brand;
  String categoryID;
  String brandID;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        ProductsId: json["product_id"],
        category: json["category_name"],
        ProductsName: json["product_name"],
        brand: json["brand_name"],
        ProductsImage:
            json["product_image"] == null ? null : json["product_image"],
        status: json["product_status"],
        subcategory: json["sub_category_name"],
        subcategoryId: json["sub_category_id"],
        categoryID: json["category_id"],
        brandID: json["brand_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": ProductsId,
        "category_name": category,
        "product_name": ProductsName,
        "brand_name": brand,
        "product_image": ProductsImage == null ? null : ProductsImage,
        "product_status": status,
        "sub_category_name": subcategory,
        "sub_category_id": subcategoryId,
        "brand_id": brandID,
        "category_id": categoryID,
      };
}
