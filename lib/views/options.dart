import 'package:flutter/material.dart';
import 'package:book_app/util/router.dart';
import 'package:book_app/views/downloaded_books.dart';
import 'package:book_app/views/liked_books.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List items;

  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Feather.heart,
        'title': 'Liked Books',
        'function': () => _pushPage(Favorites()),
      },
      {
        'icon': Feather.download,
        'title': 'Downloaded Books',
        'function': () => _pushPage(Downloads()),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Options',
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: items[index]['function'],
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  _pushPage(Widget page) {
    MyRouter.pushPage(context, page);
  }
}
