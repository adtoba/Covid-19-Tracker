import 'package:covid19/screens/news.dart';
import 'package:flutter/material.dart';
import 'package:covid19/utils/navigation.dart';
import 'package:covid19/utils/colors.dart';
import 'package:covid19/screens/search.dart';
import 'package:covid19/screens/tabs.dart';
import 'package:covid19/screens/tips.dart';





class HomePageView extends StatefulWidget {
  const HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Tabs(),
    NewsScreen()
  ];

  final PageController _controller = PageController(
    initialPage: 0,
    keepPage: true
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: onPageSelected,
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 10.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  onPageSelected(0);
                },
                icon: Icon(
                  Icons.cast,
                  semanticLabel: 'News',
                  color: _currentIndex == 0 
                    ? MkColors.rectangleColor 
                    : MkColors.iconColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  onPageSelected(1);
                },
                icon: Icon(
                  Icons.info_outline, 
                  color: _currentIndex == 1 
                    ? MkColors.rectangleColor 
                    : MkColors.iconColor),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            push(context, const SearchScreen());
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.search, color: MkColors.micColor),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked
    );
  }

  void onPageSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.jumpToPage(index);
  }
}