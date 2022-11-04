import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartkit/FullApp/Grobag/Helper/GrobagColor.dart';

import 'GrobagHomeTablet.dart';

class GrobagSearchTablet extends StatefulWidget {
  @override
  _GrobagSearchTabletState createState() => _GrobagSearchTabletState();
}

class _GrobagSearchTabletState extends State<GrobagSearchTablet> {
  List itemList = [];
  ChoiceChip tagChip;
  List<String> tagList = ['Masks', 'Mango', 'Orio', 'Almond', 'Nike Shoes', 'Apple', 'Senitizer', 'T-shirt', 'Tea', 'Lemon', 'Buttor'];

  List<String> recentList = ['Nestle', 'Fanta Flavors', 'Bombay Sweets', 'Biscuits'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: white,
          title: Container(
            height: 50,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 5.0),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        isDense: true,
                        hintText: 'Search for product',
                        hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: fontColor,
                            ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.network(
                            'https://smartkit.wrteam.in/smartkit/grobag/search-home.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 30,
                  padding: EdgeInsets.all(5.0),
                  margin: const EdgeInsets.only(left: 5, right: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: fontLight.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //                 <--- border radius here
                        ),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      dropdownColor: primary.withOpacity(0.9),
                      isExpanded: false,
                      value: curStatus,
                      onChanged: (newValue) {
                        setState(() {
                          curStatus = newValue;
                        });
                      },
                      items: searchList.map((String st) {
                        return DropdownMenuItem<String>(
                          value: st,
                          child: Text(
                            st,
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    )),
                  ),
                ),
              ],
            ),
          )),
      body: itemList.length > 0
          ? ListView.builder(
              padding: EdgeInsetsDirectional.only(bottom: 5, start: 10, end: 10, top: 12),
              physics: BouncingScrollPhysics(),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return listItem(index);
              })
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trending',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  trendingList(),
                  Text(
                    'Recent Searches',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: recentList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            recentList[index],
                            style: TextStyle(fontSize: 15),
                          ),
                          onTap: () {},
                        );
                      })
                ],
              ),
            ),
    );
  }

  Widget listItem(int index) {}

  trendingList() {
    List<Widget> chips = [];

    for (int i = 0; i < tagList.length; i++) {
      tagChip = ChoiceChip(
        selected: false,
        label: Text(tagList[i], style: TextStyle(color: Colors.grey)),
        backgroundColor: white,
        // selectedColor: colors.grad2Color,
        // disabledColor: colors.grad2Color.withOpacity(0.5),
        // shape: OutlineInputBorder(
        //   borderSide: BorderSide(color: lightBack),
        // ),

        onSelected: (bool selected) {},
      );

      chips.add(Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: tagChip));
    }
    return Wrap(
      children: chips.map<Widget>((Widget chip) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: chip,
        );
      }).toList(),
    );
  }
}
