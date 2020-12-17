import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/utility/feedbooks_api.dart';
import 'package:book_app/utility/response.dart';

class HomePageModel with ChangeNotifier {
  FeedbooksAPI api = FeedbooksAPI();
  Response response = Response.loading;
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();

  getFeeds() async {
    setResponseStatus(Response.loading);
    try {
      CategoryFeed popular = await api.getCategory(FeedbooksAPI.popular);
      setTop(popular);
      CategoryFeed newReleases = await api.getCategory(FeedbooksAPI.noteworthy);
      setRecent(newReleases);
      setResponseStatus(Response.loaded);
    } catch (e) {}
  }

  void setResponseStatus(Response value) {
    response = value;
    notifyListeners();
  }

  void setTop(value) {
    top = value;
    notifyListeners();
  }

  CategoryFeed getTop() {
    return top;
  }

  void setRecent(value) {
    recent = value;
    notifyListeners();
  }

  CategoryFeed getRecent() {
    return recent;
  }
}
