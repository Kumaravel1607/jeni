import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Variants.dart';
import 'package:jini_vendor/Views/Variants/EditVariants.dart';
import 'package:jini_vendor/Views/Variants/VariantsAdd.dart';

class variants extends StatefulWidget {
  const variants({Key? key}) : super(key: key);

  @override
  _variantsState createState() => _variantsState();
}

class _variantsState extends State<variants> {
  bool loading = true;
  bool select = false;
  List<Variants> Variant = [];
  @override
  void initState() {
    super.initState();
    GetVariants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Variants List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => VariantAdd()));
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
                  GetVariants();
                },
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: Variant.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'VARIANTS NAME - ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.blueGrey[800]),
                                                ),
                                                Text(
                                                  Variant[index].variantName,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  'VARIANTS SHORT NAME - ',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  Variant[index]
                                                      .variantShortName,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Colors.blueGrey[800]),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        Variant[index].status == "1"
                                            ? 'Active'
                                            : "Inactive",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Variant[index].status == "1"
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
                                                      VariantEdit(
                                                        id: Variant[index]
                                                            .variantId,
                                                        Name: Variant[index]
                                                            .variantName,
                                                        ShortName: Variant[
                                                                index]
                                                            .variantShortName,
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
                                                        deleteVariants(
                                                            Variant[index]
                                                                .variantId);
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
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: FlutterSwitch(
                                          height: 20.0,
                                          width: 40.0,
                                          padding: 4.0,
                                          toggleSize: 15.0,
                                          borderRadius: 10.0,
                                          activeColor: primaryColor,
                                          value: Variant[index].status == "1"
                                              ? select = true
                                              : select = false,
                                          onToggle: (value) {
                                            setState(() {
                                              select = value;
                                              select == true
                                                  ? Variant[index].status = "1"
                                                  : Variant[index].status = "0";
                                              StatusUpdate(
                                                  "variant",
                                                  Variant[index].variantId,
                                                  Variant[index].status);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }

//---------------------------API-----------------------------
  GetVariants() {
    Service.GetVariants().then((results) {
      setState(() {
        Variant = results;
        loading = false;
      });
    });
  }

  StatusUpdate(item, id, status) {
    Service.UpdateStatus(item, id, status).then((result) {
      setState(() {
        GetVariants();
        print(result);
      });
    });
  }

  deleteVariants(id) {
    Service.DeleteVariants(id).then((results) {
      GetVariants();
      setState(() {
        loading = false;
      });
    });
  }
}
