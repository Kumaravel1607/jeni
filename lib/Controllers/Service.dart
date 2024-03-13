import 'dart:io';

import 'package:async/async.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Models/BankDetails.dart';
import 'package:jini_vendor/Models/Brand.dart';
import 'package:jini_vendor/Models/Category.dart';
import 'package:jini_vendor/Models/City.dart';
import 'package:jini_vendor/Models/Country.dart';
import 'package:jini_vendor/Models/Orders.dart';
import 'package:jini_vendor/Models/ProductDetails.dart';
import 'package:jini_vendor/Models/ProductPrice.dart';
import 'package:jini_vendor/Models/Products.dart';
import 'package:jini_vendor/Models/State.dart';
import 'package:jini_vendor/Models/ShopType.dart';
import 'package:jini_vendor/Models/SubCategory.dart';
import 'package:jini_vendor/Models/Variants.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  static dash_board() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {};

    var response = await http.post(Uri.parse(api_url + "get_dashboard_details"),
        body: data,
        headers: {
          'Authorization': 'Bearer $token',
        });
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static UpdateStatus(
    item,
    id,
    status,
  ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "item": item,
      "id": id,
      "status": status,
    };
    print(data);

    var response = await http
        .post(Uri.parse(api_url + "update_item_status"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static Future<List<Shoptype>> get_shoptype() async {
    List<Shoptype> list = [];
    print(api_url2 + "get_service_categories");
    final response =
        await http.get(Uri.parse(api_url2 + "get_service_categories"));

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = ShoptypeResponse(jsonEncode(responseBody['categories']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Shoptype> ShoptypeResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Shoptype>((json) => Shoptype.fromJson(json)).toList();
  }

  static get_shop_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");

    var response =
        await http.post(Uri.parse(api_url + "get_shop_profile"), headers: {
      'Authorization': 'Bearer $token',
    });
    //  print(jsonDecode(response.body));
    var userDetail = (json.decode(response.body));
    if (response.statusCode == 200) {
      return userDetail;
    } else {
      return null;
    }
  }

  static UpdateProfilepic(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "update_shop_profile_picture";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('profile_photo', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static update_shopprofile(fname, lname, shopname, gst) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "first_name": fname,
      "last_name": lname,
      "shop_name": shopname,
      "shop_gst": gst,
    };
    print(data);

    var response = await http
        .post(Uri.parse(api_url + "update_shop_profile"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    //  print(jsonDecode(response.body));
    var userDetail = (json.decode(response.body));
    if (response.statusCode == 200) {
      return userDetail;
    } else {
      return null;
    }
  }

  static update_shopaddress(
      state, city, address, pincode, latitude, longitude) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "state": state,
      "city": city,
      "address": address,
      "postal_code": pincode,
      "latitude": latitude,
      "longitude": longitude,
    };
    print(data);

    var response = await http
        .post(Uri.parse(api_url + "update_shop_address"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    //  print(jsonDecode(response.body));
    var userDetail = (json.decode(response.body));
    if (response.statusCode == 200) {
      return userDetail;
    } else {
      return null;
    }
  }

  static Future<List<Orders>> getOrders() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<Orders> list = [];
    Map data = {};
    final response = await http
        .post(Uri.parse(api_url + "home/info/logged"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = orderResponse(jsonEncode(responseBody['orders']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Orders> orderResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Orders>((json) => Orders.fromJson(json)).toList();
  }

  static Future<List<BankDetails>> GetBankDetails() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<BankDetails> list = [];
    Map data = {};
    final response = await http
        .post(Uri.parse(api_url + "get_bank_details"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = bankResponse(jsonEncode(responseBody['results']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<BankDetails> bankResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BankDetails>((json) => BankDetails.fromJson(json))
        .toList();
  }

  static UpdateBank(
    accno,
    accname,
    bank,
    ifsc,
    branch,
  ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "acc_no": accno,
      "acc_name": accname,
      "bank_name": bank,
      "ifsc_code": ifsc,
      "branch": branch,
    };

    var response = await http
        .post(Uri.parse(api_url + "update_bank_details"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static EditBank(accno, accname, bank, ifsc, branch, id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "acc_no": accno,
      "acc_name": accname,
      "bank_name": bank,
      "ifsc_code": ifsc,
      "branch": branch,
      "id": id
    };

    var response = await http
        .post(Uri.parse(api_url + "update_bank_details"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static DeleteBank(
    id,
  ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "delete_bank_details"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static primaryBank(
    id,
  ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "id": id,
    };

    var response = await http.post(
        Uri.parse(api_url + "change_primary_account"),
        body: data,
        headers: {
          'Authorization': 'Bearer $token',
        });
    print(response.statusCode);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static GetKYC() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");

    var response = await http.post(Uri.parse(api_url + "get_kyc"), headers: {
      'Authorization': 'Bearer $token',
    });
    //  print(jsonDecode(response.body));
    var userDetail = (json.decode(response.body));
    if (response.statusCode == 200) {
      return userDetail;
    } else {
      return null;
    }
  }

  static UpdateKYC(File imageFile, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();

    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "upload_kyc_document";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('document_data', stream, length,
        filename: (imageFile.path));

    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['document_id'] = id;

    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      print(jsonDecode(value2));
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static Future<List<Products>> GetInventory() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<Products> list = [];
    Map data = {};
    final response = await http
        .post(Uri.parse(api_url + "get_master_item"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = productsResponse(jsonEncode(responseBody['result']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Products> productsResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Products>((json) => Products.fromJson(json)).toList();
  }

  static UpdateInventory(
    categoryId,
    subCategoryID,
    BrandId,
    name,
    File imageFile,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_items";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('item_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['product_name'] = name.toString();
    request.fields['category_id'] = categoryId.toString();
    request.fields['sub_category_id'] = subCategoryID.toString();
    request.fields['brand_id'] = BrandId.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static EditInventory(
    categoryId,
    subCategoryID,
    BrandId,
    name,
    File imageFile,
    itemId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_items";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('item_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['product_name'] = name.toString();
    request.fields['category_id'] = categoryId.toString();
    request.fields['sub_category_id'] = subCategoryID.toString();
    request.fields['brand_id'] = BrandId.toString();
    request.fields['edit_item_id'] = itemId.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      print(jsonDecode(value2));
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static DeleteProduct(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "item_id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "delete_item"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static UpdatePrice(variantid, price, quantity, status, name, itemId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "variant_id": variantid,
      "item_price": price,
      "quantity": quantity,
      "price_status": status,
      "product_name": name,
      "item_id": itemId,
    };
    print(data);

    var response = await http
        .post(Uri.parse(api_url + "save_price_details"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static DeleteProductPrice(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "price_id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "delete_price"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static Future<List<ProductPrice>> GetProductPrice(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<ProductPrice> list = [];
    Map data = {"item_id": id};
    final response = await http
        .post(Uri.parse(api_url + "get_item_prices"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = productspriceResponse(jsonEncode(responseBody['result']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<ProductPrice> productspriceResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProductPrice>((json) => ProductPrice.fromJson(json))
        .toList();
  }

  static Future<List<Category>> get_category() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<Category> list = [];
    Map data = {};
    final response = await http
        .post(Uri.parse(api_url + "get_master_category"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = categoryResponse(jsonEncode(responseBody['result']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Category> categoryResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }

  static update_category(category_name, File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_categories";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('category_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['category_name'] = category_name.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static Edit_Category(category_name, File imageFile, category_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_categories";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('category_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['category_name'] = category_name.toString();
    request.fields['edit_category_id'] = category_id.toString();
    // request.fields['category_id'] = category_id.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      print(jsonDecode(value2));
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static Delete_Category(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "category_id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "delete_category"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static Future<List<Subcategory>> get_subcategory(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<Subcategory> list = [];
    Map data = {
      "category_id": id,
    };
    print(data);
    final response = await http
        .post(Uri.parse(api_url + "get_sub_categories"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = subcategoryResponse(jsonEncode(responseBody['result']["active"]));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Subcategory> subcategoryResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Subcategory>((json) => Subcategory.fromJson(json))
        .toList();
  }

  static update_subcategory(
    category_id,
    subcategory_name,
    File imageFile,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_sub_categories";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile(
        'sub_category_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['sub_category_name'] = subcategory_name.toString();
    request.fields['category_id'] = category_id.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static edit_subcategory(subcategory_name, File imageFile, subcategory_id,
      categoryId, subcategory_id2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_sub_categories";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile(
        'sub_category_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['sub_category_name'] = subcategory_name.toString();
    request.fields['sub_category_id'] = subcategory_id.toString();
    request.fields['edit_sub_category_id'] = subcategory_id2.toString();
    request.fields['category_id'] = categoryId.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static Delete_SubCategory(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "sub_category_id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "delete_sub_category"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static Future<List<Brand>> GetBrand() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<Brand> list = [];
    Map data = {};
    final response = await http
        .post(Uri.parse(api_url + "get_master_brand"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = brandResponse(jsonEncode(responseBody['result']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Brand> brandResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Brand>((json) => Brand.fromJson(json)).toList();
  }

  static UpdateBrand(
    name,
    File imageFile,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_brands";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('brand_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['brand_name'] = name.toString();
    // request.fields['category_id'] = category_id.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static BrandEdit(name, File imageFile, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    var length = await imageFile.length();
    print("kyccccccc");
    print(imageFile.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var url = api_url + "save_brands";

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    var multipartFile = new http.MultipartFile('brand_image', stream, length,
        filename: (imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['brand_name'] = name.toString();
    request.fields['edit_brand_id'] = id.toString();
    var response = await request.send();
    print(response.statusCode);

    var res = response.stream.transform(utf8.decoder).listen((value2) {
      return jsonDecode(value2);
    });

    print("ddddddddddd");
    print(res);
    return res;
  }

  static DeleteBrand(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "brand_id": id,
    };
    print(data);
    var response = await http
        .post(Uri.parse(api_url + "delete_brand"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static Future<List<Variants>> GetVariants() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    List<Variants> list = [];
    Map data = {};
    final response = await http
        .post(Uri.parse(api_url + "get_master_variant"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = variantResponse(jsonEncode(responseBody['result']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Variants> variantResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Variants>((json) => Variants.fromJson(json)).toList();
  }

  static UpdateVariants(
    name1,
    name2,
  ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "variant_name": name1,
      "variant_short_name": name2,
      // "edit_variant_id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "save_variants"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static EditVariants(name1, name2, id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "variant_name": name1,
      "variant_short_name": name2,
      "edit_variant_id": id,
    };

    var response = await http
        .post(Uri.parse(api_url + "save_variants"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static DeleteVariants(id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    Map data = {
      "variant_id": id,
    };
    print(data);
    var response = await http
        .post(Uri.parse(api_url + "delete_variant"), body: data, headers: {
      'Authorization': 'Bearer $token',
    });

    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return userDetail;
    }
  }

  static Future<List<Country>> get_country() async {
    List<Country> list = [];

    final response = await http.get(Uri.parse(api_url2 + "get_countries"));

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = countryResponse(jsonEncode(responseBody['results']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<Country> countryResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => Country.fromJson(json)).toList();
  }

  static Future<List<States>> get_state() async {
    List<States> list = [];

    final response =
        await http.get(Uri.parse(api_url2 + "get_states?country_id=" + "101"));

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = stateResponse(jsonEncode(responseBody['results']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<States> stateResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<States>((json) => States.fromJson(json)).toList();
  }

  static Future<List<City>> get_city() async {
    List<City> list = [];

    final response =
        await http.get(Uri.parse(api_url2 + "get_cities?state_id=" + "35"));

    final responseBody = json.decode(response.body);
    print(responseBody);
    if (response.statusCode == 200) {
      list = cityResponse(jsonEncode(responseBody['results']));
      print(list);
      return list;
    } else {
      print(response.statusCode);
      throw Exception("Problem in fetching address List");
    }
  }

  static List<City> cityResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<City>((json) => City.fromJson(json)).toList();
  }

/////////////////////////////////////////////////////////////////////////////////

}
