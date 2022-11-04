import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/CryptoTech/activity/Gift/GiftOrderDetail.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/UIData.dart';
import 'package:smartkit/FullApp/CryptoTech/model/Gift.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/RelativeDateFormat.dart';
import 'package:intl/intl.dart';

Gift selectedorder;

class GiftOrderListActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GiftOrderListState();
  }
}

class GiftOrderListState extends State<GiftOrderListActivity> {
  List<Gift> giftorderlist;

  int giftoffset = 0;

  bool giftisloadmore = true, giftisgettingdata = true, giftisnodata = false;
  final _scaffoldKeygift = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    //DesignConfig.SetStatusbarColor(ColorsRes.secondgradientcolor);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //DesignConfig.SetStatusbarColor(ColorsRes.firstgradientcolor);
    giftorderlist = [];

    giftorderlist = UIData.getGiftOrderList();

    //LoadGift();
  }

  @override
  Widget build(BuildContext context) {
    double toppadding = kToolbarHeight + 40;
    return Scaffold(
      key: _scaffoldKeygift,
      backgroundColor: ColorsRes.bgcolor,
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
              child: giftisnodata
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
                title: Text(StringsRes.giftorders, style: TextStyle(color: ColorsRes.white)),
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(padding: const EdgeInsets.all(12.0), child: CachedNetworkImage(imageUrl: 'https://smartkit.wrteam.in/smartkit/cryptotech/back_button.png'))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget NotificationContent() {
    return new NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {},
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: EdgeInsetsDirectional.only(bottom: 5, start: 10, end: 10, top: 12),
                physics: ClampingScrollPhysics(),
                itemCount: giftorderlist.length,
                itemBuilder: (context, index) {
                  Gift item = giftorderlist[index];

                  return item == null
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            selectedorder = item;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GiftOrderDetail()));
                          },
                          child: Card(
                            color: ColorsRes.cardbggrey,
                            shape: DesignConfig.roundedrectangleshape,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: colorlist[index % 6],
                                    child: Text(
                                      item.title.contains(" ") ? "${item.title.split(' ')[0].substring(0, 1).toUpperCase()}${item.title.split(' ')[1].substring(0, 1).toUpperCase()}" : item.title.substring(0, 2).toUpperCase(),
                                      style: TextStyle(color: ColorsRes.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            item.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                                  color: ColorsRes.firstgradientcolor,
                                                )),
                                          )),
                                          Card(
                                              color: Constant.StatusColor(item.status.trim()),
                                              child: Text(
                                                "\t${item.status}\t",
                                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(item.email, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black))),
                                      Text(
                                        RelativeDateFormat.format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(item.created_on)),
                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(fontWeight: FontWeight.bold, color: ColorsRes.grey.withOpacity(0.7))),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }

  List<Color> colorlist = [ColorsRes.cardyellow, ColorsRes.cardpurple, ColorsRes.cardpink, ColorsRes.cardblue, ColorsRes.cardgreen, ColorsRes.cardpich];
}
