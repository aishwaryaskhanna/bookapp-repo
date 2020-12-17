import 'package:flutter/material.dart';
import 'package:book_app/components/exit_popup.dart';
import 'package:book_app/views/home_page.dart';
import 'package:book_app/views/options_page.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ExitPopup().showExitDialog(context),
      child: Scaffold(
        body: PageView(
          physics: ClampingScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.grey[500],
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Feather.book_open,
              ),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Feather.list,
              ),
              title: Text(
                'Options',
              ),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
