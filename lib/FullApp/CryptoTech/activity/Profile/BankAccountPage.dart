import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/searchable_dropdown.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/UIData.dart';
import 'package:smartkit/FullApp/CryptoTech/model/Bank.dart';

class BankAccountPage extends StatefulWidget {
  @override
  BankAccountPageState createState() {
    return BankAccountPageState();
  }
}

class BankAccountPageState extends State<BankAccountPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false, isdialogloading = false;
  TextEditingController edtacname = TextEditingController();
  TextEditingController edtacno = TextEditingController();
  TextStyle textStyle;
  List<Bank> banklist;
  bool isbankavailable = false, isgettingdata = true;
  Bank selectedbank;

  @override
  void initState() {
    banklist = [];
    banklist = UIData.getBankList();
    selectedbank = banklist[0];

    edtacname.text = UIData.username;

    edtacno.text = "123456789";
  }

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.subtitle2.merge(TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorsRes.black,
        ));

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 25, top: kToolbarHeight),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CachedNetworkImage(
                      imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/close_button.png',
                      height: MediaQuery.of(context).size.width / 12,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text("${StringsRes.bankname}: ", style: textStyle),
                ),
                Card(
                  shape: DesignConfig.SetRoundedBorder(ColorsRes.appcolor, 8),
                  margin: EdgeInsets.only(bottom: 10, top: 5, left: 20),
                  child: SearchableDropdown<Bank>(
                    isCaseSensitiveSearch: false,
                    isExpanded: true,
                    value: selectedbank,
                    onChanged: (Bank newValue) {
                      setState(() {
                        if (selectedbank.id != newValue.id) {
                          selectedbank = newValue;
                        }
                      });
                    },
                    items: banklist.map((Bank value) {
                      return DropdownMenuItem<Bank>(
                        value: value,
                        child: Text("\t\t${value.name}", style: TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text("${StringsRes.accountname}", style: textStyle),
                ),
                Card(
                  margin: EdgeInsets.only(bottom: 10, top: 5, left: 20),
                  shape: DesignConfig.SetRoundedBorder(ColorsRes.grey, 8),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      style: TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold),
                      cursorColor: ColorsRes.appcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hoverColor: ColorsRes.appcolor,
                        fillColor: ColorsRes.white,
                        focusColor: ColorsRes.white,
                      ),
                      validator: (val) => val.trim().isEmpty ? StringsRes.enteracname : null,
                      controller: edtacname,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text("${StringsRes.accountno}", style: textStyle),
                ),
                Card(
                  margin: EdgeInsets.only(bottom: 10, top: 5, left: 20),
                  shape: DesignConfig.SetRoundedBorder(ColorsRes.grey, 8),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      style: TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold),
                      cursorColor: ColorsRes.appcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hoverColor: ColorsRes.appcolor,
                        fillColor: ColorsRes.white,
                        focusColor: ColorsRes.white,
                      ),
                      validator: (val) => val.trim().isEmpty ? StringsRes.enteracno : null,
                      controller: edtacno,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Center(
                  child: isLoading
                      ? new CircularProgressIndicator(
                          backgroundColor: ColorsRes.secondgradientcolor,
                        )
                      : Container(),
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    margin: EdgeInsets.all(30),
                    decoration: DesignConfig.circulargradient_box,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Center(
                      child: Text(
                        StringsRes.update,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorsRes.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
