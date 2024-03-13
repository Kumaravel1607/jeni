import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';

import 'Drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String orderstoday = "";
  String Productscounts = "";
  bool loading = true;
  @override
  void initState() {
    super.initState();
    get_dashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Dashboard"), backgroundColor: primaryColor),
        backgroundColor: white,
        drawer: navigationDrawer(),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : RefreshIndicator(
                color: primaryColor,
                onRefresh: () async {
                  get_dashboard();
                },
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                          card(Icons.inventory_outlined, "Orders Today",
                              orderstoday),
                          card(Icons.ballot_outlined, "Products Today",
                              Productscounts),
                        ],
                      ),
                    )),
              ));
  }

  Card card(icon, text1, value) {
    return Card(
        elevation: 20,
        //<-- Card
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    icon,
                    size: 25,
                    color: Colors.blueGrey,
                  )),
              Expanded(
                flex: 4,
                child: Text(
                  text1,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey[800]),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[800]),
                ),
              )
            ],
          ),
        ));
  }

  Card card1(icon, text1, value) {
    return Card(
        elevation: 20,
        //<-- Card
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    icon,
                    size: 25,
                    color: Colors.blueGrey,
                  )),
              Expanded(
                flex: 4,
                child: Text(
                  text1,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey[800]),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "₹" + value,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                ),
              )
            ],
          ),
        ));
  }

  get_dashboard() {
    Service.dash_board().then((result) {
      print(result);
      setState(() {
        loading = false;
        orderstoday = result["orders_count"].toString();
        Productscounts = result["products_count"].toString();
      });
    });
  }
}
