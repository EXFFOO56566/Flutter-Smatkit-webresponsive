import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopColor.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopString.dart';
import 'package:smartkit/FullApp/HappyShop/Screen/HappyShopHome.dart';

class HappyShopNotification extends StatefulWidget {
  final bool appbar;
  HappyShopNotification({Key key, this.appbar}) : super(key: key);

  @override
  _HappyShopNotificationState createState() => _HappyShopNotificationState();
}

class _HappyShopNotificationState extends State<HappyShopNotification> with TickerProviderStateMixin {
  Animation buttonSqueezeanimation;
  AnimationController buttonController;

  @override
  void initState() {
    buttonController = new AnimationController(duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  List notiList = [
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak1.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak2.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak1.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak2.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak1.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"},
    {'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak2.jpg", "title": "Nike", "date": "1-2-2021", "desc": "Dummyy text"}
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HappyShopHome(),
          ),
        );
      },
      child: Scaffold(
          appBar: widget.appbar == true
              ? AppBar(
                  title: Text("Notifications", style: TextStyle(color: Colors.white)),
                )
              : PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
          body: notiList.length == 0
              ? Padding(padding: const EdgeInsets.only(top: kToolbarHeight), child: Center(child: Text(noNoti)))
              : ScreenTypeLayout(
                  mobile: ListView.builder(
                    shrinkWrap: true,
                    itemCount: notiList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return listItem(index);
                    },
                  ),
                  desktop: GridView.count(
                    padding: EdgeInsets.only(top: 5),
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    childAspectRatio: 4,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      9,
                      (index) {
                        return listItem(index);
                      },
                    ),
                  ),
                )),
    );
  }

  Widget listItem(int index) {
    return Card(
      elevation: 0.1,
      shadowColor: happyshopcolor5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    notiList[index]['date'],
                    style: TextStyle(color: primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      notiList[index]['title'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(notiList[index]['desc'])
                ],
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: CachedNetworkImage(
                  imageUrl: notiList[index]['img'],
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
