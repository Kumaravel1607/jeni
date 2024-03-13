import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const api_url = "http://dev.sinewysoft.com/jini/merchant/";
const api_url2 = "http://dev.sinewysoft.com/jini/master/";
const String appname = "Jini";
const String applogo = "assets/images/splash_screen.png";
const String appicon = "assets/images/icons/logo_png.png";
const appfontsize = 14;

const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
const appcolor = Color(0xFF17C5CC);
const primaryColor = Color(0xFFF04D4E);
const secondaryColor = Color(0xFFA4A4A4);
const appbarcolor = Color(0xFF17C5CC);
const String inr = "₹";
const bgColor = Color(0xFFAC4E5B);

divider() => Divider(
      color: Colors.grey,
      thickness: 0.5,
      height: 3,
    );
divider2() => Divider(
      color: Colors.grey,
      thickness: 0.3,
      height: 3,
    );
divider3() => Divider(
      color: Colors.grey,
      height: 0,
      thickness: 0.5,
    );

padding_all(padding_size) => EdgeInsets.only(
    left: padding_size,
    right: padding_size,
    top: padding_size,
    bottom: padding_size);

padding_tb(padding_size) =>
    EdgeInsets.only(top: padding_size, bottom: padding_size);

padding_lf(padding_size) =>
    EdgeInsets.only(left: padding_size, right: padding_size);

border_all(border_size) =>
    new Border.all(width: border_size, color: Colors.black);

textDecoration(hint) => InputDecoration(
      fillColor: Colors.white,
      // prefixIcon: Icon(icon, color: black,),
      filled: true,
      // contentPadding: EdgeInsets.only(left: 10),
      // contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      hintText: (hint),
      hintStyle: TextStyle(
        color: Colors.grey[700],
        fontSize: 16.0,
      ),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
textDecoration1(hint) => InputDecoration(
      fillColor: Colors.white,
      // prefixIcon: Icon(icon, color: black,),
      filled: true,
      // contentPadding: EdgeInsets.only(left: 10),
      // contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      hintText: (hint),
      hintStyle: TextStyle(
        color: Colors.grey[700],
        fontSize: 16.0,
      ),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
