import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/utility/feedbooks_api.dart';
import 'package:book_app/utility/response.dart';

class HomePageProvider with ChangeNotifier {
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  Response response = Response.loading;
  FeedbooksAPI api = FeedbooksAPI();

  getFeeds() async {
    setApiRequestStatus(Response.loading);
    try {
      CategoryFeed popular = await api.getCategory(FeedbooksAPI.popular);
      setTop(popular);
      CategoryFeed newReleases = await api.getCategory(FeedbooksAPI.noteworthy);
      setRecent(newReleases);
      setApiRequestStatus(Response.loaded);
    } catch (e) {}
  }

  void setApiRequestStatus(Response value) {
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
