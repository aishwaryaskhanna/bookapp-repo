import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_app/utility/feedbooks_api.dart';
import 'package:book_app/utility/response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'category.dart';

class CategoryProvider extends ChangeNotifier {
  ScrollController controller = ScrollController();
  List items = List();
  int page = 1;
  bool loadingMore = false;
  bool loadMore = true;
  Response apiRequestStatus = Response.loading;
  FeedbooksAPI api = FeedbooksAPI();

  listener(url) {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (!loadingMore) {
          paginate(url);
          Timer(Duration(milliseconds: 100), () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          });
        }
      }
    });
  }

  getFeed(String url) async {
    setApiRequestStatus(Response.loading);
    print(url);
    try {
      CategoryFeed feed = await api.getCategory(url);
      items = feed.feed.entry;
      setApiRequestStatus(Response.loaded);
      listener(url);
    } catch (e) {
      //checkError(e);
      throw (e);
    }
  }

  paginate(String url) async {
    if (apiRequestStatus != Response.loading && !loadingMore && loadMore) {
      Timer(Duration(milliseconds: 100), () {
        controller.jumpTo(controller.position.maxScrollExtent);
      });
      loadingMore = true;
      page = page + 1;
      notifyListeners();
      try {
        CategoryFeed feed = await api.getCategory(url + '&page=$page');
        items.addAll(feed.feed.entry);
        loadingMore = false;
        notifyListeners();
      } catch (e) {
        loadMore = false;
        loadingMore = false;
        notifyListeners();
        throw (e);
      }
    }
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  void setApiRequestStatus(Response value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
