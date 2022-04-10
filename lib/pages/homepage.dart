import 'package:flutter/material.dart';
import 'package:news_discovery_app/pages/Breakingnews.dart';
import 'package:news_discovery_app/pages/currentnews.dart';
// import 'package:news_discovery_app/pages/news.dart';
import 'package:news_discovery_app/pages/search.dart';

class BreakingNews extends StatefulWidget {
  const BreakingNews({Key? key}) : super(key: key);

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    // Icon(Icons.heart_broken),
    CurrentNEWS(),
    BreakingNEWS(),
    SearchNEWS()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MVVMNewsAPP")),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),

      // buttom Navbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Breaking News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.density_small_rounded),
            label: 'Seach News',
          ),
        ],
      ),
    );
  }
}
