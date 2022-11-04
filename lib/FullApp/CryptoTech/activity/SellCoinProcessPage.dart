//SellCoinDetailPage

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ease_in_widget.dart';

class SellCoinProcessPage extends StatefulWidget {
  int _radioValue1 = -1;
  double coinprice = 0;
  String cointype, image;

  SellCoinProcessPage(this._radioValue1, this.coinprice, this.cointype, this.image);

  @override
  State<StatefulWidget> createState() {
    return new SellCoinProcessPageState(this._radioValue1, this.coinprice, this.cointype, this.image);
  }
}

class SellCoinProcessPageState extends State<SellCoinProcessPage> {
  Color btntextcolor = ColorsRes.firstgradientcolor;

  TextEditingController edtusd = TextEditingController();
  TextEditingController edtnaira = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double minsell = 10;

  int _radioValue1 = -1;
  double coinprice = 0;
  String cointype, image;
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SellCoinProcessPageState(this._radioValue1, this.coinprice, this.cointype, this.image);

  void SetNairaAmt() {
    double maincoin = 000000.0;
    if (edtusd.text != null && edtusd.text.toString().trim().length != 0) {
      maincoin = coinprice * double.parse(edtusd.text);
    }
    edtnaira.text = maincoin.toString();
  }

  @override
  void initState() {
    super.initState();
    SetNairaAmt();
  }

  @override
  Widget build(BuildContext context) {
    double toppadding = (2 * kToolbarHeight) - MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: DesignConfig.gradient,
            ),
            padding: EdgeInsets.only(top: toppadding, left: 20, right: 20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: CachedNetworkImage(
                      imageUrl: image,
                      height: MediaQuery.of(context).size.width / 8,
                    )),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "1\$ = $coinprice",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Center(
                      child: Text(
                        cointype,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorsRes.appcolor),
                      ),
                      child: Center(
                        child: IntrinsicWidth(
                          child: TextFormField(
                            style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                            cursorColor: ColorsRes.white,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixText: '\$',
                              prefixStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              hintText: '\$ 000000.00',
                              hintStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.bold, color: ColorsRes.white.withOpacity(0.5))),
                            ),
                            controller: edtusd,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            onChanged: (String enteredcoin) {
                              SetNairaAmt();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsRes.appcolor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorsRes.appcolor),
                      ),
                      child: Center(
                        child: IntrinsicWidth(
                          child: TextFormField(
                            style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                            cursorColor: ColorsRes.white,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${Constant.CURRENCYSYMBOL} 000000.00',
                              prefixText: '${Constant.CURRENCYSYMBOL}',
                              prefixStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              hintStyle: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.bold, color: ColorsRes.white.withOpacity(0.5))),
                            ),
                            controller: edtnaira,
                            enabled: false,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 5, end: 5.0),
                          child: Icon(
                            Icons.check_circle,
                            color: ColorsRes.white,
                            size: 17,
                          ),
                        ),
                        Text(
                          "${Constant.USCURRENCYSYMBOL}$minsell\t",
                          style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w500),
                        ),
                        Flexible(
                            child: Text(
                          "${StringsRes.minsellinfo}",
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.white.withOpacity(0.5))),
                        )),
                      ],
                    ),
                    SizedBox(height: 25),
                    _radioValue1 == 1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: 5.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: ColorsRes.white,
                                    size: 17,
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                  StringsRes.paxfulsellinfo,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.white.withOpacity(0.5))),
                                )),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: 25),
                    isLoading
                        ? new CircularProgressIndicator(
                            backgroundColor: ColorsRes.white,
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: EaseInWidget(
                          onTap: () async {
                            if (!isLoading) {
                              if (_radioValue1 == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Coin Type")));
                              } else if (edtusd.text.toString().trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter $cointype Sell Amount")));
                              } else if (double.parse(edtusd.text) < minsell) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Minimum ${Constant.USCURRENCYSYMBOL}$minsell Trade Amount is accepted")));
                              } else {
                                //post resquest

                                /*  
                                  //if post request response status is pending
                                 if (status.toLowerCase() ==
                                        StringsRes.pending.toLowerCase()) {
                                      if (type.toLowerCase() ==
                                              StringsRes.perfectmoney
                                                  .toLowerCase() ||
                                          type.toLowerCase() ==
                                              StringsRes.paxfulbitcoin
                                                  .toLowerCase()) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SellWebviewActivity(
                                                        qr_code, type)));
                                      } else {
                                        Transaction trade =
                                            Transaction.fromTradeJson(
                                                res[Constant.PAYMENT_DATA]);
                                        selectedtrade = trade;
                                        trade.crypto_amount = edtusd.text;
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QRDetailActivity()));
                                      }
                                      */
                              }
                            }
                          },
                          child: CachedNetworkImage(
                            imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/okay.png',
                            height: MediaQuery.of(context).size.width / 8,
                            color: ColorsRes.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IntrinsicHeight(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/close_button.png'),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
