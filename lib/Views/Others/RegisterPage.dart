import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/ShopType.dart';
import 'package:jini_vendor/Views/Auth/Login.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  _registerpageState createState() => _registerpageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _registerpageState extends State<registerpage> {
  bool _isLoading = true;
  bool signin = true;
  bool processing = false;

  static List<Shoptype> shop_type = [];
  // static List countrylist = [];

  String countryValue = "";

  final first_name = TextEditingController();
  // final last_name = TextEditingController();
  final mobile = TextEditingController();
  final gst = TextEditingController();
  final mail_id = TextEditingController();

  final shopname = TextEditingController();
  // final pass1 = TextEditingController();
  // final pass2 = TextEditingController();
  String shoptype = "";

  late String select;

  @override
  void initState() {
    // TODO: implement initState
    // first_name.text = firstname;
    // last_name.text = "G";
    get_shoptype();
  }

  get_shoptype() {
    Service.get_shoptype().then((result) {
      setState(() {
        print("----------------");
        print(result);
        shop_type = result;
        _isLoading = false;
      });

      print(result.length);
    });
  }

  // _get_state_list(country, chnage_1) {
  //   print("number" + country);
  //   Service.get_state_list(country).then((state_data) {
  //     setState(() {
  //       statelist = state_data;
  //       // print("dd");
  //       print(chnage_1);
  //       if (chnage_1 != "" || chnage_1 != null) {
  //         _state = chnage_1;
  //       }
  //     });
  //     print(statelist.length);
  //   });
  // }

  void register() async {
    Map data = {
      'first_name': first_name.text,
      'email': mail_id.text,
      'mobile_number': mobile.text,
      'shop_type': shoptype,
      'shop_name': shopname.text,
      'shop_gst': gst.text,
      'auth': "noauth",
    };

    print(data);
    var res = await http.post(Uri.parse(api_url + "register"), body: data);
    var results = jsonDecode(res.body);
    print(results);
    if (res.statusCode == 200) {
      setState(() {
        processing = false;
        _isLoading = false;
      });
      signin = true;
      var message = results['msg'];
      _alerBox(message, 1);
    } else if (res.statusCode == 202) {
      setState(() {
        processing = false;
        _isLoading = false;
      });
      var message = results['msg'];
      _alerBox(message, 2);
      signin = false;
    } else {
      setState(() {
        processing = false;
      });
      signin = false;
    }
  }

  Future<void> _alerBox(message, redirect) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  if (redirect == 1) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  } else
                    Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("Register"),
            centerTitle: true),
        body: _isLoading == true
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        textform("First Name", first_name, 1, 0),
                        textform1("Contact Number", mobile, 1, 0),
                        textform("Mail id", mail_id, 1, 0),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: DropdownButtonFormField<String>(
                            decoration: textDecoration("Shop Type"),

                            // hint: Text("job type"),

                            style: TextStyle(fontSize: 14),
                            items: shop_type.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.serviceCategoryId.toString(),
                                child: new Text(
                                  item.serviceCategoryName,
                                  style: TextStyle(
                                      fontSize: 15, color: primaryColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                print("--------------------");
                                print(newValue);
                                // _get_state_list(newValue, "");
                                shoptype = newValue!;
                              });
                            },
                            // validator: (value) => value == null ? 'Job Type' : null,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textform("Shop Name", shopname, 1, 0),
                        textform("Shop GST", gst, 1, 0),
                        button(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Padding button() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            // print("clicked");

            if (_formKey.currentState!.validate()) {
              setState(() {
                _isLoading = true;
              });
              register();
            }
          },
          child: Container(
            child: Center(
              child: Text("Submit",
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

  Padding textform(
      value, TextEditingController my_controller_name, required, en) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        enabled: en == 0 ? true : false,
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
          labelText: value,
          labelStyle: TextStyle(color: Colors.blueGrey[700]),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey)),
        ),
      ),
    );
  }

  Padding textform1(
      value, TextEditingController my_controller_name, required, en) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        enabled: en == 0 ? true : false,
        controller: my_controller_name,
        keyboardType: TextInputType.number,
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
          labelText: value,
          labelStyle: TextStyle(color: Colors.blueGrey[700]),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey)),
        ),
      ),
    );
  }
}
