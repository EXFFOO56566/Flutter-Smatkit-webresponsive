import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';

TextStyle textStyle;

class RateCalculatorActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double toppadding = kToolbarHeight + 40;
    return Scaffold(
      backgroundColor: ColorsRes.bgcolor,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: DesignConfig.gradient,
            ),
            padding: EdgeInsets.only(
              top: toppadding,
            ),
            child: RateCalculatorForm(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IntrinsicHeight(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  StringsRes.ratecalc,
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                ),
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/back_button.png'),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RateCalculatorForm extends StatefulWidget {
  @override
  RateCalculatorFormState createState() {
    return RateCalculatorFormState();
  }
}

class RateCalculatorFormState extends State<RateCalculatorForm> {
  bool isLoading = false, isdialogloading = false;
  TextEditingController edtusd = TextEditingController();
  TextEditingController edtnaira = TextEditingController();
  int _radioValue1 = -1;
  String cointype, message = "";
  bool ispm = true, ispaxbit = true, isbtc = true, iseth = true, isltc = true, isusdt = true, isbank = true, isltct = true;

  double coinprice = 0;
  List<Rate> ratelist;
  int selectedindex = 0;
  Rate selectedrate;

  @override
  void initState() {
    ratelist = [];
    SetWidgetVisibility();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double nairaamt = edtnaira.text == null || edtnaira.text.trim().isEmpty ? 0 : double.parse(edtnaira.text ?? 0);

    return message.trim().isNotEmpty
        ? Center(
            child: Text(
            "\t\t$message\t\t",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ColorsRes.white),
          ))
        : Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(Constant.CURRENCYNAME, style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                            )),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text("${Constant.CURRENCYSYMBOL} $nairaamt", style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold))),
                            )),
                        Container(
                          decoration: DesignConfig.BoxDecorationBorderContainer(ColorsRes.white.withOpacity(0.5), 15),
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 40),
                          padding: EdgeInsets.only(top: 15, left: 18, bottom: 15, right: 18),
                          child: Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      controller: edtusd,
                                      style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                      cursorColor: ColorsRes.white,
                                      decoration: InputDecoration(isDense: true, hintText: "Enter Amount", hintStyle: TextStyle(color: ColorsRes.white.withOpacity(0.5)), border: InputBorder.none),
                                      onChanged: (String enteredcoin) {
                                        SetNairaAmt();
                                      },
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: ColorsRes.white,
                                    endIndent: 10,
                                    indent: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("${selectedrate.name}",
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                                              color: ColorsRes.white,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.4655,
                                            ))),
                                  )
                                ]),
                              ),
                              Divider(
                                color: ColorsRes.white.withOpacity(0.5),
                                endIndent: 10,
                                indent: 10,
                                thickness: 1,
                              ),
                              IntrinsicHeight(
                                child: Row(children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      controller: edtnaira,
                                      enabled: false,
                                      style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                      cursorColor: ColorsRes.white,
                                      decoration: InputDecoration(isDense: true, hintText: "000000.00", hintStyle: TextStyle(color: ColorsRes.white.withOpacity(0.5)), border: InputBorder.none),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: ColorsRes.white,
                                    endIndent: 10,
                                    indent: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("${StringsRes.naira}",
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                                              color: ColorsRes.white,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.4655,
                                            ))),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(15))),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: ListView(
                      children: List.generate(
                    ratelist.length,
                    (index) {
                      Rate item = ratelist[index];
                      return RadioListTile(
                        dense: true,
                        secondary: CachedNetworkImage(
                          imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/${item.image}.png',
                          height: MediaQuery.of(context).size.width / 12,
                          color: item.color,
                        ),
                        groupValue: selectedindex,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(item.name),
                        value: item.index,
                        onChanged: (val) {
                          setState(() {
                            selectedindex = item.index;
                            selectedrate = item;

                            coinprice = item.rate;
                            SetNairaAmt();
                          });
                        },
                      );
                    },
                  )),
                ),
              ),
            ],
          );
  }

  void SetWidgetVisibility() {
    ratelist.clear();

    ratelist.add(new Rate(1, StringsRes.paxfulbitcoin, 50, "paxful", ColorsRes.cardyellow));

    ratelist.add(new Rate(2, StringsRes.perfectmoney, 60, "pm", ColorsRes.cardpurple));

    ratelist.add(new Rate(3, StringsRes.btc, 70, "btc", ColorsRes.cardblue));

    ratelist.add(new Rate(4, StringsRes.eth, 80, "eth", ColorsRes.cardgreen));

    ratelist.add(new Rate(5, StringsRes.ltct, 90, "dollersymbol", ColorsRes.cardpich));

    ratelist.add(new Rate(6, StringsRes.usdt, 100, "usdt", ColorsRes.cardpink));

    ratelist.add(new Rate(7, StringsRes.usdt, 40, "ltc", ColorsRes.cardbrown));

    if (ratelist.length != 0) {
      setState(() {
        selectedrate = ratelist[0];
        selectedindex = selectedrate.index;
      });
    }
  }

  void SetNairaAmt() {
    double maincoin = 000000.0;
    if (edtusd.text != null && edtusd.text.toString().trim().length != 0) {
      maincoin = coinprice * double.parse(edtusd.text);
    }
    edtnaira.text = maincoin.toString();
    setState(() {});
  }
}

class Rate {
  const Rate(this.index, this.name, this.rate, this.image, this.color);

  final int index;
  final String name;
  final String image;
  final double rate;
  final Color color;

  @override
  String toString() {
    return name;
  }
}
