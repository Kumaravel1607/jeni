import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';

import 'package:jini_vendor/Views/Bank%20Details/BankDetails.dart';
import 'package:jini_vendor/Views/Category/Category.dart';

import 'package:jini_vendor/Views/Inventory/GroceryInventory.dart';
import 'package:jini_vendor/Views/Profile/EditProfile.dart';
import 'package:jini_vendor/Views/KYC/KycDetails.dart';
import 'package:jini_vendor/Views/Orders/Orders.dart';
import 'package:jini_vendor/Views/Orders/OrdersTab.dart';
import 'package:jini_vendor/Views/Others/SplashScreen.dart';
import 'package:jini_vendor/Views/Brands/Brand.dart';

import 'package:jini_vendor/Views/Variants/Variants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navigationDrawer extends StatefulWidget {
  const navigationDrawer({Key? key}) : super(key: key);

  @override
  _navigationDrawerState createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  var _height = 50.0;
  var _width = 100.0;
  bool bottom = false;

  var profile_image = "";
  String firstname = "";

  @override
  void initState() {
    super.initState();
    get_shop();
  }

  animationFunction() {
    setState(() {
      _height = _height == 50.0 ? 100.0 : 50.0;
    });
  }

  void get_shop() {
    Service.get_shop_profile().then((result) {
      print(result);
      setState(() {
        profile_image = result["result"]["profile"];
        firstname = result["result"]["first_name"];
      });
      print(firstname);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          createDrawerHeader(),
          // animationcontainer(),

          // createDrawerBodyItem(icon: Icons.home, text: 'Grocery'),
          createDrawerBodyItem(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Orderspage()));
              },
              icon: Icons.shopping_bag_outlined,
              text: 'Orders'),
          createDrawerBodyItem(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => kyc_details1()));
              },
              icon: Icons.fact_check_outlined,
              text: 'KYC Details'),
          createDrawerBodyItem(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Bankdetails()));
              },
              icon: Icons.account_balance_outlined,
              text: 'Bank Details'),
          divider2(),
          title("Grocery"),
          divider2(),

          createDrawerBodyItem(
              icon: Icons.label_outline_rounded,
              text: 'Grocery Inventory',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => inventory()));
              }),
          divider2(),
          title("Grocery Master"),

          divider2(),
          createDrawerBodyItem(
              icon: Icons.label_outline_rounded,
              text: 'Grocery Category',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => categorylist()));
              }),

          createDrawerBodyItem(
              icon: Icons.label_outline_rounded,
              text: 'Grocery Brands',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => brand()));
              }),
          createDrawerBodyItem(
              icon: Icons.label_outline_rounded,
              text: 'Grocery Variants',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => variants()));
              }),

          divider2(),

          createDrawerBodyItem(
              onTap: () async {
                _alerBox("Confirm to Logout");
              },
              icon: Icons.shopping_bag_outlined,
              text: 'Log Out'),

          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
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
                  Navigator.of(context);
                },
                child: const Text("NO"),
              ),
              OutlinedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  await prefs.remove('mobile');

                  await Future.delayed(Duration(seconds: 2));

                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) => SplashScreen(),
                    ),

                    // this function should return true when we're done removing routes
                    // but because we want to remove all other screens, we make it
                    // always return false
                    (Route route) => false,
                  );
                },
                child: const Text("YES"),
              )
            ],
          );
        });
  }

  Padding title(name) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Text(
        name,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor),
      ),
    );
  }

  Padding animationcontainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_drop_down_sharp),
                        Text(
                          "Grocery",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                        ),
                      ],
                    ),
                    Icon(bottom == true
                        ? Icons.arrow_drop_down_sharp
                        : Icons.arrow_drop_up_sharp)
                  ],
                ),
              ),
              bottom == true
                  ? _height == 100.0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_forward_rounded),
                              Text("Grocery Inventory")
                            ],
                          ),
                        )
                      : SizedBox()
                  : SizedBox()
            ],
          ),
        ),
        onTap: () {
          animationFunction();
          bottom = bottom == false ? true : false;
        },
      ),
    );
  }

  DropdownButtonFormField<String> dropdown() {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Grocery"),
      items: <String>['A', 'B', 'C', 'D'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
      child: Stack(
        children: [
          Container(
            width: 200,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: profile_image == ""
                      ? NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/848/848043.png")
                      : NetworkImage(profile_image),

                  backgroundColor: Colors.blueGrey[100],
                  // child: profile_image != ""
                  //     ? Image.asset("assets/images/user.png")
                  //     : Image(image: NetworkImage(profile_image)),
                  radius: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  firstname,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editprofile()));
            },
            child: Card(
              margin: EdgeInsets.only(top: 75, left: 120),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                child: Icon(
                  Icons.edit,
                  color: primaryColor,
                  size: 20,
                ),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blueGrey[100]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
