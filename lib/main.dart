import 'package:covid19/bloc/services/locator.dart';
import 'package:covid19/bloc/viewmodels/faqs.dart';
import 'package:covid19/bloc/viewmodels/news.dart';
import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/screens/splash.dart';
import 'package:covid19/screens/tabs.dart';
import 'package:covid19/screens/pageview.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
       ChangeNotifierProvider<StatsViewModel>(create: (BuildContext context) => StatsViewModel()),
       ChangeNotifierProvider<NewsViewModel>(create: (BuildContext context) => NewsViewModel()),
       ChangeNotifierProvider<FaqsViewModel>(create: (BuildContext context) => FaqsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid-19 Tracker',
        theme: ThemeData(
          fontFamily: 'MuseoSans',
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (BuildContext context) {
            SizeConfig.init(context, width: 360, height: 640, allowFontScaling: true);
            return const HomePageView();
          }
        )
      ),
    );
  }
}
