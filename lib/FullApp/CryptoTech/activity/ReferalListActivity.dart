import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/UIData.dart';
import 'package:smartkit/FullApp/CryptoTech/model/Refer.dart';

final _scaffoldKeyoutgoing = GlobalKey<ScaffoldState>();

class ReferalListActivity extends StatefulWidget {
  @override
  ReferalListState createState() => new ReferalListState();
}

class ReferalListState extends State<ReferalListActivity> {
  List<Refer> referallist;

  bool referisgettingdata = false, referisnodata = false;

  @override
  void initState() {
    super.initState();
    //DesignConfig.SetStatusbarColor(ColorsRes.firstgradientcolor);
    referallist = [];
    referallist = UIData.getReferalList();
  }

  @override
  void dispose() {
    //DesignConfig.SetStatusbarColor(ColorsRes.secondgradientcolor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double toppadding = kToolbarHeight + 40;
    return Scaffold(
      key: _scaffoldKeyoutgoing,
      backgroundColor: ColorsRes.homebgcolor,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: DesignConfig.gradient,
            ),
            padding: EdgeInsets.only(top: toppadding),
            child: Container(
              padding: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: ColorsRes.homebgcolor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(18), topLeft: Radius.circular(18)),
              ),
              child: referisgettingdata
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : referisnodata
                      ? Center(
                          child: Text(
                          StringsRes.no_data_found,
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ))
                      : NotificationContent(),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IntrinsicHeight(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(StringsRes.referral, style: TextStyle(color: ColorsRes.white)),
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

  Widget NotificationContent() {
    return Column(
      children: <Widget>[
        Card(
          color: ColorsRes.white,
          shape: DesignConfig.roundedrectangleshape,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Text(
                      StringsRes.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsRes.secondgradientcolor, fontWeight: FontWeight.bold),
                    )),
                VerticalDivider(
                  color: ColorsRes.grey,
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      StringsRes.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsRes.secondgradientcolor, fontWeight: FontWeight.bold),
                    )),
                VerticalDivider(
                  color: ColorsRes.grey,
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      Constant.CURRENCYSYMBOL,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsRes.secondgradientcolor, fontWeight: FontWeight.bold),
                    )),
              ]),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 5, right: 5),
              physics: ClampingScrollPhysics(),
              itemCount: referallist.length,
              itemBuilder: (context, index) {
                Refer item = referallist.isEmpty ? null : referallist[index];

                return Card(
                  color: ColorsRes.white,
                  shape: DesignConfig.roundedrectangleshape,
                  margin: EdgeInsets.only(bottom: 5),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Expanded(flex: 3, child: Text(item.name, style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black)), textAlign: TextAlign.start)),
                        VerticalDivider(
                          color: ColorsRes.grey,
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              item.email,
                              style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black)),
                            )),
                        VerticalDivider(
                          color: ColorsRes.grey,
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              item.amount,
                              style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black, fontWeight: FontWeight.bold)),
                              textAlign: TextAlign.end,
                            )),
                      ]),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
