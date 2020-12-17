import 'package:flutter/material.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:book_app/view_models/app_provider.dart';
import 'package:book_app/view_models/book_page_provider.dart';
import 'package:book_app/view_models/liked_books_provider.dart';
import 'package:book_app/view_models/category_provider.dart';
import 'package:book_app/view_models/home_provider.dart';
import 'package:book_app/views/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainAppProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => BookPageProvider()),
        ChangeNotifierProvider(create: (_) => LikedBooksProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppProvider>(
      builder:
          (BuildContext context, MainAppProvider appProvider, Widget child) {
        return MaterialApp(
          title: 'Book App',
          theme: appTheme(appProvider.theme),
          darkTheme: appTheme(ThemeConfig.darkTheme),
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      },
    );
  }

  ThemeData appTheme(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSerifProTextTheme(
        theme.textTheme,
      ),
    );
  }
}
