import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Orders.dart';
import 'package:jini_vendor/Views/Orders/OrdersTab.dart';

class Orderspage extends StatefulWidget {
  Orderspage({Key? key}) : super(key: key);

  @override
  _OrderspageState createState() => _OrderspageState();
}

class _OrderspageState extends State<Orderspage> {
  List<Orders> banners = [];

  @override
  void initState() {
    GetOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrdersTab(
                              refNo: orders[index].basics.postNo,
                              name: orders[index].basics.postName,
                              type: orders[index].basics.postName,
                              Delstatus: orders[index].basics.orderStatus,
                              PostedDate: orders[index].basics.postedOn,
                              Delcharge: orders[index].basics.paymentStatus,
                              TotalCharge: orders[index].basics.totalAmount,
                              data: orders[index].products,
                            )));
              },
              child: Card(
                color: white,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                                "https://cdn-icons-png.flaticon.com/512/1261/1261163.png"),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orders[index].basics.postName,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  orders[index].basics.postDescription,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Posted on : "),
                                    Text(orders[index]
                                        .basics
                                        .postedOn
                                        .substring(0, 10))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    orders[index].basics.postNo == null
                                        ? "Undefined"
                                        : orders[index].basics.postNo,
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 10),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    borderRadius: BorderRadius.circular(10)),
                                height: 20,
                              ),
                            ),
                            SizedBox(height: 60),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //------------------------------API----------------------------------------

  void GetOrders() {
    Service.getOrders().then((result) {
      setState(() {
        orders = result;
      });
      print(orders);
    });
  }
}
