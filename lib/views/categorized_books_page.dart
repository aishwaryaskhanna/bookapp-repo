import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:book_app/components/widget_creator.dart';
import 'package:book_app/components/book_list_entry.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/models/category_model.dart';
import 'package:provider/provider.dart';

class Genre extends StatefulWidget {
  final String title;
  final String url;

  Genre({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<CategoryModel>(context, listen: false)
          .getFeed(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryModel provider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${widget.title}'),
          ),
          body: WidgetCreator(
            response: provider.apiRequestStatus,
            child: ListView(
              controller: provider.controller,
              children: <Widget>[
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  shrinkWrap: true,
                  itemCount: provider.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    Entry entry = provider.items[index];
                    return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: BookListItem(
                        bookCover: entry.link[1].href,
                        title: entry.title.t,
                        author: entry.author.name.t,
                        entry: entry,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.0),
                provider.loadingMore
                    ? Container(
                        height: 80.0,
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(),
              ],
            ),
            reload: () => provider.getFeed(widget.url),
          ),
        );
      },
    );
  }
}
