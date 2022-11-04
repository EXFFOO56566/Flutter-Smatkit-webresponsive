import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopColor.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopString.dart';

class HappyShopStaggeredList extends StatefulWidget {
  HappyShopStaggeredList({Key key}) : super(key: key);

  @override
  _HappyShopStaggeredListState createState() => _HappyShopStaggeredListState();
}

class _HappyShopStaggeredListState extends State<HappyShopStaggeredList> {
  final List _listUrl = [
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png", 'name': "Printed Men Round Neck Maroon T-Shirt", 'descprice': "2500", 'price': "3500", 'rating': "4.5", 'noOfRating': "90"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_a.png", 'name': null, 'descprice': null, 'price': null, 'rating': null, 'noOfRating': null},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_4.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_5.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_6.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_b.png", 'name': null, 'descprice': null, 'price': null, 'rating': null, 'noOfRating': null},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_7.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_8.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_9.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_10.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_c.png", 'name': null, 'descprice': null, 'price': null, 'rating': null, 'noOfRating': null},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man1.jpg", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man2.jpg", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man3.jpg", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man4.jpg", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man5.jpg", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man6.jpg", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_d.png", 'name': null, 'descprice': null, 'price': null, 'rating': null, 'noOfRating': null},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_b.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_c.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
    {'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("All Products"),
          backgroundColor: Colors.white,
        ),
        body: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: _listUrl.length,
            staggeredTileBuilder: (index) {
              return new StaggeredTile.fit(1);
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: StaggerdCard(
                    imgurl: _listUrl[index]['img'],
                    itemname: _listUrl[index]['name'],
                    descprice: _listUrl[index]['descprice'],
                    price: _listUrl[index]['price'],
                    rating: _listUrl[index]['rating'],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class StaggerdCard extends StatefulWidget {
  StaggerdCard({Key key, this.imgurl, this.rating, this.itemname, this.price, this.descprice}) : super(key: key);
  final String imgurl, rating, itemname, price, descprice;
  @override
  _StaggerdCardState createState() => _StaggerdCardState();
}

class _StaggerdCardState extends State<StaggerdCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      child: Card(
        elevation: 1.0,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: widget.itemname != null ? BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)) : BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.imgurl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                widget.rating != null
                    ? Card(
                        child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 10,
                            ),
                            Text(
                              widget.rating,
                              style: Theme.of(context).textTheme.overline.copyWith(letterSpacing: 0.2),
                            ),
                          ],
                        ),
                      ))
                    : Container(),
              ],
            ),
            widget.itemname != null
                ? Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.itemname,
                            style: Theme.of(context).textTheme.overline.copyWith(color: Colors.black, fontSize: 16.0, letterSpacing: 0.5),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            widget.price != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Text(" " + CUR_CURRENCY + " " + widget.price, style: TextStyle(color: primary)),
                        SizedBox(
                          width: 5.0,
                        ),
                        widget.price != null
                            ? Text(
                                CUR_CURRENCY + "" + widget.descprice,
                                style: Theme.of(context).textTheme.overline.copyWith(decoration: TextDecoration.lineThrough, letterSpacing: 1),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
