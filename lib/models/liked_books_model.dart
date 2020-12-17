import 'package:flutter/foundation.dart';
import 'package:book_app/helper/liked_books_helper.dart';

class LikedBooksModel extends ChangeNotifier {
  List posts = List();
  bool loading = true;
  var db = LikedBooksDB();

  getLikedBooks() async {
    isLoading(true);
    posts.clear();
    List all = await db.showAllLikedBooks();
    posts.addAll(all);
    isLoading(false);
  }

  void isLoading(value) {
    loading = value;
    notifyListeners();
  }

  List fetchPosts() {
    return posts;
  }
}
