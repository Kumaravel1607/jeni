// To parse this JSON data, do
//
//     final productdetail = productdetailFromJson(jsonString);

import 'dart:convert';

List<Productdetail> productdetailFromJson(String str) =>
    List<Productdetail>.from(
        json.decode(str).map((x) => Productdetail.fromJson(x)));

String productdetailToJson(List<Productdetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productdetail {
  Productdetail({
    required this.cartId,
    required this.postId,
    required this.storeType,
    required this.userId,
    required this.shopId,
    required this.shopData,
    required this.productId,
    required this.productName,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.brandId,
    required this.brandName,
    required this.productImage,
    required this.variantId,
    required this.variantName,
    required this.priceId,
    required this.quantity,
    required this.perItemPrice,
    required this.totalItemPrice,
    required this.bookingStatus,
    required this.createdDateTime,
  });

  String cartId;
  String postId;
  String storeType;
  String userId;
  String shopId;
  String shopData;
  String productId;
  String productName;
  String categoryId;
  String categoryName;
  String subCategoryId;
  String subCategoryName;
  String brandId;
  String brandName;
  String productImage;
  String variantId;
  String variantName;
  String priceId;
  String quantity;
  String perItemPrice;
  String totalItemPrice;
  String bookingStatus;
  DateTime createdDateTime;

  factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
        cartId: json["cart_id"],
        postId: json["post_id"],
        storeType: json["store_type"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        shopData: json["shop_data"],
        productId: json["product_id"],
        productName: json["product_name"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        subCategoryId: json["sub_category_id"],
        subCategoryName: json["sub_category_name"],
        brandId: json["brand_id"],
        brandName: json["brand_name"],
        productImage: json["product_image"],
        variantId: json["variant_id"],
        variantName: json["variant_name"],
        priceId: json["price_id"],
        quantity: json["quantity"],
        perItemPrice: json["per_item_price"],
        totalItemPrice: json["total_item_price"],
        bookingStatus: json["booking_status"],
        createdDateTime: DateTime.parse(json["created_date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "post_id": postId,
        "store_type": storeType,
        "user_id": userId,
        "shop_id": shopId,
        "shop_data": shopData,
        "product_id": productId,
        "product_name": productName,
        "category_id": categoryId,
        "category_name": categoryName,
        "sub_category_id": subCategoryId,
        "sub_category_name": subCategoryName,
        "brand_id": brandId,
        "brand_name": brandName,
        "product_image": productImage,
        "variant_id": variantId,
        "variant_name": variantName,
        "price_id": priceId,
        "quantity": quantity,
        "per_item_price": perItemPrice,
        "total_item_price": totalItemPrice,
        "booking_status": bookingStatus,
        "created_date_time": createdDateTime.toIso8601String(),
      };
}
