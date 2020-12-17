import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_app/theme/app_theme.dart';

class MainAppModel extends ChangeNotifier {
  MainAppModel();

  ThemeData theme = AppTheme.darkTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }
}
