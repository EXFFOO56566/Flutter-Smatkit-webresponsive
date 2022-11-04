import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/MainActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ImageSlider.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/UIData.dart';
import 'package:smartkit/FullApp/CryptoTech/model/Transaction.dart';
import 'package:smartkit/SmartkitScreen/Screen/SmartKitHome.dart';

import 'HistoryActivity.dart';
import 'NotificationActivity.dart';
import 'SellActivity.dart';
import 'SellCoinProcessPage.dart';
import 'TradeDetail.dart';
import 'TransactionDetail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int msgcount = 2;
  double leftrightpadding = 20;
  bool ispm = true, ispaxbit = true, isbtc = true, iseth = true, isltct = true, isltc = true, isusdt = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ));
        },
        child: Scaffold(body: homePageContent()));
  }

  Widget homePageContent() {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: new BorderRadius.only(
                    bottomRight: const Radius.circular(30),
                    bottomLeft: const Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                      /* stops: [1, 0],
                      end: Alignment(-0.00, -1.00),
                      begin: Alignment(0.00, 1.00), */
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [ColorsRes.secondgradientcolor, ColorsRes.firstgradientcolor])),
              margin: EdgeInsets.only(bottom: 25),
              padding: EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: GestureDetector(
                        onTap: () {
                          scafolldmain.currentState.openDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 14, bottom: 14, right: 14),
                          child: CachedNetworkImage(
                            imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/drawer_button.png',
                          ),
                        )),
                    actions: [
                      GestureDetector(
                        child: new Stack(children: <Widget>[
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CachedNetworkImage(
                              imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/notification_button.png',
                              height: MediaQuery.of(context).size.width / 12,
                            ),
                          )),
                          msgcount == 0
                              ? Container()
                              : new Positioned(
                                  // draw a red marble
                                  top: 0.0,
                                  right: 3.0,
                                  bottom: 20,

                                  child: Container(
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorsRes.red),
                                      child: new Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(msgcount.toString().length == 1 ? 6 : 3),
                                          child: new Text(
                                            msgcount.toString(),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      )),
                                ),
                        ]),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationActivity()));
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
                    child: Row(children: [
                      Card(
                        shape: DesignConfig.SetRoundedBorder(ColorsRes.appcolor, 10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Constant.ImageWidget(UIData.userimage, 60, 60),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(greeting(),
                              style: Theme.of(context).textTheme.button.merge(TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsRes.white,
                                  ))),
                          Text(UIData.username,
                              style: Theme.of(context).textTheme.headline6.merge(TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsRes.white,
                                  ))),
                        ]),
                      )
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("\t\t${StringsRes.walletbalance}", style: TextStyle(color: ColorsRes.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Text("\t\t${Constant.CURRENCYSYMBOL}", style: TextStyle(color: ColorsRes.white.withOpacity(0.7), fontWeight: FontWeight.w600)),
                                    Text("\t${UIData.walletbalance}", style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("\t\t${StringsRes.bankingbalance}", style: TextStyle(color: ColorsRes.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Text("\t\t${Constant.CURRENCYSYMBOL}", style: TextStyle(color: ColorsRes.white.withOpacity(0.7), fontWeight: FontWeight.w600)),
                                    Text("\t${UIData.bankbalance}", style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  shape: DesignConfig.SetRoundedBorder(Colors.white, 10),
                  color: ColorsRes.white,
                  margin: EdgeInsets.only(left: leftrightpadding, right: leftrightpadding),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellActivity(1, -1)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/buycoins.png", height: MediaQuery.of(context).size.width / 16),
                                SizedBox(width: 10),
                                Text(
                                  StringsRes.buycoin,
                                  style: TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellActivity(0, -1)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/sellcoins.png",
                                  height: MediaQuery.of(context).size.width / 16,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${StringsRes.sellcoin}",
                                  style: TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: leftrightpadding, left: leftrightpadding, top: 10),
          child: ImageSliderWidget(
            from: "main",
            imageUrls: UIData.sliderimglist,
            imageBorderRadius: BorderRadius.circular(15),
            imageHeight: 180.0,
            isfeatured: false,
          ),
        ),
        setCoinWidgetData(),
        ScreenTypeLayout(
          mobile: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: leftrightpadding, right: leftrightpadding),
                child: Row(children: <Widget>[
                  Text(
                    StringsRes.recent_transaction,
                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                          color: ColorsRes.hometitlecolor,
                          fontWeight: FontWeight.w600,
                        )),
                  ), // Defaults to a flex of one.
                  GestureDetector(
                    child: Text("${StringsRes.lblmore}",
                        style: TextStyle(
                          color: ColorsRes.viewallcolor,
                          fontWeight: FontWeight.w300,
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryActivity(0)));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: leftrightpadding, right: leftrightpadding),
                child: transactionListWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: leftrightpadding, right: leftrightpadding),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      StringsRes.tradehistory,
                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                            color: ColorsRes.hometitlecolor,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  GestureDetector(
                    child: Text("${StringsRes.lblmore}",
                        style: TextStyle(
                          color: ColorsRes.viewallcolor,
                          fontWeight: FontWeight.w300,
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryActivity(1)));
                    },
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: leftrightpadding, right: leftrightpadding),
                child: tradeListWidget(),
              ),
            ],
          ),
          desktop: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                // height: MediaQuery.of(context).size.width / 2,
                // color: Colors.amber,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: leftrightpadding, right: leftrightpadding),
                      child: Row(children: <Widget>[
                        Text(
                          StringsRes.recent_transaction,
                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                                color: ColorsRes.hometitlecolor,
                                fontWeight: FontWeight.w600,
                              )),
                        ), // Defaults to a flex of one.
                        GestureDetector(
                          child: Text("${StringsRes.lblmore}",
                              style: TextStyle(
                                color: ColorsRes.viewallcolor,
                                fontWeight: FontWeight.w300,
                              )),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryActivity(0)));
                          },
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: leftrightpadding, right: leftrightpadding),
                      child: transactionListWidget(),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: leftrightpadding, right: leftrightpadding),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              StringsRes.tradehistory,
                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                                    color: ColorsRes.hometitlecolor,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            child: Text("${StringsRes.lblmore}",
                                style: TextStyle(
                                  color: ColorsRes.viewallcolor,
                                  fontWeight: FontWeight.w300,
                                )),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryActivity(1)));
                            },
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: leftrightpadding, right: leftrightpadding),
                        child: tradeListWidget(),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ]),
    );
  }

  Widget transactionListWidget() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: ColorsRes.grey,
              endIndent: 3,
              indent: 3,
              thickness: 0.8,
              height: 0,
            ),
        padding: const EdgeInsets.only(bottom: 8),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: maintransactionlist.length > 5 ? 5 : maintransactionlist.length,
        itemBuilder: (BuildContext context, int index) {
          Transaction transaction = maintransactionlist[index];

          return GestureDetector(
              child: Card(
                shape: DesignConfig.SetRoundedBorder(ColorsRes.white, 5),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Constant.setFirstLetterUppercase(transaction.status), style: Theme.of(context).textTheme.caption.merge(TextStyle(fontWeight: FontWeight.bold, color: Constant.StatusColor(transaction.status)))),
                      Text(
                        "${Constant.USCURRENCYSYMBOL}${transaction.amount}\t\t",
                        style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.appcolor, fontWeight: FontWeight.w700)),
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(
                            "${Constant.SetStatuswithSplit(transaction.type).trim()}",
                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey.withOpacity(0.6), fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Text(
                          "${Constant.DisplayDateTimeyearText(transaction.created_on)}",
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey.withOpacity(0.6), fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              onTap: () {
                selectedtransaction = transaction;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionDetail("main")));
              });
        });
  }

  Widget tradeListWidget() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: ColorsRes.grey,
              endIndent: 3,
              indent: 3,
              thickness: 0.8,
              height: 0,
            ),
        padding: const EdgeInsets.only(bottom: 8),
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: maintradelist.length > 5 ? 5 : maintradelist.length,
        itemBuilder: (BuildContext context, int index) {
          Transaction transaction = maintradelist[index];
          return GestureDetector(
              child: Card(
                shape: DesignConfig.SetRoundedBorder(ColorsRes.white, 5),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${Constant.setFirstLetterUppercase(transaction.crypto_currency_type)}",
                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.green, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${Constant.CURRENCYSYMBOL}${transaction.naira_amount}", style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.appcolor, fontWeight: FontWeight.w700))),
                          Text(
                            "${Constant.USCURRENCYSYMBOL}${transaction.dollar_amount}",
                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.appcolor, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(
                            Constant.setFirstLetterUppercase(transaction.status),
                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey.withOpacity(0.6), fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Text(
                          "${Constant.DisplayDateTimeyearText(transaction.created_on)}",
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey.withOpacity(0.6), fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              onTap: () {
                selectedtrade = transaction;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TradeDetail("main")));
              });
        });
  }

  Widget setCoinWidgetData() {
    double boxwidth = 210;
    return Container(
      padding: EdgeInsets.only(left: leftrightpadding, top: 10),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            Expanded(
                child: Text(
              StringsRes.sellcoin,
              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.hometitlecolor, fontWeight: FontWeight.bold)),
            )),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellActivity(0, -1)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    StringsRes.lblmore,
                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: ColorsRes.viewallcolor)),
                  ),
                )),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 90.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ispm
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(0, 10, Constant.perfectmoney, 'https://smartkit.wrteam.in/smartkit/cryptotech/pm.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardyellow, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1\$ = ${Constant.CURRENCYSYMBOL}50",
                                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 1),
                                new Text(
                                  "${StringsRes.perfectmoney}",
                                  style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            CachedNetworkImage(
                              imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/pm.png',
                              height: MediaQuery.of(context).size.width / 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              ispaxbit
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(1, 70, Constant.paxfulbitcoin, 'https://smartkit.wrteam.in/smartkit/cryptotech/paxful.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardpurple, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1\$ = ${Constant.CURRENCYSYMBOL}10",
                                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 1),
                                new Text(
                                  "${StringsRes.paxfulbitcoin}",
                                  style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            CachedNetworkImage(
                              imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/paxful.png',
                              height: MediaQuery.of(context).size.width / 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              isbtc
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(2, 20, Constant.btc, 'https://smartkit.wrteam.in/smartkit/cryptotech/btc.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardblue, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              "1\$ = ${Constant.CURRENCYSYMBOL}15",
                              style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "${StringsRes.btc}",
                              style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                            ),
                          ])),
                          SizedBox(
                            width: 10,
                          ),
                          CachedNetworkImage(
                            imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/btc.png',
                            height: MediaQuery.of(context).size.width / 8,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ]),
                      ),
                    )
                  : Container(),
              iseth
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(3, 30, Constant.eth, 'https://smartkit.wrteam.in/smartkit/cryptotech/eth.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardgreen, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1\$ = ${Constant.CURRENCYSYMBOL}100",
                                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 1),
                                new Text(
                                  "${StringsRes.eth}",
                                  style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            CachedNetworkImage(
                              imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/eth.png',
                              height: MediaQuery.of(context).size.width / 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              isltct
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(4, 40, Constant.ltct, 'https://smartkit.wrteam.in/smartkit/cryptotech/dollersymbol.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardpich, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(children: <Widget>[
                          SizedBox(width: 15),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1\$ = ${Constant.CURRENCYSYMBOL}150",
                                style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: 1),
                              new Text(
                                "${StringsRes.ltct}",
                                style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          CachedNetworkImage(
                            imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/dollersymbol.png',
                            height: MediaQuery.of(context).size.width / 8,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ]),
                      ),
                    )
                  : Container(),
              isltc
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(5, 50, Constant.ltc, 'https://smartkit.wrteam.in/smartkit/cryptotech/ltc.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardpink, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1\$ = ${Constant.CURRENCYSYMBOL}10",
                                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 1),
                                new Text(
                                  "${StringsRes.ltc}",
                                  style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            CachedNetworkImage(
                              imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/ltc.png',
                              height: MediaQuery.of(context).size.width / 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              isusdt
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellCoinProcessPage(6, 60, Constant.usdt, 'https://smartkit.wrteam.in/smartkit/cryptotech/usdt.png')));
                      },
                      child: Container(
                        decoration: DesignConfig.BoxDecorationContainerSide(ColorsRes.cardbrown, 15, false, false, true, true),
                        margin: EdgeInsets.only(right: 20),
                        width: boxwidth,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1\$ = ${Constant.CURRENCYSYMBOL}80",
                                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 1),
                                new Text(
                                  "${StringsRes.usdt}",
                                  style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            CachedNetworkImage(
                              imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/usdt.png',
                              height: MediaQuery.of(context).size.width / 8,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ]),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return StringsRes.goodmorning;
    } else if (hour < 17) {
      return StringsRes.goodafternoon;
    } else if (hour < 21) {
      return StringsRes.goodevening;
    } else
      return StringsRes.goodnight;
  }
}
