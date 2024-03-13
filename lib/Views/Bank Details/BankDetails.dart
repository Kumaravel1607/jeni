import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jini_vendor/Config/Constants.dart';
import 'package:jini_vendor/Controllers/Service.dart';
import 'package:jini_vendor/Models/BankDetails.dart';
import 'package:jini_vendor/Views/Bank%20Details/BankDetailsAdd.dart';
import 'package:jini_vendor/Views/Bank%20Details/EditBank.dart';

class Bankdetails extends StatefulWidget {
  Bankdetails({Key? key}) : super(key: key);

  @override
  _BankdetailsState createState() => _BankdetailsState();
}

class _BankdetailsState extends State<Bankdetails> {
  bool select = false;
  bool loading = true;
  List<BankDetails> bankDetail = [];
  @override
  void initState() {
    // TODO: implement initState
    GetBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Details"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Center(
          child: Icon(Icons.add),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BankAdd()));
        },
      ),
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          setState(() {
            loading = true;
          });
          GetBank();
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
                itemCount: bankDetail.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        _alerBox(
                            bankDetail[index].bankName,
                            bankDetail[index].accountName,
                            bankDetail[index].accountNumber,
                            bankDetail[index].branch,
                            bankDetail[index].bankCode);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 20,
                        child: Container(
                          height: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child:
                                        Image.asset("assets/images/bank.png"),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Bank Name",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(": " +
                                                  bankDetail[index].bankName),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Acc Name",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(": " +
                                                  bankDetail[index]
                                                      .accountName),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Branch",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(": " +
                                                  bankDetail[index].branch),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => BankEdit(
                                                              id: bankDetail[index]
                                                                  .id,
                                                              bank: bankDetail[
                                                                      index]
                                                                  .bankName,
                                                              accnumber: bankDetail[
                                                                      index]
                                                                  .accountNumber,
                                                              branch:
                                                                  bankDetail[
                                                                          index]
                                                                      .branch,
                                                              ifsc: bankDetail[
                                                                      index]
                                                                  .bankCode,
                                                              accname: bankDetail[
                                                                      index]
                                                                  .accountName)));
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.blueGrey[700],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              GestureDetector(
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
                                                                  loading =
                                                                      true;
                                                                });
                                                                deleteBank(
                                                                    bankDetail[
                                                                            index]
                                                                        .id);
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
                                                  color: Colors.blueGrey[700],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 15),
                                  child: Column(
                                    children: [
                                      FlutterSwitch(
                                        height: 20.0,
                                        width: 40.0,
                                        padding: 4.0,
                                        toggleSize: 15.0,
                                        borderRadius: 10.0,
                                        activeColor: primaryColor,
                                        value:
                                            bankDetail[index].primaryAcc == "1"
                                                ? select = true
                                                : select = false,
                                        onToggle: (value) {
                                          setState(() {
                                            select = value;
                                            select == true
                                                ? bankDetail[index].primaryAcc =
                                                    "1"
                                                : bankDetail[index].primaryAcc =
                                                    "0";

                                            primaryAcc(bankDetail[index].id);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
  //--------------------------------------API--------------------------

  GetBank() {
    Service.GetBankDetails().then((result) {
      setState(() {
        bankDetail = result;
        loading = false;
      });
    });
  }

  deleteBank(id) {
    Service.DeleteBank(id).then((result) {
      GetBank();
      setState(() {
        loading = false;
      });
    });
  }

  primaryAcc(id) {
    setState(() {
      loading = true;
    });
    print(id);
    Service.primaryBank(id).then((result) {
      GetBank();
      print(result);
    });
  }

  Future<void> _alerBox(bank, name, acc, branch, ifsc) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text("Details"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BANK" + " : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        bank,
                        style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NAME" + " : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ACC.No" + " : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        acc,
                        style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BRANCH" + " : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        branch,
                        style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "IFSC" + " : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        ifsc,
                        style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
