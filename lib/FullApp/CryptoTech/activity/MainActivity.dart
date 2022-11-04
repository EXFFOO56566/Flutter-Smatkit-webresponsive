import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/AirTimeRecharge/PhoneNumberScreen.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/BankingActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/Gift/GiftItemPageActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/HistoryActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/HomePage.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/KYCLevels/KYCInfoDialog.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/KYCLevels/KYCApplicationActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/NotificationActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/PublicPayment/UsernameForPayment.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/RateCalculator.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/ReferalListActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/ReferpageActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/SellActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/SetTransactionPinActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/SupportTicket/SupportTicketListActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/HallOfFame/HallOfFameUserList.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/TermsConditionActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/WithdrawActivity.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/UIData.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/new_dialog.dart';
import 'package:smartkit/FullApp/CryptoTech/model/NotificationData.dart';
import 'package:smartkit/FullApp/CryptoTech/model/Transaction.dart';
import 'package:smartkit/SmartkitScreen/Screen/SmartKitHome.dart';
import 'Profile/ProfileActivity.dart';
import 'package:flutter/services.dart';

Transaction selectedtransaction, selectedtrade;

StreamController<String> countstream;
List<NotificationData> unreadnotificaitonlist;
List<String> unreadnotificaitonids;

//
GlobalKey<ScaffoldState> scafolldmain;
List<Transaction> maintransactionlist;
List<Transaction> maintradelist;

class MainActivity extends StatefulWidget {
  String from;
  int selectedPostion;
  MainActivity(this.from, this.selectedPostion);

  @override
  MainActivityState createState() => new MainActivityState(this.from);
}

class MainActivityState extends State<MainActivity> {
  String from;

  int selectedPos;

  Color homeStatusbarcolor = ColorsRes.statusbarcolor;

  MainActivityState(this.from);

