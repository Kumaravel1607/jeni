// To parse this JSON data, do
//
//     final bankDetails = bankDetailsFromJson(jsonString);

import 'dart:convert';

List<BankDetails> bankDetailsFromJson(String str) => List<BankDetails>.from(
    json.decode(str).map((x) => BankDetails.fromJson(x)));

String bankDetailsToJson(List<BankDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankDetails {
  BankDetails({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
    required this.branch,
    required this.primaryAcc,
    required this.razorpayAccountType,
    required this.razorpayAccountId,
    required this.razorpayContactId,
    required this.razorpayAccountStatus,
  });

  String id;
  String userId;
  String accountNumber;
  String accountName;
  String bankName;
  String bankCode;
  String branch;
  String primaryAcc;
  String razorpayAccountType;
  String razorpayAccountId;
  String razorpayContactId;
  String razorpayAccountStatus;

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        id: json["id"],
        userId: json["user_id"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        branch: json["branch"],
        primaryAcc: json["primary_acc"],
        razorpayAccountType: json["razorpay_account_type"],
        razorpayAccountId: json["razorpay_account_id"],
        razorpayContactId: json["razorpay_contact_id"],
        razorpayAccountStatus: json["razorpay_account_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_name": bankName,
        "bank_code": bankCode,
        "branch": branch,
        "primary_acc": primaryAcc,
        "razorpay_account_type": razorpayAccountType,
        "razorpay_account_id": razorpayAccountId,
        "razorpay_contact_id": razorpayContactId,
        "razorpay_account_status": razorpayAccountStatus,
      };
}
