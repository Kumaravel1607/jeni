import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Category.dart';
import 'package:jini_vendor/Views/Category/CategoryAdd.dart';
import 'package:jini_vendor/Views/Category/EditCategory.dart';
import 'package:jini_vendor/Views/Sub-Category/SubCategoryList.dart';

class categorylist extends StatefulWidget {
  const categorylist({Key? key}) : super(key: key);

  @override
  _categorylistState createState() => _categorylistState();
}

class _categorylistState extends State<categorylist> {
  bool loading = true;
  List<Category> category = [];
  bool select = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get_category();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Category List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryAdd()));
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
            get_category();
          },
          child: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategoryList(
                                      category_id: category[index].categoryId,
                                      category_name:
                                          category[index].categoryName,
                                    )));
                      },
                      child: Padding(
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
                                    child: category[index].categoryImage == null
                                        ? Image.asset(
                                            "assets/images/picture.png")
                                        : Image.network(
                                            category[index].categoryImage),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              child: Text(
                                                category[index].categoryName,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryColor),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              category[index].status == "1"
                                                  ? 'Active'
                                                  : "Inactive",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      category[index].status ==
                                                              "1"
                                                          ? Colors.green
                                                          : Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            category_edit(
                                                              category_id:
                                                                  category[
                                                                          index]
                                                                      .categoryId,
                                                              Category_Name:
                                                                  category[
                                                                          index]
                                                                      .categoryName,
                                                              image: category[
                                                                      index]
                                                                  .categoryImage,
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
                                                              Delete_Category(
                                                                  category[
                                                                          index]
                                                                      .categoryId);
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
                                              value:
                                                  category[index].status == "1"
                                                      ? select = true
                                                      : select = false,
                                              onToggle: (value) {
                                                setState(() {
                                                  select = value;
                                                  select == true
                                                      ? category[index].status =
                                                          "1"
                                                      : category[index].status =
                                                          "0";
                                                  StatusUpdate(
                                                      "category",
                                                      category[index]
                                                          .categoryId,
                                                      category[index].status);
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
                      ),
                    );
                  }),
        ));
  }

  //-----------------------------------------API----------------------------------//
  Delete_Category(id) {
    Service.Delete_Category(id).then((result) {
      setState(() {
        get_category();
      });
    });
  }

  StatusUpdate(item, id, status) {
    Service.UpdateStatus(item, id, status).then((result) {
      setState(() {
        get_category();
        print(result);
      });
    });
  }

  get_category() {
    Service.get_category().then((result) {
      // Timer(Duration(seconds: 5), () async {
      //   get_category();
      // });
      setState(() {
        category = result;
        loading = false;
      });
      print(category);
    });
  }
}
