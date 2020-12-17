import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/progress_widget.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/util/page_router.dart';
import 'package:uuid/uuid.dart';
import '../views/book_page.dart';

class BookListItem extends StatelessWidget {
  final String img;
  final String title;
  final String author;
  final Entry entry;

  BookListItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.author,
    @required this.entry,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PageRouter.pushPage(
          context,
          Details(
            entry: entry,
            imgTag: imgTag,
            titleTag: titleTag,
            authorTag: authorTag,
          ),
        );
      },
      child: Container(
        height: 150.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: Hero(
                  tag: imgTag,
                  child: CachedNetworkImage(
                    imageUrl: '$img',
                    placeholder: (context, url) => Container(
                      height: 150.0,
                      width: 100.0,
                      child: ProgressWidget(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/place.png',
                      fit: BoxFit.cover,
                      height: 150.0,
                      width: 100.0,
                    ),
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: 100.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: titleTag,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        '${title.replaceAll(r'\', '')}',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Hero(
                    tag: authorTag,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        '$author',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
