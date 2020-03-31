import 'dart:async';

import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:covid19/screens/home.dart';
import 'package:covid19/screens/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

const ERROR_MESSAGE = "😥 Something went wrong. Please try again later!";
const ERROR_CONNECTIVITY = 'No connection, Try again';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StatsViewModel statsViewModel;

  // @override
  // void initState() {
  //   super.initState();
  //    Timer(Duration(seconds: 2), () async {

  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return Home();
  //     }));
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Timer(Duration(seconds: 2), () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      print(connectivityResult);
      if (connectivityResult == ConnectivityResult.mobile) {
        runTask();
      } else if (connectivityResult == ConnectivityResult.wifi) {
        runTask();
      } else {
        displayDialog();
      }
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return Home();
      // }));
    });
  }

  void runTask() {
    final statsViewModel = Provider.of<StatsViewModel>(context, listen: false);
    if (this.statsViewModel != statsViewModel) {
      this.statsViewModel = statsViewModel;

      Future.microtask(() async {
        await statsViewModel.getAllCases();
        statsViewModel.message == ERROR_MESSAGE
            ? displayDialog()
            : Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                return Home();
              }));
      });
    }
  }

  void displayDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.error),
            content: Text(
              '$ERROR_MESSAGE',
              maxLines: 5,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/coronavirus.png'),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Covid-19 Tracker',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 30.0),
            LoadingView(
              isTextVisible: false,
            )
          ],
        )),
      ),
    );
  }
}
