import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Views/Home/Home.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class otp_page extends StatefulWidget {
  String mobile = "";
  otp_page({required this.mobile});

  @override
  _otp_pageState createState() => _otp_pageState();
}

final TextEditingController otp = new TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// final TextEditingController mobileNumber = new TextEditingController();

class _otp_pageState extends State<otp_page> {
  bool loading = false;
  String _code = "";
  void otp_signin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {
      "mobile_number": widget.mobile,
      'otp': otp.text,
      'auth': "noauth",
    };
    print(data);
    var res = await http.post(Uri.parse(api_url + "login_otp"), body: data);
    var results = jsonDecode(res.body);
    print(results);
    if (res.statusCode == 200) {
      setState(() {
        pref.setString("token", results['token']);
        // pref.setString("name", results['name']);
        pref.setString("email", results['email']);

        pref.setString("mobile", results['mobile']);

        loading = false;
      });
      results["msg"] == "Success.You are logged-in."
          ? Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()),
              (Route<dynamic> route) => false)
          : _alerBox(results["msg"]);
    } else {
      return _alerBox(results["msg"]);
    }
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                "assets/images/icons/logo_png.png",
                height: 200,
                width: 300,
              ),
              // Text("SMART SERVICES", style: TextStyle(fontSize: 16, color: white,fontWeight: FontWeight.w600),),
              // SizedBox(
              //   height: 55,
              // ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Verification Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please Enter The Verification Code send to ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: white, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                alignment: Alignment.bottomCenter,
                height: 420,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Enter OTP",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: PinFieldAutoFill(
                          codeLength: 4,
                          controller: otp,
                          keyboardType: TextInputType.numberWithOptions(),
                          textInputAction: TextInputAction.done,
                          decoration: BoxLooseDecoration(
                              strokeColorBuilder: FixedColorBuilder(
                                Colors.black.withOpacity(0.5),
                              ),
                              gapSpace: 25),
                          currentCode: _code,
                          onCodeSubmitted: (val) {
                            // print(val);
                            setState(() {
                              _code = otp.text;
                            });
                            if (otp.text == '') {
                              _alerBox("InValid OTP....");
                            } else {}
                          },
                          onCodeChanged: (val) {
                            print(val);
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      ButtonTheme(
                        buttonColor: appcolor,
                        minWidth: 400,
                        child: FlatButton(
                          color: primaryColor,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: primaryColor)),
                          onPressed: () async {
                            print("-----------");
                            setState(() {
                              print("-----------");
                              _code = otp.text;
                            });
                            if (otp.text == '' || otp.text == null) {
                              print("-----------");
                              _alerBox("InValid OTP....");
                            } else {
                              print("-----------");
                              otp_signin();
                              // check_otp(
                              //   otp.text,
                              // );
                            }
                          },
                          child: Text(
                            "VERIFY",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
