import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:covid19/screens/info.dart';
import 'package:covid19/screens/maps.dart';
import 'package:covid19/screens/prevention.dart';
import 'package:covid19/screens/regions.dart';
import 'package:covid19/screens/search.dart';
import 'package:covid19/screens/stats.dart';
import 'package:covid19/screens/test.dart';
import 'package:covid19/widgets/bottom_navigation.dart';
import 'package:covid19/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StatsViewModel statsViewModel;
  int _currentIndex = 0;

  List<Widget> _pages;
  BitmapDescriptor descriptor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final statsViewModel = Provider.of<StatsViewModel>(context, listen: true);
    if (this.statsViewModel != statsViewModel) {
      this.statsViewModel = statsViewModel;
      Future.microtask(() {
        BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(5, 5)),
                'assets/images/infected.png')
            .then((d) {
          descriptor = d;
          print('image created');
          print('image created');
        });
      });

      _pages = [
        HomeScreen(
          statsViewModel: statsViewModel,
        ),
        MapScreen(
          statsViewModel: statsViewModel,
        ),
        PreventionScreen(),
        SelfTest(),
        InformationScreen()
      ];
    }
  }

  void incrementTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.0,
          centerTitle: true,
          title: statsViewModel.currentIndex == 1
              ? Text(
                  'Affected regions',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              : (statsViewModel.currentIndex == 2)
                  ? Text(
                      "Information center",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  : (statsViewModel.currentIndex == 3)
                      ? Text(
                          "Self-test",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      : (statsViewModel.currentIndex == 4)
                          ? Text(
                              "About",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "World stats",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
          actions: <Widget>[
            statsViewModel.currentIndex == 0
                ? Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await Provider.of<StatsViewModel>(context,
                                  listen: false)
                              .getStats();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SearchScreen();
                          }));
                        },
                      )
                    ],
                  )
                : statsViewModel.currentIndex == 1
                    ? IconButton(
                        icon: Icon(
                          Icons.list,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return RegionScreen(
                              data: statsViewModel.confirmedCases,
                              model: statsViewModel,
                            );
                          }));
                        },
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      )
          ],
        ),
        body: IndexedStack(
          index: statsViewModel.currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          height: 60.0,
          child: BottomNavigationBar(
            // showSelectedLabels: true,

            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Colors.red,
            selectedIconTheme: IconThemeData(color: Colors.red),
            currentIndex: statsViewModel.currentIndex,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.show_chart,
                      color: statsViewModel.currentIndex == 0
                          ? Colors.red
                          : Colors.black),
                  title: Text(
                    'Stats',
                    style: TextStyle(
                      color: statsViewModel.currentIndex == 0
                          ? Colors.red
                          : Colors.black,
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on,
                      size: 18.0,
                      color: statsViewModel.currentIndex == 1
                          ? Colors.red
                          : Colors.black),
                  title: Text(
                    'Maps',
                    style: TextStyle(
                        color: statsViewModel.currentIndex == 1
                            ? Colors.red
                            : Colors.black),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bubble_chart,
                    color: statsViewModel.currentIndex == 2
                        ? Colors.red
                        : Colors.black,
                  ),
                  title: Text(
                    'Advices',
                    style: TextStyle(
                        color: statsViewModel.currentIndex == 2
                            ? Colors.red
                            : Colors.black),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.airline_seat_flat,
                    color: statsViewModel.currentIndex == 3
                        ? Colors.red
                        : Colors.black,
                  ),
                  title: Text(
                    'Self-test',
                    style: TextStyle(
                        color: statsViewModel.currentIndex == 3
                            ? Colors.red
                            : Colors.black),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.report,
                      color: statsViewModel.currentIndex == 4
                          ? Colors.red
                          : Colors.black),
                  title: Text(
                    'About',
                    style: TextStyle(
                        color: statsViewModel.currentIndex == 4
                            ? Colors.red
                            : Colors.black),
                  ))
            ],
            onTap: (index) {
              statsViewModel.setCurrentIndex(index);
            },
          ),
        ));
  }

  Widget getWidgetTable() {
    return Table(
      children: [
        TableRow(children: [
          TableCell(
            child: Row(),
          )
        ]),
      ],
    );
  }
}
