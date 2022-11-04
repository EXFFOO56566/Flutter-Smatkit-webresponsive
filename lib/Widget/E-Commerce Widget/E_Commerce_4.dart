import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartkit/Widget/Dialog/Flutter_Rating_Bar.dart';

import 'Detail_Ecmmerce_4.dart';
import 'Helper/E_Commerce_Model.dart';

class E_Commerce_4 extends StatefulWidget {
  @override
  _E_Commerce_4State createState() => _E_Commerce_4State();
}

class _E_Commerce_4State extends State<E_Commerce_4> {
  List<E_Commerce_Model> listCat;
  bool loading = true;
  bool useMobileLayout;

  @override
  Widget build(BuildContext context) {
    var elist = [
      {
        "id": "17",
        "category_name": "Clothes",
        "subcategory_name": "Formal",
        "title": "test",
        "description": "test",
        "images": ["https://smartkit.wrteam.in/smartkit/images/shoes1.jpg"],
        "price": "50000",
        "rating": "4",
        "sales_price": "100000",
        "product_variation": {
          "weight": ["50g", "200g"],
          "size": ["xs", "small"],
          "color": ["red", "black"]
        },
        "date_created": "20-09-2019 11:09:40"
      },
      {
        "id": "16",
        "category_name": "Shoes",
        "subcategory_name": "Puma",
        "title": "Shoes",
        "description": "Material Type: Mesh\r\nLifestyle: Casual\r\nClosure Type: Lace-Up\r\nToe Style: Round Toe\r\nWarranty Type: Manufacturer",
        "images": ["https://smartkit.wrteam.in/smartkit/images/158068146_15456509701_large.jpg", "https://smartkit.wrteam.in/smartkit/images/Plus-Size-52-Classic-Black-Men-s-Footwear-Comfortable-Ultra-Light-Shoes-Men-Shoes-No-Yeezie.jpg_640x640.jpg"],
        "price": "3000",
        "rating": "3",
        "sales_price": "2000",
        "product_variation": {
          "weight": ["50g", "100g"],
          "size": ["midium", "large"],
          "color": ["red", "blue"]
        },
        "date_created": "19-09-2019 10:09:13"
      },
      {
        "id": "15",
        "category_name": "Mobile",
        "subcategory_name": "Xiomi",
        "title": "Xiomi A",
        "description":
            "6.0\" TN,854*480 ,5 point touch pannel Display ,OPERATING SYSTEM- Android 9.0 \r\n4G Volte High Speed internet Connectivity , 1.3 GHz Quad core Processor, 4 GB RAM and 64GB Internal memory which can be expandable upto 128GB through SD card.\r\n48MP Rear camera with 15MP front camera and 5200mAh Li-ion Battery",
        "images": ["https://smartkit.wrteam.in/smartkit/images/phone.jpg", "https://smartkit.wrteam.in/smartkit/images/phone2.jpg", "https://smartkit.wrteam.in/smartkit/images/phone3.jpg"],
        "price": "15000",
        "rating": "5",
        "sales_price": "14000",
        "product_variation": {
          "weight": ["50g"],
          "size": ["midium"],
          "color": ["black"]
        },
        "date_created": "19-09-2019 10:09:16"
      },
      {
        "id": "14",
        "category_name": "Shoes",
        "subcategory_name": "Bata",
        "title": "MTV Stylish Round 10",
        "description":
            "Size Map: Medium\r\nFrame size: Lens width - 52 mm, nose-bridge: 23 mm, temple length: 135 mm\r\n6 Months on manufacturing defects\r\n100% UV protected\r\nPurple colored frame with purple temple\r\nPlastic frame\r\nBrown colored Polycarbonate lens\r\nIdeal for: Men and Women\r\n",
        "images": ["https://smartkit.wrteam.in/smartkit/images/goggles1.jpg", "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg", "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg"],
        "price": "500",
        "rating": "5",
        "sales_price": "400",
        "product_variation": {
          "weight": ["500g"],
          "size": ["small", "midium", "large"],
          "color": ["red", "blue", "black"]
        },
        "date_created": "18-09-2019 16:09:18"
      }
    ];
    listCat = (elist).map((data) => new E_Commerce_Model.fromJson(data)).toList();

    var shortestSide = MediaQuery.of(context).size.shortestSide;

// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.
    useMobileLayout = shortestSide < 600;

    return Scaffold(
      backgroundColor: Color(0xff252D4A),
      appBar: AppBar(
        title: new Text('E-Commerce Style 4',style: TextStyle(color: Colors.black)),backgroundColor: Colors.white,leading: BackButton(
          color: Colors.black
      ),),
      drawer: new Drawer(),
      body: new ListView.builder(
        itemCount: listCat.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Color(0xff343D5E),
                  elevation: 15,
                  child: Container(
                    //margin: EdgeInsets.only(left: 70),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              listCat[index].title,
                              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: <Widget>[
                                Text('\$${listCat[index].sale_price}     ', style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white30)),
                                Text('\$${listCat[index].price}', style: TextStyle(decoration: TextDecoration.lineThrough)),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FlutterRatingBar(
                                  initialRating: 3,
                                  fillColor: Colors.amber,
                                  borderColor: Colors.amber,
                                  allowHalfRating: true,
                                  itemSize: 15,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: new TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(10),
                                    ),
                                    child: new Text(
                                      "Buy",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                    // color: Colors.blue,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    height: useMobileLayout ? 180 : 240,

                    width: double.infinity,
                  ),
                  margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                ),
              ),
              Hero(
                  tag: "item$index",
                  child: Container(
                    child: Card(
                      child: ClipPath(
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: listCat[index].imgs[0],
                          ),
                          decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: Colors.white, width: 2), left: BorderSide(color: Colors.white, width: 2), top: BorderSide(color: Colors.white, width: 2), bottom: BorderSide(color: Colors.white, width: 2))),
                        ),
                        clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                    // height: 120,
                    height: useMobileLayout ? 120 : 180,
                    width: double.infinity,
                  )),
            ]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Detail_Ecmmerce_4(index: index, model: listCat[index])));
            },
          );
        },
      ),
    );
  }
}