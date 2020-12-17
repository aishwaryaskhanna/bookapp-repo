import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:book_app/components/widget_creator.dart';
import 'package:book_app/models/category.dart';
import 'package:book_app/utility/page_router.dart';
import 'package:book_app/models/home_model.dart';
import 'package:book_app/views/categorized_books_page.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomePageModel>(context, listen: false).getFeeds(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomePageModel>(
      builder:
          (BuildContext context, HomePageModel homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Book App',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          body: WidgetCreator(
            response: homeProvider.response,
            child: RefreshIndicator(
              onRefresh: () => homeProvider.getFeeds(),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Explore Categories',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.0),
                  Container(
                    height: 420.0,
                    child: Center(
                      child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.symmetric(horizontal: 70.0),
                        scrollDirection: Axis.vertical,
                        itemCount: homeProvider?.top?.feed?.link?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Link link = homeProvider.top.feed.link[index];
                          if (index < 10) {
                            return SizedBox();
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.cyan[600],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                onTap: () {
                                  PageRouter.pushPage(
                                    context,
                                    Genre(
                                      title: '${link.title}',
                                      url: link.href,
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      '${link.title}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            reload: () => homeProvider.getFeeds(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
