// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    required this.basics,
    required this.postinfo,
    required this.products,
    required this.shopData,
    required this.payment,
    required this.deliveryInfo,
  });

  Basics basics;
  Postinfo postinfo;
  List<Product> products;
  String shopData;
  Payment payment;
  String deliveryInfo;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        basics: Basics.fromJson(json["basics"]),
        postinfo: Postinfo.fromJson(json["post_info"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        shopData: json["shop_data"],
        payment: Payment.fromJson(json["payment"]),
        deliveryInfo: json["delivery_info"],
      );

  Map<String, dynamic> toJson() => {
        "basics": basics.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "shop_data": shopData,
        "payment": payment.toJson(),
        "delivery_info": deliveryInfo,
      };
}

class Basics {
  Basics({
    required this.postNo,
    required this.postName,
    required this.postDescription,
    required this.totalItems,
    required this.totalAmount,
    required this.postStatus,
    required this.paymentStatus,
    required this.orderStatus,
    required this.postedOn,
  });

  String postNo;
  String postName;
  String postDescription;
  int totalItems;
  String totalAmount;
  String postStatus;
  String paymentStatus;
  String orderStatus;
  String postedOn;

  factory Basics.fromJson(Map<String, dynamic> json) => Basics(
        postNo: json["post_no"] == null ? null : json["post_no"],
        postName: json["post_name"],
        postDescription: json["post_description"],
        totalItems: json["total_items"],
        totalAmount: json["total_amount"],
        postStatus: json["post_status"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        postedOn: json["posted_on"],
      );

  Map<String, dynamic> toJson() => {
        "post_no": postNo == null ? null : postNo,
        "post_name": postName,
        "post_description": postDescription,
        "total_items": totalItems,
        "total_amount": totalAmount,
        "post_status": postStatus,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "order_status": orderStatus == null ? null : orderStatus,
        "posted_on": postedOn,
      };
}

class Postinfo {
  Postinfo({
    required this.userId,
    required this.userTypeId,
    required this.userSubTypeId,
    required this.firstName,
    required this.lastName,
    required this.shopName,
    required this.shopGst,
    required this.email,
    required this.mobileNo,
    required this.profilePic,
    required this.status,
    required this.accountStatus,
    required this.commision,
    required this.createdDate,
    required this.addBy,
    required this.subscription,
    required this.deviceId,
    required this.addressDetailsId,
    required this.address,
    required this.cityId,
    required this.zipCode,
    required this.stateId,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
  });

  String userId;
  String userTypeId;
  String userSubTypeId;
  String firstName;
  String lastName;
  String shopName;
  String shopGst;
  String email;
  String mobileNo;
  String profilePic;
  String status;
  String accountStatus;
  String commision;
  String createdDate;
  String addBy;
  String subscription;
  String deviceId;
  String addressDetailsId;
  String address;
  String cityId;
  String zipCode;
  String stateId;
  String countryCode;
  String latitude;
  String longitude;

  factory Postinfo.fromJson(Map<String, dynamic> json) => Postinfo(
        userId: json["user_id"],
        userTypeId: json["user_type_id"],
        userSubTypeId: json["user_sub_type_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        shopName: json["shop_name"],
        shopGst: json["shop_gst"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        profilePic: json["profile_pic"],
        status: json["status"],
        accountStatus: json["account_status"],
        commision: json["commision"],
        createdDate: json["created_date"],
        addBy: json["add_by"],
        subscription: json["subscription"],
        deviceId: json["device_id"],
        addressDetailsId: json["address_details_id"],
        address: json["address"],
        cityId: json["city_id"],
        zipCode: json["zip_code"],
        stateId: json["state_id"],
        countryCode: json["country_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type_id": userTypeId,
        "user_sub_type_id": userSubTypeId,
        "first_name": firstName,
        "last_name": lastName,
        "shop_name": shopName,
        "shop_gst": shopGst,
        "email": email,
        "mobile_no": mobileNo,
        "profile_pic": profilePic,
        "status": status,
        "account_status": accountStatus,
        "commision": commision,
        "created_date": createdDate,
        "add_by": addBy,
        "subscription": subscription,
        "device_id": deviceId,
        "address_details_id": addressDetailsId,
        "address": address,
        "city_id": cityId,
        "zip_code": zipCode,
        "state_id": stateId,
        "country_code": countryCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Payment {
  Payment({
    required this.totalAmount,
    required this.paymentStatus,
  });

  String totalAmount;
  String paymentStatus;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        totalAmount: json["total_amount"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "payment_status": paymentStatus == null ? null : paymentStatus,
      };
}

class Product {
  Product({
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
    required this.createdString,
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
  String createdString;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        createdString: json["created_date_time"],
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
        "created_date_time": createdString,
      };
}
