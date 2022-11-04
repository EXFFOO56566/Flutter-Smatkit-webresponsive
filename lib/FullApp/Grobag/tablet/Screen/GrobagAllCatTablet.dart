import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/Grobag/Helper/GrobagColor.dart';
import 'GrobagHomeTablet.dart';
import 'package:flutter/cupertino.dart';

import 'GrobagProductListTablet.dart';

class GrobagAllCatTablet extends StatefulWidget {
  @override
  _GrobagAllCatTabletState createState() => _GrobagAllCatTabletState();
}

class _GrobagAllCatTabletState extends State<GrobagAllCatTablet> {
  @override
  Widget build(BuildContext context) {
    return _catList();
  }

  _catList() {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GrobagHomeTablet(),
            ));
      },
      child: GridView.count(
          padding: EdgeInsets.all(20),
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 0.8,
          physics: BouncingScrollPhysics(),
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: List.generate(
            catList.length,
            (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GrobagProducListTablet(
                                title: catList[index]["title"],
                              )));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 5.0),
                        child: CachedNetworkImage(
                          imageUrl: catList[index]["img"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        catList[index]["title"],
                        style: TextStyle(
                          color: fontColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
