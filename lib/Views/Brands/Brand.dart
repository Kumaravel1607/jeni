import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Brand.dart';
import 'package:jini_vendor/Views/Brands/BrandsAdd.dart';

import 'package:jini_vendor/Views/Brands/EditBrand.dart';

class brand extends StatefulWidget {
  const brand({Key? key}) : super(key: key);

  @override
  _brandState createState() => _brandState();
}

class _brandState extends State<brand> {
  bool loading = true;
  bool select = false;
  List<Brand> brand = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Brands List'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BrandAdd()));
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
                  setState(() {
                    loading = true;
                  });
                  GetBrand();
                },
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: brand.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: brand[index].brandImage == null
                                      ? Image.asset("assets/images/photos.png")
                                      : Image.network(brand[index].brandImage),
                                ),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    brand[index].brandName,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: primaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              brand[index].status == "1"
                                                  ? 'Active'
                                                  : "Inactive",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      brand[index].status == "1"
                                                          ? Colors.green
                                                          : Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditBrand(
                                                              brandID:
                                                                  brand[index]
                                                                      .brandId,
                                                              brandName: brand[
                                                                      index]
                                                                  .brandName,
                                                              brandImage: brand[
                                                                      index]
                                                                  .brandImage,
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
                                                            Text(
                                                                "Are you sure ?"),
                                                          ],
                                                        ),
                                                        //title: Text(),
                                                        actions: <Widget>[
                                                          OutlinedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                loading = true;
                                                              });
                                                              Deletebrand(
                                                                  brand[index]
                                                                      .brandId);
                                                              Navigator.pop(
                                                                  context,
                                                                  "ok");
                                                            },
                                                            child: const Text(
                                                                "YES"),
                                                          ),
                                                          OutlinedButton(
                                                            // style: OutlinedButton
                                                            //     .styleFrom(
                                                            //   side: BorderSide(
                                                            //       color: Colors.red),
                                                            // ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  "ok");
                                                            },
                                                            child: const Text(
                                                                "NO"),
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
                                            flex: 1,
                                            child: FlutterSwitch(
                                              height: 20.0,
                                              width: 40.0,
                                              padding: 4.0,
                                              toggleSize: 15.0,
                                              borderRadius: 10.0,
                                              activeColor: primaryColor,
                                              value: brand[index].status == "1"
                                                  ? select = true
                                                  : select = false,
                                              onToggle: (value) {
                                                setState(() {
                                                  select = value;
                                                  select == true
                                                      ? brand[index].status =
                                                          "1"
                                                      : brand[index].status =
                                                          "0";
                                                  StatusUpdate(
                                                      "brand",
                                                      brand[index].brandId,
                                                      brand[index].status);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
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

  //----------------------------API------------------------//
  Deletebrand(id) {
    Service.DeleteBrand(id).then((result) {
      GetBrand();
      setState(() {
        loading = true;
      });
    });
  }

  StatusUpdate(item, id, status) {
    Service.UpdateStatus(item, id, status).then((result) {
      setState(() {
        GetBrand();
        print(result);
      });
    });
  }

  GetBrand() {
    Service.GetBrand().then((Result) {
      // Timer(Duration(seconds: 5), () async {
      //   GetBrand();
      // });
      setState(() {
        brand = Result;
        loading = false;
      });
      print(Result);
    });
  }
}
