import 'package:flutter/material.dart';
import 'package:news_discovery_app/pages/Breakingnews.dart';
import 'package:news_discovery_app/pages/homepage.dart';
import 'package:news_discovery_app/pages/search.dart';
import 'package:news_discovery_app/utils/routes.dart';
import 'package:news_discovery_app/utils/widget/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyTheme.lightData,
      // initialRoute: MyRoutes.breakingNews,
      routes: {
        "/": (context) => const BreakingNews(),
        MyRoutes.breakingNews: (context) => BreakingNews(),
        MyRoutes.searchNews: (context) => SearchNEWS()
      },
    );
  }
}
