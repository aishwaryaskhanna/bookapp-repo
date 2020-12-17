import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:book_app/theme/theme_config.dart';

class MainAppProvider extends ChangeNotifier {
  MainAppProvider();

  ThemeData theme = ThemeConfig.darkTheme;
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
