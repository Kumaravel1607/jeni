import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/Category.dart';
import 'package:jini_vendor/Models/Country.dart';

import 'package:image_picker/image_picker.dart';
import 'package:jini_vendor/Models/State.dart';

class subcategory_edit extends StatefulWidget {
  String CategoryId = "";
  subcategory_edit({required this.CategoryId});

  @override
  _subcategory_editState createState() => _subcategory_editState();
}

class _subcategory_editState extends State<subcategory_edit> {
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var categoryname = TextEditingController();
  var image = "";

  File image_path = File("");

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Subcategory"),
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
                      SizedBox(
                        height: 10,
                      ),
                      title("Subcategory Name"),
                      textform(categoryname, 1),
                      title("Subcategory Image"),
                      select_btn(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: FileImage(image_path)),
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(height: 15),
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
            getimagefromgallery();
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
    Service.update_subcategory(widget.CategoryId, categoryname.text, image_path)
        .then((result) {
      print("------------");
      print(result);
      setState(() {
        _loading = false;
        _alerBox("SubCategory Added");
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

  // imagepicker() async {
  //   getimagefromgallery();
  //   // List<Media>? res = await ImagesPicker.pick(
  //   //   count: 1,
  //   //   pickType: PickType.all,
  //   //   language: Language.System,
  //   //   // maxSize: 500,
  //   //   cropOpt: CropOption(
  //   //     aspectRatio: CropAspectRatio.custom,
  //   //   ),
  //   // );
  //   // print("------------------");
  //   // print(res);
  //   // if (res != null) {
  //   //   print(res.map((e) => e.path).toList());
  //   //   List my_gallery = [];

  //   //   print(res);

  //   //   setState(() {
  //   //     for (var i = 0; i < res.length; i++) {
  //   //       var path = res[0].thumbPath;

  //   //       image_path = File(path!);
  //   //       // Uint8List bytes = file.readAsBytesSync();
  //   //       // String base64Image = base64Encode(bytes);
  //   //       // print(base64Image);
  //   //       // my_gallery.add(base64Image);
  //   //     }
  //   //     // image = my_gallery.join(",");

  //   //     print(my_gallery);
  //   //     print("2222222");
  //   //     // my_gallery != ""
  //   //     //     ? upload_img(my_gallery.join(","))
  //   //     //     : "";
  //   //   });
  //   //   print("------------------");
  //   // }
  // }

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
}
