import 'package:flutter/material.dart';
import 'package:jini_vendor/Config/Constants.dart';

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                row("Reference No", widget.refNo == null ? "" : widget.refNo),
                row("Post Name", widget.name),
                row("Post Type", widget.type),
                row("Delivery Status",
                    widget.Delstatus == null ? "" : widget.Delstatus),
                row("Delivery Charge",
                    widget.Delcharge == null ? "" : widget.Delcharge),
                row("Total Charge", widget.TotalCharge),
                row("Posted Date", widget.PostedDate.substring(0, 10)),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Padding row(Heading, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Heading + " : ",
            style: TextStyle(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.blueGrey[700],
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class Details extends StatefulWidget {
  String refNo = "";
  String name = "";
  String type = "";
  String Delstatus = "";
  String Delcharge = "";
  String TotalCharge = "";
  String PostedDate = "";
  Details(
      {required this.refNo,
      required this.name,
      required this.Delstatus,
      required this.Delcharge,
      required this.TotalCharge,
      required this.PostedDate,
      required this.type});

  @override
  _DetailsState createState() => _DetailsState();
}
