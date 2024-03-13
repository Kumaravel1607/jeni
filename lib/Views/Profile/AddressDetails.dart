import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/City.dart';
import 'package:jini_vendor/Models/Country.dart';
import 'package:jini_vendor/Models/State.dart';

import 'package:shared_preferences/shared_preferences.dart';

class addressdetails extends StatefulWidget {
  const addressdetails({Key? key}) : super(key: key);

  @override
  _addressdetailsState createState() => _addressdetailsState();
}

class _addressdetailsState extends State<addressdetails> {
  bool _loading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();

  String astro = "";
  List<Country> country = [];
  List<States> state = [];
  List<City> city = [];
  String partnerIncome = "";
  // String countryid = "";
  // String stateid = "";
  // String cityid = "";
  String _country = "";
  String _state = "";
  String _city = "";
  var address = TextEditingController();
  var pincode = TextEditingController();
  var longitude = TextEditingController();
  var latitude = TextEditingController();
  var token = "";

  var mobile = "";

  @override
  void initState() {
    super.initState();

    // getDropdownValues();

    // option_list();

    get_id();
    get_shop();
    get_city();
    get_state();
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
                      // title("COUNTRY *"),

                      // Drop_down(country, "status", _country, 1),
                      // SizedBox(height: 10),

                      title("STATE  *"),

                      Drop_down1(state, "status", _state, 1),
                      SizedBox(height: 10),
                      title("SHOP CITY *"),

                      Drop_down2(city, "status", _city, 1),
                      SizedBox(height: 10),

                      title("ADDRESS *"),

                      Container(height: 90, child: textform(address, 1)),

                      title("POSTAL CODE *"),

                      Container(height: 90, child: textform1(pincode, 1)),
                      title("LONGITUDE  *"),
                      Container(height: 90, child: textform1(longitude, 1)),
                      title("LATITUDE *"),

                      Container(height: 90, child: textform1(latitude, 1)),
                      // Drop_down(
                      //     education, "partner_education", partnerEducation, 1),

                      btn(),
                      SizedBox(height: 20),
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
              update_address();
              setState(() {
                _loading = true;
              });
              // update_profile();
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

  DropdownButtonFormField<String> Drop_down1(
    List options,
    my_controller,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select State"),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item.id.toString(),
          child: new Text(
            item.name,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          print(newValue);
          _state = newValue.toString();
        });
      },
      validator: (value) {
        if (required == 1) {
          print(value);
          if (value == "" || value == null) {
            return 'This field is requrired';
          }
          return null;
        } else {
          return null;
        }
      },
    );
  }

  DropdownButtonFormField<String> Drop_down2(
    List options,
    my_controller,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select City"),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item.id.toString(),
          child: new Text(
            item.city,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _city = newValue.toString();
          print(newValue);
        });
      },
      validator: (value) {
        if (required == 1) {
          print(value);
          if (value == "" || value == null) {
            return 'This field is requrired';
          }
          return null;
        } else {
          return null;
        }
      },
    );
  }

  Padding textform(my_controller_name, required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: TextFormField(
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

  Padding textform1(my_controller_name, required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.number,
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

  //////////////////////////////////////////////////////////////////////////////////
  void get_shop() {
    Service.get_shop_profile().then((result) {
      print(result);
      setState(() {
        // _country = result["result"]["country_code"];
        _state = result["result"]["state_id"];
        _city = result["result"]["city_id"];
        address.text = result["result"]["address"];
        pincode.text = result["result"]["zip_code"];
        longitude.text = result["result"]["longitude"];
        latitude.text = result["result"]["latitude"];
      });
      print("object");
      print(_country);
    });
  }

  get_id() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = _pref.getString("token").toString();

    mobile = _pref.getString("mobile").toString();

    print(token);

    print(mobile);
  }

  // get_country() {
  //   Service.get_country().then((result) {
  //     setState(() {
  //       _loading = false;
  //       print("----------------");
  //       print(result);
  //       country = result;

  //       _loading = false;
  //     });

  //     print(result.length);
  //   });
  // }

  get_state() {
    Service.get_state().then((result) {
      setState(() {
        print("----------------");
        print(result);
        state = result;
      });

      print(result.length);
    });
  }

  get_city() {
    Service.get_city().then((result) {
      setState(() {
        _loading = false;
        print("----------------");
        print(result);
        city = result;
        _loading = false;
      });

      print(result.length);
    });
  }

  update_address() {
    Service.update_shopaddress(_state, _city, address.text, pincode.text,
            latitude.text, longitude.text)
        .then((result) {
      _alerBox(result["msg"]);
      setState(() {
        _loading = false;
      });
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
}
