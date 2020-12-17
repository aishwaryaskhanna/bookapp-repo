import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/progress_widget.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/utility/page_router.dart';
import 'package:uuid/uuid.dart';
import '../views/book_page.dart';

class BookItem extends StatelessWidget {
  final String bookCover;
  final String bookTitle;
  final Entry entry;

  BookItem({
    Key key,
    this.bookCover,
    this.bookTitle,
    this.entry,
  }) : super(key: key);

  static final uuid = Uuid();
  final String coverTag = uuid.v4();
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
            imgTag: coverTag,
            titleTag: titleTag,
            authorTag: authorTag,
          ),
        );
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: coverTag,
              child: CachedNetworkImage(
                imageUrl: '$bookCover',
                placeholder: (context, url) => ProgressWidget(),
                errorWidget: (context, url, error) => Text('Unavailable'),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Hero(
            tag: titleTag,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                '${bookTitle.replaceAll(r'\', '')}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
