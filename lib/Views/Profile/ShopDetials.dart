import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class shopdetails extends StatefulWidget {
  const shopdetails({Key? key}) : super(key: key);

  @override
  _shopdetailsState createState() => _shopdetailsState();
}

class _shopdetailsState extends State<shopdetails> {
  bool _loading = true;
  bool img = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();
  var shopname = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mail = TextEditingController();
  var gst = TextEditingController();
  var mobile_no = TextEditingController();
  File image_path = File("");
  String image = "";

  var token = "";
  var mobile = "";

  @override
  void initState() {
    super.initState();
    get_shop();
    // getDropdownValues();

    // option_list();

    get_id();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      title("SHOP NAME"),
                      Container(height: 90, child: textform(shopname, 1, 0)),
                      title("CONTACT PERSON FIRST NAME *"),
                      Container(height: 90, child: textform(firstname, 1, 0)),
                      title("CONTACT PERSON LAST NAME *"),
                      Container(height: 90, child: textform(lastname, 1, 0)),
                      title("SCONTACT PERSON EMAIL *"),
                      Container(height: 90, child: textform(mail, 1, 1)),
                      title("GST NO. *"),
                      Container(height: 90, child: textform(gst, 1, 0)),
                      title("CONTACT PERSON MOBILE NUMBER *"),
                      Container(height: 90, child: textform(mobile_no, 1, 1)),
                      title("EXISTING SHOP IMAGE OR LOGO IMAGE"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            image: img == true
                                ? DecorationImage(image: FileImage(image_path))
                                : DecorationImage(image: NetworkImage(image)),
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      title("SHOP IMAGE OR LOGO"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 30,
                          child: RaisedButton(
                            onPressed: () {
                              getimagefromgallery();
                            },
                            child: Text('Choose'),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      btn(),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Padding btn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // update_profile();
              update_shop();
              UpdateImage();
              print("object");
              setState(() {
                _loading = true;
              });
            }
          },
          child: Container(
            child: Center(
              child: Text("Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            height: 50,
            width: 200,
          )),
    );
  }

  Padding title(value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding textform(my_controller_name, required, read) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: TextFormField(
          enabled: read == 1 ? false : true,
          controller: my_controller_name,
          validator: (value) {
            if (required == 1) {
              if (value == "") {
                return 'This field is requrired';
              }
              return null;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
            // labelText: value,
            labelStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
          ),
        ),
      ),
    );
  }

  get_id() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = _pref.getString("token").toString();

    mobile = _pref.getString("mobile").toString();

    print(token);

    print(mobile);
  }

  void update_shop() {
    Service.update_shopprofile(
            firstname.text, lastname.text, shopname.text, gst.text)
        .then((result) {
      _alerBox(result["msg"]);
      setState(() {
        _loading = false;
      });
      print(result);
    });
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  void get_shop() {
    Service.get_shop_profile().then((result) {
      print(result);
      setState(() {
        _loading = false;
        shopname.text = result["result"]["shop_name"];
        firstname.text = result["result"]["first_name"];
        lastname.text = result["result"]["last_name"];
        mail.text = result["result"]["email"];
        gst.text = result["result"]["shop_gst"];
        mobile_no.text = result["result"]["admin_cell_phone"];
        image = result["result"]["admin_profile_pic"];
      });
    });
  }

  void UpdateImage() {
    Service.UpdateProfilepic(image_path).then((result) {
      get_shop();
      setState(() {
        _loading = false;
      });
      print(result);
    });
  }

  Future getimagefromgallery() async {
    final ImagePicker _picker = ImagePicker();
    var pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedimage != null) {
        image_path = File(pickedimage.path);
        setState(() {
          img = true;
        });
      } else {
        print('no image');
      }
    });
  }
}
