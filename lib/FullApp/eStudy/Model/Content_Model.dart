import 'package:smartkit/FullApp/eStudy/helper/StringsRes.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({this.image, this.title, this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(title: StringsRes.Introduction_Screen_One_Title_lb, image: 'https://smartkit.wrteam.in/smartkit/eStudy/intro_a.svg', discription: StringsRes.Introduction_Screen_One_Discription_lb),
  UnbordingContent(title: StringsRes.Introduction_Screen_Two_Title_lb, image: 'https://smartkit.wrteam.in/smartkit/eStudy/intro_b.svg', discription: StringsRes.Introduction_Screen_Two_Discription_lb),
  UnbordingContent(title: StringsRes.Introduction_Screen_Three_Title_lb, image: 'https://smartkit.wrteam.in/smartkit/eStudy/intro_c.svg', discription: StringsRes.Introduction_Screen_Three_Discription_lb),
];
