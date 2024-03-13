import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Views/Home/Home.dart';
import 'package:jini_vendor/Views/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      SharedPreferences session = await SharedPreferences.getInstance();
      var token = session.getString('token');
      if (token != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
      print("dd");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(applogo),
      ),
    );
  }
}
