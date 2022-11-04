import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartkit/FullApp/Grobag/Helper/GrobagAppbar.dart';
import 'package:smartkit/FullApp/Grobag/Helper/GrobagColor.dart';

import 'GrobagHomeTablet.dart';

class OrderSuccessTablet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateSuccessTablet();
  }
}

class StateSuccessTablet extends State<OrderSuccessTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrobagAppbar(
        title: 'Order Placed',
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Thank you for shopping',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Text(
              'Your order has been placed successfully!',
              style: TextStyle(color: fontColor),
            ),
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.symmetric(vertical: 40),
              child: SvgPicture.network("https://smartkit.wrteam.in/smartkit/grobag/ordersuccess.svg"),
              decoration: BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: new Container(
                margin: EdgeInsets.all(20),
                height: 48,
                decoration: new BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text("Continue Shopping",
                      style: TextStyle(
                        color: white,
                      )),
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => GrobagHomeTablet()), ModalRoute.withName('/'));
              },
            ),
          ],
        )),
      ),
    );
  }
}
