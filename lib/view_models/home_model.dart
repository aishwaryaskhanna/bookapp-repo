import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/util/api.dart';
import 'package:book_app/util/api_request_status.dart';

class HomePageProvider with ChangeNotifier {
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  APIRequestStatus response = APIRequestStatus.loading;
  Api api = Api();

  getFeeds() async {
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      CategoryFeed popular = await api.getCategory(Api.popular);
      setTop(popular);
      CategoryFeed newReleases = await api.getCategory(Api.noteworthy);
      setRecent(newReleases);
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {}
  }

  void setApiRequestStatus(APIRequestStatus value) {
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
