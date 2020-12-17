import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:book_app/models/category.dart';
import 'package:xml2json/xml2json.dart';

class Api {
  Dio dio = Dio();
  static String baseURL = 'https://catalog.feedbooks.com';
  static String publicDomainURL = '$baseURL/publicdomain/browse';
  static String popular = '$publicDomainURL/top.atom?sort=new';
  static String recent =
      '$publicDomainURL/top.atom?cat=FBFIC029000&amp;language=en&amp;sort=new';
  static String awards =
      '$publicDomainURL/top.atom?cat=FBFIC029000&amp;language=en&amp;sort=awards';
  static String noteworthy = '$publicDomainURL/homepage_selection.atom';
  static String shortStory =
      '$publicDomainURL/top.atom?cat=FBFIC029000&amp;language=en&amp;sort=selection';
  static String sciFi = '$publicDomainURL/top.atom?cat=FBFIC028000';
  static String actionAdventure = '$publicDomainURL/top.atom?cat=FBFIC002000';
  static String mystery = '$publicDomainURL/top.atom?cat=FBFIC022000';
  static String romance = '$publicDomainURL/top.atom?cat=FBFIC027000';
  static String horror = '$publicDomainURL/top.atom?cat=FBFIC015000';

  Future<CategoryFeed> fetchCategoryBooks(String url) async {
    var res = await dio.get(url).catchError((e) {
      throw (e);
    });
    CategoryFeed category;
    if (res.statusCode == 200) {
      Xml2Json xml2json = new Xml2Json();
      xml2json.parse(res.data.toString());
      var json = jsonDecode(xml2json.toGData());
      category = CategoryFeed.fromJson(json);
    } else {
      throw ('Error encountered.');
    }
    return category;
  }
}