  @override
  void initState() {
    super.initState();

    maintransactionlist = [];
    maintradelist = [];

    maintransactionlist = UIData.getTransactionList();
    maintradelist = UIData.getTradeList();

    scafolldmain = GlobalKey<ScaffoldState>();

    unreadnotificaitonlist = [];
    unreadnotificaitonids = [];
    setState(() {
      selectedPos = widget.selectedPostion;
    });
    if (from == "kyc") {
      new Future.delayed(Duration.zero, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => KYCApplicationActivity()));
      });
    }
    // else {
    //   new Future.delayed(Duration.zero, () {
    //     OpenRateUsDialog();
    //   });
    // }
  }

  @override
  void dispose() {
    if (countstream != null) countstream.sink.close();
    super.dispose();
  }

  currentPagePosition(int position) {
    if (position == 0 || position == 3)
      homeStatusbarcolor = ColorsRes.statusbarcolor;
    else
      homeStatusbarcolor = ColorsRes.bgcolor;
    setState(() {
      selectedPos = position;
    });
  }

  Widget setBottomNavigation(int pos, BuildContext bcontext) {
    return new BottomAppBar(
      child: ScreenTypeLayout(
        mobile: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(color: ColorsRes.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            GestureDetector(
                onTap: () {
                  if (pos != 0) currentPagePosition(0);
                },
                child: CachedNetworkImage(
                  imageUrl: pos == 0 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedhome.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/home.png',
                  height: pos == 0 ? MediaQuery.of(context).size.width / 8 : MediaQuery.of(context).size.width / 14,
                )),
            GestureDetector(
                onTap: () {
                  if (pos != 1) currentPagePosition(1);
                },
                child: CachedNetworkImage(
                    imageUrl: pos == 1 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedsell.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/sell.png',
                    height: pos == 1 ? MediaQuery.of(context).size.width / 8 : MediaQuery.of(context).size.width / 14)),
            GestureDetector(
                onTap: () {
                  if (pos != 2) currentPagePosition(2);
                },
                child: CachedNetworkImage(
                    imageUrl: pos == 2 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedhistory.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/history.png',
                    height: pos == 2 ? MediaQuery.of(context).size.width / 8 : MediaQuery.of(context).size.width / 14)),
            GestureDetector(
                onTap: () {
                  if (pos != 3) currentPagePosition(3);
                },
                child: CachedNetworkImage(
                    imageUrl: pos == 3 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedprofile.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/profile.png',
                    height: pos == 3 ? MediaQuery.of(context).size.width / 8 : MediaQuery.of(context).size.width / 14)),
          ]),
        ),
        desktop: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(color: ColorsRes.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
            GestureDetector(
                onTap: () {
                  if (pos != 0) currentPagePosition(0);
                },
                child: CachedNetworkImage(
                  imageUrl: pos == 0 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedhome.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/home.png',
                  height: pos == 0 ? MediaQuery.of(context).size.width / 40 : MediaQuery.of(context).size.width / 40,
                )),
            GestureDetector(
                onTap: () {
                  if (pos != 1) currentPagePosition(1);
                },
                child: CachedNetworkImage(
                    imageUrl: pos == 1 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedsell.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/sell.png',
                    height: pos == 1 ? MediaQuery.of(context).size.width / 40 : MediaQuery.of(context).size.width / 40)),
            GestureDetector(
                onTap: () {
                  if (pos != 2) currentPagePosition(2);
                },
                child: CachedNetworkImage(
                    imageUrl: pos == 2 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedhistory.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/history.png',
                    height: pos == 2 ? MediaQuery.of(context).size.width / 40 : MediaQuery.of(context).size.width / 40)),
            GestureDetector(
                onTap: () {
                  if (pos != 3) currentPagePosition(3);
                },
                child: CachedNetworkImage(
                    imageUrl: pos == 3 ? 'https://smartkit.wrteam.in/smartkit/cryptotech/selectedprofile.png' : 'https://smartkit.wrteam.in/smartkit/cryptotech/profile.png',
                    height: pos == 3 ? MediaQuery.of(context).size.width / 40 : MediaQuery.of(context).size.width / 40)),
          ]),
        ),
      ),
    );
  }

  Widget bodyContainer() {
    if (selectedPos == 0) {
      //DesignConfig.SetStatusbarColor(ColorsRes.secondgradientcolor);
      return new HomePage();
    } else if (selectedPos == 1) {
      //DesignConfig.SetStatusbarColor(ColorsRes.bgcolor);
      return new SellActivity(0, -1);
    } else if (selectedPos == 2) {
      return new HistoryActivity(0);
    } else if (selectedPos == 3) {
      return new ProfileActivity();
    } else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: homeStatusbarcolor,
      ),
      child: WillPopScope(
        onWillPop: () {
          return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (Route<dynamic> route) => false);

          //
        },
        child: Scaffold(
          key: scafolldmain,
          bottomNavigationBar: setBottomNavigation(selectedPos, context),
          drawer: new Drawer(
            child: drawerData(),
          ),
          body: bodyContainer(),
        ),
      ),
    );
  }

  Widget drawerData() {
    var width = MediaQuery.of(context).size.width / 8;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: DesignConfig.gradient,
          ),
          padding: const EdgeInsets.only(top: 50, bottom: 15),
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                child: ClipOval(
                  child: Constant.ImageWidget(UIData.userimage, 81, 81),
                ),
                width: 85,
                height: 85,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    border: Border.all(
                      color: ColorsRes.appcolor,
                      width: 2,
                    )),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    UIData.username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsRes.white,
                    ),
                  ),
                  Text(
                    UIData.useremail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsRes.white.withOpacity(0.9),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(children: <Widget>[
            SizedBox(
              height: width,
              child: new ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/drhome.png",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(
                    StringsRes.profile,
                    style: TextStyle(color: ColorsRes.appcolor),
                  ),
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/sellbuycoins.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.sellbuycoin, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellActivity(0, -1)));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/withdraw.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.withdraw, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => WithdrawActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/drhistory.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.history, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryActivity(0)));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/banking.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.banking, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BankingActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/kycapplication.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.kycapplication, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);

                    showNewDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: DesignConfig.roundedrectangleshape,
                            insetPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                            //backgroundColor: ColorsRes.appcolor,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: KYCInfoDialog(),
                            ),
                          );
                        });
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/pin.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.transactionpin, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetTransactionPinActivity("main")));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/halloffame.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.halloffame, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HallOfFameUserList()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/airtime.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.airtimerecharge, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneNumberScreen()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/freegift.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.freegift, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GiftItemPageActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/publicpay.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.publicpayment, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsernameForPayment()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/calculator.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.ratecalc, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RateCalculatorActivity()));
                    /*showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: DesignConfig.roundedrectangleshape,
                insetPadding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                //backgroundColor: ColorsRes.appcolor,
                child: RateCalculatorActivity(),
              );
            });*/
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/invitefriend.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.referfrd, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReferpageActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/referral.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.referral, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReferalListActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/notification.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.notification, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/ticket.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.supportticket, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportTicketListActivity()));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/termscondition.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.terms_and_condition, style: TextStyle(color: ColorsRes.appcolor)),
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermsConditionActivity(StringsRes.terms_and_condition)));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/privacypolicy.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.privacy_policy, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.of(context).pop();
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: "test",)));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermsConditionActivity(StringsRes.privacy_policy)));
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/drrateus.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.rateus, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.of(context).pop();
                    OpenRateUsDialog();
                  }),
            ),
            SizedBox(
              height: width,
              child: new ListTile(
                  subtitle: Divider(
                    color: ColorsRes.appcolor,
                    endIndent: 40,
                  ),
                  dense: true,
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/logout.png",
                    height: MediaQuery.of(context).size.width / 14,
                  ),
                  title: new Text(StringsRes.logout, style: TextStyle(color: ColorsRes.appcolor)),
                  onTap: () {
                    Navigator.pop(context);
                    //Constant.session.logoutUser(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: DesignConfig.roundedrectangleshape,
                            title: Text(
                              StringsRes.logout,
                              style: TextStyle(color: ColorsRes.secondgradientcolor, fontWeight: FontWeight.bold),
                            ),
                            content: Text(StringsRes.logoutconfirm),
                            actions: [
                              TextButton(
                                child: Text(
                                  StringsRes.cancel,
                                  style: TextStyle(color: ColorsRes.secondgradientcolor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                  child: Text(
                                    StringsRes.logout,
                                    style: TextStyle(color: ColorsRes.secondgradientcolor),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          );
                        });
                  }),
            )
          ]),
        ),
      ],
    );
  }

  Widget OpenRateUsDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: DesignConfig.roundedrectangleshape,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0, top: 5),
                      child: Icon(
                        Icons.close,
                        color: ColorsRes.grey,
                      ),
                    ),
                  ),
                ),
                CachedNetworkImage(imageUrl: "https://smartkit.wrteam.in/smartkit/cryptotech/rateus.png"),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                  child: Text(
                    StringsRes.rateustitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: Text(
                    "Recommend us to others by rating us ",
                    // on ${Platform.isIOS ? "Apple Store" : "Play Store"}
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: ColorsRes.grey)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 38,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Center(
                          child: Text(
                        StringsRes.rateus,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold),
                      )),
                      decoration: DesignConfig.BoxDecorationContainer(ColorsRes.secondgradientcolor, 10),
                    )),
              ],
            ),
          );
        });
  }
}
