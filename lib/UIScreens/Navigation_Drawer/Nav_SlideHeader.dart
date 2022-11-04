import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/Constant/SmartKitColor.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopColor.dart';
import 'drawerbehavior.dart';

class DrawerSlideWithHeader extends StatefulWidget {
  @override
  _DrawerSlideWithHeaderState createState() => _DrawerSlideWithHeaderState();
}

class _DrawerSlideWithHeaderState extends State<DrawerSlideWithHeader> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'restaurant',
        title: 'THE PADDOCK',
      ),
      new MenuItem(
        id: 'other1',
        title: 'THE HERO',
      ),
      new MenuItem(
        id: 'other2',
        title: 'HELP US GROW',
      ),
      new MenuItem(
        id: 'other3',
        title: 'SETTINGS',
      ),
    ],
  );

  var selectedMenuItemId = 'restaurant';
  var _widget = Text("1");

  Widget headerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              new Container(width: 48.0, height: 48.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.fill, image: CachedNetworkImageProvider("https://smartkit.wrteam.in/smartkit/images/user1.jpg")))),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "John Witch",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                      ),
                      Text(
                        "test123@gmail.com",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DrawerScaffold(
      percentage: 1,
      cornerRadius: 0,
      appBar: AppBarProps(title: Text("Drawer - with Header"), actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})]),
      menuView: new MenuView(
        menu: menu,
        selectorColor: cryptocolor2,
        headerView: headerView(context),
        animation: false,
        alignment: Alignment.topLeft,
        color: happyshopcolor2,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          if (itemId == 'restaurant') {
            setState(() => _widget = Text("Restaurant"));
          } else if (itemId == 'other1') {
            setState(() => _widget = Text("THE HERO"));
          } else if (itemId == 'other2') {
            setState(() => _widget = Text("HELP US GROW"));
          } else {
            setState(() => _widget = Text("SETTING"));
          }
        },
      ),
      contentView: Screen(
        contentBuilder: (context) => LayoutBuilder(
          builder: (context, constraint) => GestureDetector(
            child: Container(
              color: Colors.white,
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              child: Center(child: _widget),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Clicked"),
                duration: Duration(seconds: 3),
              ));
            },
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
