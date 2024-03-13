import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Products.dart';
import 'package:jini_vendor/Views/Inventory/AddGrocery.dart';

import 'package:jini_vendor/Views/Inventory/EditGrocery.dart';
import 'package:jini_vendor/Views/Price/ProductPrice.dart';

class inventory extends StatefulWidget {
  inventory({Key? key}) : super(key: key);

  @override
  _inventoryState createState() => _inventoryState();
}

class _inventoryState extends State<inventory> {
  bool loading = true;
  bool select = false;
  List<Products> Inventory = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Grocery Inventory"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItem()));
        },
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
                GetProducts();
                setState(() {
                  loading = true;
                });
              },
              child: ListView.builder(
                  // physics: BouncingScrollPhysics(),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: Inventory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productprice(
                                        product_id: Inventory[index].ProductsId,
                                        name: Inventory[index].ProductsName,
                                      )));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 20,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                height: 120,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image(
                                          image: NetworkImage(
                                              Inventory[index].ProductsImage),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    Inventory[index]
                                                        .ProductsName,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Category",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(Inventory[index]
                                                      .category))
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Sub Category",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(Inventory[index]
                                                              .subcategory ==
                                                          null
                                                      ? ""
                                                      : Inventory[index]
                                                          .subcategory))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Brand",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    Inventory[index].brand ==
                                                            null
                                                        ? ""
                                                        : Inventory[index]
                                                            .brand,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProduct(
                                                        itemName:
                                                            Inventory[index]
                                                                .ProductsName,
                                                        brand: Inventory[index]
                                                            .brandID,
                                                        category:
                                                            Inventory[index]
                                                                .categoryID,
                                                        ItemImage:
                                                            Inventory[index]
                                                                .ProductsImage,
                                                        subcategory:
                                                            Inventory[index]
                                                                .subcategoryId,
                                                        ItemId: Inventory[index]
                                                            .ProductsId,
                                                      )));
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 25,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
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
                                                            Inventory[index]
                                                                .ProductsId);
                                                        Navigator.pop(
                                                            context, "ok");
                                                      },
                                                      child: const Text("YES"),
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
                                    Expanded(
                                      child: FlutterSwitch(
                                        height: 20.0,
                                        width: 40.0,
                                        padding: 4.0,
                                        toggleSize: 15.0,
                                        borderRadius: 10.0,
                                        activeColor: primaryColor,
                                        value: Inventory[index].status == "1"
                                            ? select = true
                                            : select = false,
                                        onToggle: (value) {
                                          setState(() {
                                            select = value;
                                            select == true
                                                ? Inventory[index].status = "1"
                                                : Inventory[index].status = "0";
                                            StatusUpdate(
                                                "product",
                                                Inventory[index].ProductsId,
                                                Inventory[index].status);
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        Inventory[index].status == "1"
                                            ? "Active"
                                            : "Inactive",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Inventory[index].status == "1"
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  void GetProducts() {
    Service.GetInventory().then((result) {
      // Timer(Duration(seconds: 5), () async {
      //   GetProducts();
      // });
      print(result);
      setState(() {
        loading = false;
        Inventory = result;
      });
    });
  }

  StatusUpdate(item, id, status) {
    print(id);
    Service.UpdateStatus(item, id, status).then((result) {
      setState(() {
        GetProducts();
        print(result);
      });
    });
  }

  DeletePrice(id) {
    Service.DeleteProduct(id).then((result) {
      GetProducts();
    });
  }
}
