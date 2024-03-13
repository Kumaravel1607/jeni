import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/SubCategory.dart';
import 'package:jini_vendor/Views/Sub-Category/EditSubcategory.dart';
import 'package:jini_vendor/Views/Sub-Category/SubcategoryAdd.dart';

class SubCategoryList extends StatefulWidget {
  String category_id = "";
  String category_name = "";
  SubCategoryList({required this.category_id, required this.category_name});

  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  bool select = false;
  bool loading = true;
  List<Subcategory> sub_Category_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_subcategory();
    print(sub_Category_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(widget.category_name),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => subcategory_edit(
                          CategoryId: widget.category_id,
                        )));
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            setState(() {
              loading = true;
            });
            get_subcategory();
          },
          child: sub_Category_list.length == 0
              ? Center(
                  child: Text("Please Add Sub-Category..."),
                )
              : loading == true
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
                        get_subcategory();
                      },
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: sub_Category_list.length,
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
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: 90,
                                          child: sub_Category_list[index]
                                                      .subCategoryImage !=
                                                  null
                                              ? Image.network(
                                                  sub_Category_list[index]
                                                      .subCategoryImage,
                                                )
                                              : Image.network(
                                                  'https://cdn-icons-png.flaticon.com/128/2921/2921855.png'),
                                        ),
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          sub_Category_list[
                                                                  index]
                                                              .subCategoryName,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                      .blueGrey[
                                                                  800]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    sub_Category_list[index]
                                                                .status ==
                                                            "1"
                                                        ? 'Active'
                                                        : "Inactive",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: sub_Category_list[
                                                                        index]
                                                                    .status ==
                                                                "1"
                                                            ? Colors.green
                                                            : Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
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
                                                                  Sub_Category_Edit(
                                                                    subcategory_id:
                                                                        sub_Category_list[index]
                                                                            .subCategoryId,
                                                                    subCategory_Name:
                                                                        sub_Category_list[index]
                                                                            .subCategoryName,
                                                                    subCategory_image:
                                                                        sub_Category_list[index]
                                                                            .subCategoryImage,
                                                                    categoryID:
                                                                        sub_Category_list[index]
                                                                            .categoryId,
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
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 150,
                                                                    width: 150,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage("assets/images/delete.png"))),
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
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      loading =
                                                                          true;
                                                                    });
                                                                    DeleteSubcategory(
                                                                        sub_Category_list[index]
                                                                            .subCategoryId);
                                                                    Navigator.pop(
                                                                        context,
                                                                        "ok");
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "YES"),
                                                                ),
                                                                OutlinedButton(
                                                                  // style: OutlinedButton
                                                                  //     .styleFrom(
                                                                  //   side: BorderSide(
                                                                  //       color: Colors.red),
                                                                  // ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        "ok");
                                                                  },
                                                                  child:
                                                                      const Text(
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
                                                    value:
                                                        sub_Category_list[index]
                                                                    .status ==
                                                                "1"
                                                            ? select = true
                                                            : select = false,
                                                    onToggle: (value) {
                                                      setState(() {
                                                        select = value;
                                                        select == true
                                                            ? sub_Category_list[
                                                                    index]
                                                                .status = "1"
                                                            : sub_Category_list[
                                                                    index]
                                                                .status = "0";
                                                        StatusUpdate(
                                                            "subcategory",
                                                            sub_Category_list[
                                                                    index]
                                                                .subCategoryId,
                                                            sub_Category_list[
                                                                    index]
                                                                .status);
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
                    ),
        ));
  }

  DeleteSubcategory(id) {
    Service.Delete_SubCategory(id).then((result) {
      setState(() {
        get_subcategory();
        loading = false;
      });
      print(result);
    });
  }

  StatusUpdate(item, id, status) {
    Service.UpdateStatus(item, id, status).then((result) {
      setState(() {
        get_subcategory();
        print(result);
      });
    });
  }

  get_subcategory() {
    Service.get_subcategory(widget.category_id).then((result) {
      // Timer(Duration(seconds: 5), () async {
      //   get_subcategory();
      // });
      setState(() {
        sub_Category_list = result;
        loading = false;
      });
      print(sub_Category_list);
    });
  }
}
