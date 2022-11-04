import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:smartkit/FullApp/eStudy/Model/Lessons_Model.dart';
import 'package:smartkit/FullApp/eStudy/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/eStudy/helper/StringsRes.dart';

class LessonDetailsTablet extends StatefulWidget {
  final int idvideo, id;
  LessonDetailsTablet({Key key, this.id, this.idvideo}) : super(key: key);

  @override
  _LessonDetailsTabletState createState() => _LessonDetailsTabletState();
}

class _LessonDetailsTabletState extends State<LessonDetailsTablet> {
  bool descTextShowFlag = false;
  // int idvideo = 0, id = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light, shadowColor: Colors.transparent,
            snap: false,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "",
                  style: TextStyle(color: ColorsRes.introTitlecolor, fontSize: 28),
                ), //Text
                background: Stack(children: [
                  Container(
                    color: ColorsRes.bgcolor,
                    height: MediaQuery.of(context).size.width,
                    child: SizedBox(
                        child: SvgPicture.network(
                      'https://smartkit.wrteam.in/smartkit/eStudy/topback.svg',
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 18, right: 20, top: MediaQuery.of(context).size.height * .24),
                      child: Text.rich(TextSpan(text: LessonsList[widget.id].lessonsName + "\n", style: TextStyle(color: ColorsRes.white, fontSize: 16), children: <InlineSpan>[
                        TextSpan(
                          text: LessonsList[widget.id].LessonsContaint[widget.idvideo].lessonsSubTitle + "\n",
                          style: TextStyle(
                            color: ColorsRes.white,
                            fontSize: 26,
                          ),
                        ),
                      ]))),
                ]) //Images.network
                ), //FlexibleSpaceBar
            expandedHeight: MediaQuery.of(context).size.height * .3,
            backgroundColor: ColorsRes.bgcolor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: ColorsRes.white),
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
                // setState(() {
                //   Lesson = 2;
                // });
              },
            ), //IconButton
          ), //SliverAppBar
          SliverList(
            delegate: SliverChildListDelegate([
              new Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: Center(
                                    child: Container(
                                        // child: FlickVideoPlayer(
                                        //   flickManager: flickManager = FlickManager(
                                        //     videoPlayerController: VideoPlayerController.network(LessonsList[id].LessonsContaint[idvideo].lessonsContanUrl),
                                        //   ),
                                        // ),
                                        ))))),
                    Text(LessonsList[widget.id].LessonsContaint[widget.idvideo].lessonsContentDescription, maxLines: descTextShowFlag ? 8 : 5, textAlign: TextAlign.start, style: TextStyle(color: ColorsRes.introTitlecolor, fontSize: 16)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          descTextShowFlag = !descTextShowFlag;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          descTextShowFlag
                              ? Text(
                                  StringsRes.Read_less_lb,
                                  style: TextStyle(color: ColorsRes.appcolor, fontSize: 16),
                                )
                              : Text(StringsRes.Read_more_lb,
                                  style: TextStyle(
                                    color: ColorsRes.appcolor,
                                    fontSize: 16,
                                  ))
                        ],
                      ),
                    ),
                    Divider(height: 1),
                  ],
                ),
              )
            ]), //SliverChildBuildDelegate
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 90))
        ], //<Widget>[]
      ),
    );
  }
}
