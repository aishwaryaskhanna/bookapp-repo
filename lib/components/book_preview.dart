import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/progress_widget.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/utility/page_router.dart';
import 'package:uuid/uuid.dart';
import '../views/book_page.dart';

class BookCard extends StatelessWidget {
  final String img;
  final Entry entry;

  BookCard({
    Key key,
    @required this.img,
    @required this.entry,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        elevation: 4.0,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: CachedNetworkImage(
                imageUrl: '$img',
                placeholder: (context, url) => ProgressWidget(),
                errorWidget: (context, url, error) => Text('Unavailable'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
