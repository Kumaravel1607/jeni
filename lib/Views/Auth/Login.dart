import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/ShopType.dart';
import 'package:jini_vendor/Views/Home/Home.dart';
import 'package:jini_vendor/Views/Auth/OtpPage.dart';
import 'package:jini_vendor/Views/Others/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  TextEditingController mobile_no = TextEditingController();
  static List<Shoptype> shop_type = [];
  var message = "";
  String shoptype = "";
  @override
  void initState() {
    super.initState();

    get_shoptype();
  }

  get_shoptype() {
    Service.get_shoptype().then((result) {
      setState(() {
        print("----------------");
        print(result);
        shop_type = result;
        _loading = false;
      });

      print(result.length);
    });
  }

  void userSignIn() async {
    setState(() {
      _loading = true;
      message = "";
    });

    var url = api_url + "login_generating_otp";
    var data = {
      "mobile_no": mobile_no.text,
      "shop_type": shoptype,
      "auth": "noauth",
    };
    print(url);
    print(data);

    var res = await http.post(Uri.parse(url), body: data);
    var response = jsonDecode(res.body);
    var statuscode = res.statusCode;
    print(response);
    if (statuscode == 200) {
      var status = response['status'];
      message = response['msg'];
      print(message);
      // SharedPreferences session = await SharedPreferences.getInstance();
      // session.setString('user_id', response['id']);
      status == 0
          ? _alerBox(message)
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => otp_page(
                        mobile: mobile_no.text,
                      )));
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      //     (Route<dynamic> route) => false);
    } else if (statuscode == 202) {
      print(response['msg']);
      message = response['msg'];
    } else {
      message = response['msg'];
    }
    setState(() {
      _loading = false;
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
              FlatButton(
                onPressed: () {
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
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/intro_screen_03.png"),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        /*decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0)),*/
                        child: Image.asset(appicon)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 10.0, bottom: 20),
                  child: Center(
                      child: Text(
                    "Vendor Login",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: TextFormField(
                    cursorColor: primaryColor,
                    controller: mobile_no,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'This field is requrired';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                        prefixText: "+91",
                        fillColor: Colors.white,
                        filled: true,
                        // border: OutlineInputBorder(
                        //     borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        // labelText: value,

                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        labelText: 'Mobile no.',
                        labelStyle: TextStyle(color: Colors.blueGrey[900]),
                        hintText: 'Enter valid Mobile Number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
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
                            style: TextStyle(fontSize: 15, color: primaryColor),
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
                      validator: (value) {
                        print(value);
                        if (value == "" || value == null) {
                          return 'This field is requrired';
                        }
                        return null;
                      },
                      // validator: (value) => value == null ? 'Job Type' : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      userSignIn();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => otp_page()));
                      // update_profile();
                    }

                    // userSignIn();
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  child: _loading == false
                      ? Container(
                          height: 50,
                          width: size.width * 0.65,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ]),
                        )
                      : CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If You Don't Have An Account,"),
                    TextButton(
                        style:
                            ButtonStyle(splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerpage()));
                          print("object");
                        },
                        child: Text(
                          "Click Here to Register",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
