import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/ProductPrice.dart';
import 'package:jini_vendor/Models/SubCategory.dart';
import 'package:jini_vendor/Views/Sub-Category/EditSubcategory.dart';
import 'package:jini_vendor/Views/Price/ProductPriceAdd.dart';
import 'package:jini_vendor/Views/Sub-Category/SubcategoryAdd.dart';

class Productprice extends StatefulWidget {
  String product_id = "";
  String name = "";

  Productprice({required this.product_id, required this.name});

  @override
  _ProductpriceState createState() => _ProductpriceState();
}

class _ProductpriceState extends State<Productprice> {
  bool select = false;
  bool loading = true;
  List<ProductPrice> productprice = [];
  String productName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.product_id);
    setState(() {
      productName = widget.name;
    });
    Getproductprice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(productName),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Addprice(
                          itemName: widget.name,
                          itemId: widget.product_id,
                        )));
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : RefreshIndicator(
                color: primaryColor,
                onRefresh: () async {
                  setState(() {
                    loading = true;
                  });
                  Getproductprice();
                },
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: productprice.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: productprice[index].priceId == null
                            ? Container(
                                padding: EdgeInsets.only(top: 300),
                                child: Center(
                                  child: Text("Please Add Price Deteils...."),
                                ),
                              )
                            : Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 20,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 1,
                                                                child: productprice[index].variantName ==
                                                                            null ||
                                                                        productprice[index].variantName ==
                                                                            ""
                                                                    ? Text("")
                                                                    : Text(
                                                                        productprice[index]
                                                                            .variantName,
                                                                        style: TextStyle(
                                                                            color:
                                                                                primaryColor,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "Price ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )),
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(productprice[index].sellingPrice ==
                                                                            "" ||
                                                                        productprice[index].sellingPrice ==
                                                                            null
                                                                    ? ""
                                                                    : ": " +
                                                                        productprice[index]
                                                                            .sellingPrice))
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  "Availability ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )),
                                                            Expanded(
                                                                flex: 2,
                                                                child: Text(productprice[index].quantity ==
                                                                            null ||
                                                                        productprice[index].quantity ==
                                                                            ""
                                                                    ? ""
                                                                    : ": " +
                                                                        productprice[index]
                                                                            .quantity))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Column(
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          width: 150,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/delete.png"))),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text("Are you sure ?"),
                                                      ],
                                                    ),
                                                    //title: Text(),
                                                    actions: <Widget>[
                                                      OutlinedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            loading = true;
                                                          });
                                                          DeletePrice(
                                                              productprice[
                                                                      index]
                                                                  .priceId);
                                                          Navigator.pop(
                                                              context, "ok");
                                                        },
                                                        child:
                                                            const Text("YES"),
                                                      ),
                                                      OutlinedButton(
                                                        // style: OutlinedButton
                                                        //     .styleFrom(
                                                        //   side: BorderSide(
                                                        //       color: Colors.red),
                                                        // ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, "ok");
                                                        },
                                                        child: const Text("NO"),
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 25,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    }),
              ));
  }

  Getproductprice() {
    Service.GetProductPrice(widget.product_id).then((result) {
      // Timer(Duration(seconds: 5), () async {
      //   Getproductprice();
      // });
      setState(() {
        productprice = result;

        loading = false;
      });
      // print(productprice[0]);
    });
  }

  // StatusUpdate(item, id, status) {
  //   Service.UpdateStatus(item, id, status).then((result) {
  //     setState(() {
  //       Getproductprice();
  //       print(result);
  //     });
  //   });
  // }

  DeletePrice(id) {
    Service.DeleteProductPrice(id).then((result) {
      Getproductprice();
    });
  }
}
