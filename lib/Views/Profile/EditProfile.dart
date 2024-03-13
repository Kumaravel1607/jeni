import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Views/Profile/AddressDetails.dart';
import 'package:jini_vendor/Views/KYC/KycDetails.dart';
import 'package:jini_vendor/Views/Profile/ShopDetials.dart';

class editprofile extends StatelessWidget {
  const editprofile({Key? key}) : super(key: key);

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
                Tab(text: "Shop Details"),
                Tab(text: "Address Details"),
              ],
            ),
            title: const Text('Update Shop Details'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: const TabBarView(
            children: [shopdetails(), addressdetails()],
          ),
        ),
      ),
    );
  }
}
