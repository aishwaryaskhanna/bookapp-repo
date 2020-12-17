import 'package:book_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:book_app/models/main_app_model.dart';
import 'package:book_app/models/book_page_model.dart';
import 'package:book_app/models/liked_books_model.dart';
import 'package:book_app/models/category_model.dart';
import 'package:book_app/models/home_model.dart';
import 'package:book_app/views/home_bottom_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainAppProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => BookPageProvider()),
        ChangeNotifierProvider(create: (_) => LikedBooksModel()),
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
          darkTheme: appTheme(AppTheme.darkTheme),
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
