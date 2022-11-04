import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/Constant.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/StringsRes.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/UIData.dart';
import 'package:smartkit/FullApp/CryptoTech/helper/new_dialog.dart';
import 'package:smartkit/FullApp/CryptoTech/model/Fame.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HallOfFameUserList extends StatefulWidget {
  @override
  HallOfFameUserListState createState() => new HallOfFameUserListState();
}

class HallOfFameUserListState extends State<HallOfFameUserList> {
  List<Fame> famelist;

  int fameoffset = 0;
  ScrollController famecontroller;
  bool fameisloadmore = true, fameisgettingdata = false, fameisnodata = false;

  Color bordercolor = ColorsRes.black.withOpacity(0.6);
  final _scaffoldKeyfame = GlobalKey<ScaffoldState>();
  Fame firstfame = null, secondfame = null, thirdfame = null;

  @override
  void dispose() {
    //DesignConfig.SetStatusbarColor(ColorsRes.secondgradientcolor);
    famecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //DesignConfig.SetStatusbarColor(ColorsRes.firstgradientcolor);
    famelist = [];
    famelist = UIData.getHallofFameList();

    if (famelist.length >= 1) firstfame = famelist[0];
    if (famelist.length >= 2) secondfame = famelist[1];
    if (famelist.length >= 3) thirdfame = famelist[2];

    // loadFame();
  }

  @override
  Widget build(BuildContext context) {
    double toppadding = kToolbarHeight + 40;
    return Scaffold(
      key: _scaffoldKeyfame,
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
              child: fameisnodata
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
                title: Text(StringsRes.halloffame, style: TextStyle(color: ColorsRes.white)),
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
    return new NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {},
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 15, end: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                child: secondfame == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          OpenFameInfoDialog(secondfame, "02", 1);
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              margin: EdgeInsets.only(top: 8, right: 5),
                              decoration: BoxDecoration(
                                color: ColorsRes.homebgcolor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: bordercolor),
                              ),
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                ClipOval(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Constant.ImageWidget(secondfame.image_url, 60, 60),
                                ),
                                Text(
                                  secondfame.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "${Constant.CURRENCYSYMBOL}${secondfame.total}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey, fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  secondfame.is_user_following != null ? StringsRes.following : StringsRes.follow,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black)),
                                ),
                              ]),
                            ),
                            Positioned.fill(child: Align(alignment: Alignment.topRight, child: WebsafeSvg.network("https://smartkit.wrteam.in/smartkit/cryptotech/avatar/second.svg")))
                          ],
                        ),
                      ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: firstfame == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          OpenFameInfoDialog(firstfame, "01", 0);
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 160,
                              margin: EdgeInsets.only(top: 8, right: 5),
                              decoration: BoxDecoration(
                                color: ColorsRes.homebgcolor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: bordercolor),
                              ),
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                ClipOval(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Constant.ImageWidget(firstfame.image_url, 70, 70),
                                ),
                                Text(
                                  firstfame.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "${Constant.CURRENCYSYMBOL}${firstfame.total}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey, fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  firstfame.is_user_following != null ? StringsRes.following : StringsRes.follow,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black)),
                                ),
                              ]),
                            ),
                            Positioned.fill(child: Align(alignment: Alignment.topRight, child: WebsafeSvg.network("https://smartkit.wrteam.in/smartkit/cryptotech/avatar/first.svg")))
                          ],
                        ),
                      ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: thirdfame == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          OpenFameInfoDialog(thirdfame, "03", 2);
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              margin: EdgeInsets.only(top: 8, right: 5),
                              decoration: BoxDecoration(
                                color: ColorsRes.homebgcolor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: bordercolor),
                              ),
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                ClipOval(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Constant.ImageWidget(thirdfame.image_url, 60, 60),
                                ),
                                Text(
                                  thirdfame.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.firstgradientcolor, fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "${Constant.CURRENCYSYMBOL}${thirdfame.total}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey, fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  thirdfame.is_user_following != null ? StringsRes.following : StringsRes.follow,
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.black)),
                                ),
                              ]),
                            ),
                            Positioned.fill(child: Align(alignment: Alignment.topRight, child: WebsafeSvg.network("https://smartkit.wrteam.in/smartkit/cryptotech/avatar/third.svg")))
                          ],
                        ),
                      ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsetsDirectional.only(bottom: 5, start: 15, end: 15, top: 20),
                controller: famecontroller,
                physics: ClampingScrollPhysics(),
                itemCount: famelist.length,
                itemBuilder: (context, index) {
                  Fame item = famelist[index];

                  String number = (index + 1).toString().padLeft(2, '0');

                  return item == null || index == 0 || index == 1 || index == 2
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            OpenFameInfoDialog(item, number, index);
                          },
                          child: Card(
                            color: ColorsRes.homebgcolor,
                            shape: DesignConfig.SetRoundedBorder(bordercolor, 8),
                            margin: EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    number,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: ColorsRes.firstgradientcolor),
                                  ),
                                  SizedBox(width: 10),
                                  ClipOval(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Constant.ImageWidget(item.image_url, 30, 30),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Text(
                                    item.name,
                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                          color: ColorsRes.firstgradientcolor,
                                        )),
                                  )),
                                  SizedBox(width: 5),
                                  Text("${Constant.CURRENCYSYMBOL}${item.total}", style: Theme.of(context).textTheme.caption.merge(TextStyle(color: ColorsRes.grey, fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ),
                        );
                }),
          ),
          fameisgettingdata
              ? Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }

  List<Color> colorlist = [ColorsRes.cardyellow, ColorsRes.cardpurple, ColorsRes.cardpink, ColorsRes.cardblue, ColorsRes.cardgreen, ColorsRes.cardpich];

  Future<void> OpenFameInfoDialog(Fame fameuser, String number, int index) async {
    return showNewDialog(
        context: context,
        builder: (context) {
          StreamController<String> controller = StreamController<String>.broadcast();
          return AlertDialog(
            shape: DesignConfig.SetRoundedBorder(ColorsRes.white, 12),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ClipOval(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Constant.ImageWidget(fameuser.image_url, 100, 100),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              shape: DesignConfig.SetRoundedBorder(ColorsRes.white, 8),
                              color: ColorsRes.green,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                child: Text(
                                  number,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorsRes.white),
                                ),
                              ),
                            )))
                  ],
                ),
                Text(
                  fameuser.name,
                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: ColorsRes.appcolor, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 15),
                Text("${Constant.CURRENCYSYMBOL}${fameuser.total}", style: Theme.of(context).textTheme.subtitle2),
                Text("${StringsRes.followers} : ${fameuser.followers}", style: Theme.of(context).textTheme.subtitle2),
                SizedBox(height: 25),
                StreamBuilder(
                    stream: controller.stream,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return snapshot.hasData && snapshot.data == 'loading'
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : Container();
                    }),
                SizedBox(height: 5),
                FlatButton(
                  onPressed: () async {
                    controller.add('');
                  },
                  child: Text(fameuser.is_user_following == 1 ? StringsRes.unfollow : StringsRes.follow),
                  textColor: ColorsRes.white,
                  color: ColorsRes.firstgradientcolor,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                textColor: ColorsRes.black,
                child: Text(StringsRes.cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
