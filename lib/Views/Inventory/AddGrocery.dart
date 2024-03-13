import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Brand.dart';
import 'package:jini_vendor/Models/Category.dart';
import 'package:jini_vendor/Models/SubCategory.dart';
import 'package:jini_vendor/Views/Price/ProductPriceAdd.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool _loading = true;
  bool image = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();
  var itemname = TextEditingController();
  List<Category> category = [];
  List<Subcategory> subcategory = [];
  List<Brand> brand = [];
  String _category = "";
  String _scategory = "";
  String _brand = "";
  String CatrgoryID = "";
  String SubCatrgoryID = "";
  String BrandID = "";
  File image_path = File("");
  String ItemImage = "";

  @override
  void initState() {
    super.initState();
    get_category();
    // getDropdownValues();
    get_brand();
    // option_list();
  }

  // static List<Country> countrylist = [];

  // final _items = countrylist
  //     .map((animal) => MultiSelectItem<Country>(animal, animal.name))
  //     .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Grocery Item"),
        centerTitle: true,
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title("Category"),
                      SizedBox(height: 5),
                      Drop_down(category, "partner_income", _category, 1),
                      SizedBox(height: 10),
                      title("Sub Category"),
                      SizedBox(height: 5),
                      Drop_down1(subcategory, "partner_income", _scategory, 1),

                      // Drop_down(
                      //     education, "partner_education", partnerEducation, 1),
                      SizedBox(height: 10),
                      title("Brand"),
                      SizedBox(height: 5),
                      Drop_down2(brand, "partner_nation", _brand, 1),
                      SizedBox(height: 10),
                      title("Item Name"),
                      Container(height: 90, child: textform(itemname, 1)),
                      title("Item Image"),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: ElevatedButton(
                            onPressed: () {
                              getimagefromgallery();
                            },
                            child: Container(
                              child: Center(
                                child: Text("Choose Images"),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: FileImage(image_path)),
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      SizedBox(height: 10),
                      btn()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Padding btn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // update_profile();
              UpdateInventory();
              setState(() {
                _loading = true;
              });
            }
          },
          child: Container(
            child: Center(
              child: Text("Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            height: 50,
            width: 200,
          )),
    );
  }

  Padding title(value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> Drop_down(
    List options,
    my_controller,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select"),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item.categoryId.toString(),
          child: new Text(
            item.categoryName,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          CatrgoryID = newValue.toString();
          print(CatrgoryID);
          get_subcategory();
        });
      },
      validator: (value) {
        if (required == 1) {
          print(value);
          if (value == "" || value == null) {
            return 'This field is requrired';
          }
          return null;
        } else {
          return null;
        }
      },
    );
  }

  DropdownButtonFormField<String> Drop_down1(
    List options,
    my_controller,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select"),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item.subCategoryId.toString(),
          child: new Text(
            item.subCategoryName,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          SubCatrgoryID = newValue.toString();
          print(SubCatrgoryID);
        });
      },
      validator: (value) {
        if (required == 1) {
          print(value);
          if (value == "" || value == null) {
            return 'This field is requrired';
          }
          return null;
        } else {
          return null;
        }
      },
    );
  }

  DropdownButtonFormField<String> Drop_down2(
    List options,
    my_controller,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("Select"),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item.brandId.toString(),
          child: new Text(
            item.brandName,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          BrandID = newValue.toString();
        });
      },
      validator: (value) {
        if (required == 1) {
          print(value);
          if (value == "" || value == null) {
            return 'This field is requrired';
          }
          return null;
        } else {
          return null;
        }
      },
    );
  }

  // DropdownButtonFormField<String> dropdown() {
  //   return DropdownButtonFormField<String>(
  //     decoration: textDecoration(astro),
  //     items: <String>['A', 'B', 'C', 'D'].map((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: new Text(value),
  //       );
  //     }).toList(),
  //     onChanged: (_) {},
  //   );
  // }

  Padding textform(my_controller_name, required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: TextFormField(
          controller: my_controller_name,
          validator: (value) {
            if (required == 1) {
              if (value == "") {
                return 'This field is requrired';
              }
              return null;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF843369))),
            // labelText: value,
            labelStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF843369))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF843369))),
          ),
        ),
      ),
    );
  }

  // -----------------------------API-----------------------------//
  get_category() {
    Service.get_category().then((result) {
      setState(() {
        category = result;
        _loading = false;
      });
      print(category);
    });
  }

  get_subcategory() {
    Service.get_subcategory(CatrgoryID).then((result) {
      setState(() {
        subcategory = result;
        _loading = false;
      });
      print(subcategory);
    });
  }

  get_brand() {
    Service.GetBrand().then((result) {
      setState(() {
        brand = result;
        _loading = false;
      });
      print(brand);
    });
  }

  Future getimagefromgallery() async {
    final ImagePicker _picker = ImagePicker();
    var pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedimage != null) {
        image_path = File(pickedimage.path);
      } else {
        print('no image');
      }
    });
  }

  Future<void> _alerBox(message) async {
    await showDialog(
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
                          image: AssetImage("assets/images/checked.png"))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(message),
              ],
            ),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  void UpdateInventory() {
    Service.UpdateInventory(
            CatrgoryID, SubCatrgoryID, BrandID, itemname.text, image_path)
        .then((result) {
      print(result);
      _alerBox("Added Successfully");
      setState(() {
        _loading = false;
      });
    });
  }
}
