// To parse this JSON data, do
//
//     final productPrice = productPriceFromJson(jsonString);

import 'dart:convert';

List<ProductPrice> productPriceFromJson(String str) => List<ProductPrice>.from(
    json.decode(str).map((x) => ProductPrice.fromJson(x)));

String productPriceToJson(List<ProductPrice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductPrice {
  ProductPrice({
    required this.productId,
    required this.categoryId,
    required this.subCategoryId,
    required this.brandId,
    required this.productName,
    required this.tagName,
    required this.productImage,
    required this.productImages,
    required this.status,
    required this.createdDate,
    required this.updatedDate,
    required this.ownerId,
    required this.addBy,
    required this.shopId,
    required this.shopName,
    required this.productStatus,
    required this.priceId,
    required this.variantId,
    required this.sellingPrice,
    required this.quantity,
    required this.variantName,
    required this.variantShortName,
  });

  String productId;
  String categoryId;
  String subCategoryId;
  String brandId;
  String productName;
  String tagName;
  String productImage;
  dynamic productImages;
  String status;
  DateTime createdDate;
  DateTime updatedDate;
  String ownerId;
  String addBy;
  dynamic shopId;
  dynamic shopName;
  String productStatus;
  String priceId;
  String variantId;
  String sellingPrice;
  String quantity;
  String variantName;
  String variantShortName;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
        productId: json["product_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        tagName: json["tag_name"],
        productImage: json["product_image"],
        productImages: json["product_images"],
        status: json["status"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedDate: DateTime.parse(json["updated_date"]),
        ownerId: json["owner_id"],
        addBy: json["add_by"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        productStatus: json["product_status"],
        priceId: json["price_id"],
        variantId: json["variant_id"],
        sellingPrice: json["selling_price"],
        quantity: json["quantity"],
        variantName: json["variant_name"],
        variantShortName: json["variant_short_name"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "brand_id": brandId,
        "product_name": productName,
        "tag_name": tagName,
        "product_image": productImage,
        "product_images": productImages,
        "status": status,
        "created_date": createdDate.toIso8601String(),
        "updated_date": updatedDate.toIso8601String(),
        "owner_id": ownerId,
        "add_by": addBy,
        "shop_id": shopId,
        "shop_name": shopName,
        "product_status": productStatus,
        "price_id": priceId,
        "variant_id": variantId,
        "selling_price": sellingPrice,
        "quantity": quantity,
        "variant_name": variantName,
        "variant_short_name": variantShortName,
      };
}
