import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';

class Sub_Category_Edit extends StatefulWidget {
  String subcategory_id = "";
  String subCategory_Name = "";
  String subCategory_image = "";
  String categoryID = "";
  Sub_Category_Edit(
      {required this.subcategory_id,
      required this.subCategory_Name,
      required this.subCategory_image,
      required this.categoryID});

  @override
  _Sub_Category_EditState createState() => _Sub_Category_EditState();
}

class _Sub_Category_EditState extends State<Sub_Category_Edit> {
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var subCategoryname = TextEditingController();
  File image_path = File("");
  String image = "";
  bool img = false;
  bool valid = true;

  @override
  void initState() {
    setState(() {
      subCategoryname.text = widget.subCategory_Name;
      image = widget.subCategory_image;
      print("---------------");
      print(image);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Edit Subcategory"),
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title("Subcategory Name"),
                      textform(subCategoryname, 1),
                      title("Subcategory Image"),
                      select_btn(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: img == true
                                ? DecorationImage(image: FileImage(image_path))
                                : DecorationImage(
                                    image: NetworkImage(image == null
                                        ? "https://cdn-icons.flaticon.com/png/512/4211/premium/4211763.png?token=exp=1634539542~hmac=fb6f0cf549c67adb3a354f48217235a8"
                                        : image)),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(height: 15),
                      valid == false
                          ? Text("No Image",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ))
                          : SizedBox(),
                      SizedBox(height: 15),
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
              setState(() {
                img == true ? valid = false : valid = true;
                _loading = true;
              });
              update_category();
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

  Padding select_btn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () {
            setState(() {
              img = true;
            });
            filepick1();
          },
          child: Container(
            width: 80,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.camera_alt),
                  Text("Choose"),
                ],
              ),
            ),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

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
                borderSide: BorderSide(color: Colors.blueGrey)),
            // labelText: value,
            labelStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
          ),
        ),
      ),
    );
  }

  //---------------------------API--------------------------------//

  update_category() {
    Service.edit_subcategory(subCategoryname.text, image_path,
            widget.subcategory_id, widget.categoryID, widget.subcategory_id)
        .then((result) {
      setState(() {
        _loading = false;
        _alerBox("Updated Successfully");
      });
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

  filepick1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        image_path = File(result.files.single.path!);
      });
    }

    // File _file = File(file.name);
    // Uint8List bytes = _file.readAsBytesSync();
    // String base64Image = base64Encode(bytes);
  }
}
