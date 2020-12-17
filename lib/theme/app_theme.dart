import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Color(0xff121212),
    primaryColor: Color(0xff1f1f1f),
    accentColor: Colors.cyanAccent,
    scaffoldBackgroundColor: Color(0xff121212),
    cursorColor: Colors.cyanAccent,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );
}
