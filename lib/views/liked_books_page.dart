import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:book_app/components/book_item.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/models/liked_books_model.dart';
import 'package:provider/provider.dart';

class LikedBooks extends StatefulWidget {
  @override
  _LikedBooksState createState() => _LikedBooksState();
}

class _LikedBooksState extends State<LikedBooks> {
  @override
  void initState() {
    super.initState();
    getLikedBooks();
  }

  @override
  void deactivate() {
    super.deactivate();
    getLikedBooks();
  }

  getLikedBooks() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          Provider.of<LikedBooksModel>(context, listen: false).getLikedBooks();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LikedBooksModel>(
      builder: (BuildContext context, LikedBooksModel favoritesProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Liked Books',
            ),
          ),
          body: favoritesProvider.posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/empty.png',
                        height: 300.0,
                        width: 300.0,
                      ),
                      Text(
                        'Nothing is here',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                  shrinkWrap: true,
                  itemCount: favoritesProvider.posts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 200 / 340,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Entry entry =
                        Entry.fromJson(favoritesProvider.posts[index]['item']);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: BookItem(
                        img: entry.link[1].href,
                        title: entry.title.t,
                        entry: entry,
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
