import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Variants.dart';
import 'package:jini_vendor/Views/Inventory/GroceryInventory.dart';
import 'package:jini_vendor/Views/Variants/Variants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Addprice extends StatefulWidget {
  String itemName = "";
  String itemId = "";
  Addprice({required this.itemName, required this.itemId});

  @override
  _AddpriceState createState() => _AddpriceState();
}

class _AddpriceState extends State<Addprice> {
  bool _loading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();
  var price = TextEditingController();
  var quantity = TextEditingController();
  List<Variants> Variant = [];
  String varientID = "";
  String status = "";
  String name = "";
  String itemId = "";

  @override
  void initState() {
    super.initState();
    print(widget.itemId);

    // getDropdownValues();
    get_variants();
    // option_list();
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/checked.png"))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(message),
              ],
            ),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  // static List<Country> countrylist = [];

  // final _items = countrylist
  //     .map((animal) => MultiSelectItem<Country>(animal, animal.name))
  //     .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Price Details"),
        centerTitle: true,
      ),
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title("ITEM'S VARIANT"),
                      SizedBox(height: 5),
                      Drop_down(Variant, "partner_income", varientID, 1),

                      SizedBox(height: 10),
                      title("RATE"),
                      SizedBox(height: 5),
                      Container(height: 90, child: textform2(price, 1)),

                      // Drop_down(
                      //     education, "partner_education", partnerEducation, 1),

                      title("AVAILABILITY"),
                      SizedBox(height: 5),
                      Container(height: 90, child: textform2(quantity, 1)),

                      SizedBox(height: 30),
                      btn()
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
              updatePrice();
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

  DropdownButtonFormField<String> Drop_down(
    List options,
    my_controller,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select"),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item.variantId.toString(),
          child: new Text(
            item.variantName,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          varientID = newValue.toString();
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

  DropdownButtonFormField<String> dropdown() {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select"),
      items: <String>['Active', 'Inactive'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          value == "Active" ? status = "1" : status = "0";
        });
      },
    );
  }

  Padding textform(my_controller_name, required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.phone,
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

  Padding textform2(my_controller_name, required) {
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

  //------------------------API-----------------------------------
  get_variants() {
    Service.GetVariants().then((result) {
      setState(() {
        Variant = result;
        _loading = false;
      });
      print(Variant);
    });
  }

  updatePrice() {
    Service.UpdatePrice(varientID, price.text, quantity.text, status,
            widget.itemName, widget.itemId)
        .then((result) {
      print(result);
      setState(() {
        _loading = false;
        _alerBox("Added Successfully");
      });
    });
  }
}
