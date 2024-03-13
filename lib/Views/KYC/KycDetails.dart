import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class kyc_details1 extends StatefulWidget {
  const kyc_details1({Key? key}) : super(key: key);

  @override
  _kyc_details1State createState() => _kyc_details1State();
}

class _kyc_details1State extends State<kyc_details1> {
  bool _loading = true;
  bool pan = false;
  bool GST = false;

  String image1 = "";
  String image2 = "";
  String PanStatus = "";
  String GstStatus = "";
  late File image_path1;
  late File image_path2;

  @override
  void initState() {
    super.initState();
    GetKyc();

    // getDropdownValues();

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
        title: Text("KYC Details"),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    title("PAN DOCUMENT"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                        child: image1 != ""
                            ? SizedBox()
                            : Text("Upload Your PAN Document"),
                      ),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: pan == true
                              ? DecorationImage(image: FileImage(image_path1))
                              : DecorationImage(image: NetworkImage(image1)),
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _loading = true;
                            });
                            filepick1();
                            pan = true;
                          },
                          child: Text('Choose file'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    title("GST DOCUMENT"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                        child: image2 != ""
                            ? SizedBox()
                            : Text("Upload Your GST Document"),
                      ),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: GST == true
                              ? DecorationImage(image: FileImage(image_path2))
                              : DecorationImage(image: NetworkImage(image2)),
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _loading = true;
                            });
                            filepick2();
                            GST = true;
                          },
                          child: Text('Choose file'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Padding btn() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10),
  //     child: FlatButton(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         color: primaryColor,
  //         onPressed: () {
  //           UpdateKYC();
  //           setState(() {
  //             _loading = true;
  //           });
  //         },
  //         child: Container(
  //           child: Center(
  //             child: Text("Update",
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w600)),
  //           ),
  //           height: 50,
  //           width: 200,
  //         )),
  //   );
  // }

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
//---------------------------------API----------------------------------------//
  void GetKyc() {
    Service.GetKYC().then((result) {
      setState(() {
        image1 = result["results"]["pan_document"];
        image2 = result["results"]["gst_document"];

        _loading = false;
      });
      print(result);
    });
  }

  void UpdateKYC(image_path, id) {
    Service.UpdateKYC(image_path, id).then((result) {
      GetKyc();
      setState(() {
        _loading = false;
      });
      print(result);
    });
  }

  filepick1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        image_path1 = File(result.files.single.path!);
        UpdateKYC(image_path1, "1");
      });
    }
  }

  filepick2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        image_path2 = File(result.files.single.path!);
        UpdateKYC(image_path2, "2");
      });
    }
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }
}
