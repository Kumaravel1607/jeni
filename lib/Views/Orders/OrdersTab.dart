import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Models/Orders.dart';
import 'package:jini_vendor/Views/Brands/Brand.dart';
import 'package:jini_vendor/Views/Orders/Details.dart';
import 'package:jini_vendor/Views/Orders/OrderDetails.dart';
import 'package:jini_vendor/Views/Variants/Variants.dart';

class OrdersTab extends StatefulWidget {
  String refNo = "";
  String name = "";
  String type = "";
  String Delstatus = "";
  String Delcharge = "";
  String TotalCharge = "";
  String PostedDate = "";
  List<Product> data = [];
  OrdersTab(
      {required this.refNo,
      required this.name,
      required this.Delstatus,
      required this.Delcharge,
      required this.TotalCharge,
      required this.PostedDate,
      required this.type,
      required this.data});

  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Tab(text: "Details"),
                Tab(text: "Products"),
              ],
            ),
            title: const Text('Product Details'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: TabBarView(
            children: [
              Details(
                refNo: widget.refNo,
                name: widget.name,
                type: widget.type,
                Delstatus: widget.Delstatus,
                Delcharge: widget.Delcharge,
                PostedDate: widget.PostedDate,
                TotalCharge: widget.TotalCharge,
              ),
              orderDetails(
                products: widget.data,
              )
            ],
          ),
        ),
      ),
    );
  }
}
