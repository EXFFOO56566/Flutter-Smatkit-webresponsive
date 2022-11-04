import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SmartKitHomeTile extends StatelessWidget {
  final Color bg, highlightColor, iconbg, iconbgshadow, subtitlebggradiant1, subtitlebggradiant2;
  final String title, subtitle, screnstext, iconpath;
  final Widget route;
  final bool isnew;

  const SmartKitHomeTile({
    Key key,
    @required this.bg,
    this.highlightColor,
    this.iconbg,
    this.iconbgshadow,
    this.subtitlebggradiant1,
    this.subtitlebggradiant2,
    this.title,
    this.subtitle,
    this.screnstext,
    this.iconpath,
    this.route,
    this.isnew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: Material(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Positioned(
                left: 0.0,
                top: 15.0,
                child: isnew == true
                    ? SvgPicture.network(
                        "https://smartkit.wrteam.in/smartkit/new2.svg",
                        width: 25.0,
                        height: 20.0,
                      )
                    : Container()),
            InkWell(
              splashColor: route != null ? highlightColor : Colors.transparent,
              highlightColor: route != null ? highlightColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              onTap: route != null
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => route),
                      );
                    }
                  : () {},
              child: new Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          height: 60.0,
                          width: 60.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              iconpath,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.0),
                            color: iconbg,
                            boxShadow: [
                              BoxShadow(
                                color: iconbgshadow,
                                offset: Offset(1, 1),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 20,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 5.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            gradient: LinearGradient(
                              begin: Alignment(1.0, 1.0),
                              end: Alignment(-1.0, -1.0),
                              colors: [subtitlebggradiant1, subtitlebggradiant2],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          screnstext,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            color: const Color(0xffaaaaaa),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
      tablet: Material(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                  left: 0.0,
                  top: 15.0,
                  child: isnew == true
                      ? SvgPicture.asset('assets/new2.svg',
                          // "https://smartkit.wrteam.in/smartkit/new2.svg",
                          width: width / 22,
                          // // 25.0,
                          height: width / 22
                          // 20.0,
                          )

                      // SvgPicture.network("https://smartkit.wrteam.in/smartkit/new2.svg",
                      //     width: width / 22,
                      //     // 25.0,
                      //     height: width / 22
                      //     // 20.0,
                      //     )
                      : Container()),
              InkWell(
                splashColor: route != null ? highlightColor : Colors.transparent,
                highlightColor: route != null ? highlightColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                onTap: route != null
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => route),
                        );
                      }
                    : () {},
                child: new Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: width / 10,
                            //  60.0,
                            width: width / 10,
                            // 60.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                iconpath,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.0),
                              color: iconbg,
                              boxShadow: [
                                BoxShadow(
                                  color: iconbgshadow,
                                  offset: Offset(1, 1),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: width / 35,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5.0),
                            height: width / 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              gradient: LinearGradient(
                                begin: Alignment(1.0, 1.0),
                                end: Alignment(-1.0, -1.0),
                                colors: [subtitlebggradiant1, subtitlebggradiant2],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: Text(
                              subtitle,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: width / 45,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            screnstext,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: width / 55,
                              color: const Color(0xffaaaaaa),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      desktop: Material(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                  left: 0.0,
                  top: 15.0,
                  child: isnew == true
                      ? SvgPicture.asset('assets/new2.svg',
                          // "https://smartkit.wrteam.in/smartkit/new2.svg",
                          width: width / 32,
                          // // 25.0,
                          height: width / 32
                          // 20.0,
                          )
                      : Container()),
              InkWell(
                splashColor: route != null ? highlightColor : Colors.transparent,
                highlightColor: route != null ? highlightColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                onTap: route != null
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => route),
                        );
                      }
                    : () {},
                child: new Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: width / 14,
                            //  60.0,
                            width: width / 14,
                            // 60.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                iconpath,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.0),
                              color: iconbg,
                              boxShadow: [
                                BoxShadow(
                                  color: iconbgshadow,
                                  offset: Offset(1, 1),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: width / 45,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5.0),
                            height: width / 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              gradient: LinearGradient(
                                begin: Alignment(1.0, 1.0),
                                end: Alignment(-1.0, -1.0),
                                colors: [subtitlebggradiant1, subtitlebggradiant2],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: Text(
                              subtitle,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: width / 55,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            screnstext,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: width / 65,
                              color: const Color(0xffaaaaaa),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
