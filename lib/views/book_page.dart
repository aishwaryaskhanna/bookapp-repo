import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:book_app/helper/locator_helper.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/models/book_page_model.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final Entry entry;
  final String imgTag;
  final String titleTag;
  final String authorTag;

  Details({
    Key key,
    @required this.entry,
    @required this.imgTag,
    @required this.titleTag,
    @required this.authorTag,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<BookPageProvider>(context, listen: false)
            .setEntry(widget.entry);
        Provider.of<BookPageProvider>(context, listen: false)
            .getFeed(widget.entry.author.uri.t.replaceAll(r'\&lang=en', ''));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookPageProvider>(
      builder: (BuildContext context, BookPageProvider detailsProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: widget.imgTag,
                      child: CachedNetworkImage(
                        imageUrl: '${widget.entry.link[1].href}',
                        placeholder: (context, url) => Container(
                          height: 200.0,
                          width: 130.0,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Feather.x),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: 130.0,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          Hero(
                            tag: widget.titleTag,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                '${widget.entry.title.t.replaceAll(r'\', '')}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Hero(
                            tag: widget.authorTag,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                '${widget.entry.author.name.t}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                                height: 210.0,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5.0),
                                    Center(
                                      child: Container(
                                        height: 20.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: _createDownloadButton(
                                            detailsProvider, context),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Center(
                                      child: Container(
                                        height: 20.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: IconButton(
                                          onPressed: () async {
                                            if (detailsProvider.faved) {
                                              detailsProvider.removeFromLiked();
                                            } else {
                                              detailsProvider.addtoLiked();
                                            }
                                          },
                                          icon: Icon(
                                            detailsProvider.faved
                                                ? Icons.favorite
                                                : Feather.heart,
                                            color: detailsProvider.faved
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Center(
                                      child: Container(
                                        height: 50.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: IconButton(
                                          onPressed: () => Share.text(
                                            'Share "${widget.entry.title.t}" with',
                                            'Glad to share the book "${widget.entry.title.t}" with you! Get it now from ${widget.entry.link[3].href}.',
                                            'text/plain',
                                          ),
                                          icon: Icon(
                                            Feather.share_2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Description',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Theme.of(context).textTheme.caption.color,
              ),
              SizedBox(height: 10.0),
              Text(
                '${widget.entry.summary.t}'
                    .replaceAll(r'\n', '\n')
                    .replaceAll(r'\r', '')
                    .replaceAll(r"\'", "'"),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  openBook(BookPageProvider provider) async {
    List dlList = await provider.getDownload();
    if (dlList.isNotEmpty) {
      Map dl = dlList[0];
      String path = dl['path'];

      List locators =
          await LocatorDB().getLocator(widget.entry.id.t.toString());

      EpubViewer.setConfig(
        identifier: 'androidBook',
        themeColor: Colors.cyanAccent,
        scrollDirection: EpubScrollDirection.VERTICAL,
        enableTts: false,
        allowSharing: true,
      );
      EpubViewer.open(path,
          lastLocation:
              locators.isNotEmpty ? EpubLocator.fromJson(locators[0]) : null);
      EpubViewer.locatorStream.listen((event) async {
        // Get locator here
        Map json = jsonDecode(event);
        json['bookId'] = widget.entry.id.t.toString();
        // Save locator to your database
        await LocatorDB().update(json);
      });
    }
  }

  _createDownloadButton(BookPageProvider provider, BuildContext context) {
    if (provider.downloaded) {
      return FlatButton(
        onPressed: () => openBook(provider),
        child: Text(
          'Read Now',
          style: TextStyle(
            color: Colors.cyanAccent,
          ),
        ),
      );
    } else {
      return FlatButton(
        onPressed: () => provider.downloadFile(
          context,
          widget.entry.link[3].href,
          widget.entry.title.t.replaceAll(' ', '_').replaceAll(r"\'", "'"),
        ),
        child: Text(
          'Download',
          style: TextStyle(
            color: Colors.cyanAccent,
          ),
        ),
      );
    }
  }
}
