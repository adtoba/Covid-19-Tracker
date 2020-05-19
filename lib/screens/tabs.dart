import 'dart:ui';

import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/screens/faqs.dart';
import 'package:covid19/screens/search.dart';
import 'package:covid19/screens/speech.dart';
import 'package:covid19/screens/tips.dart';
import 'package:covid19/utils/chart.dart';
import 'package:covid19/utils/colors.dart';
import 'package:covid19/utils/dateformat.dart';
import 'package:covid19/utils/navigation.dart';
import 'package:covid19/widgets/detail.dart';
import 'package:covid19/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin<Tabs>{
  List<String> months = <String>[
    'January', 'February', 'March' , 'April',
    'May', 'June', 'July', 'August', 'September', 
    'October','November', 'December'
  ];

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  StatsViewModel viewModel;

  Position _currentPosition;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    final StatsViewModel viewModel = Provider.of<StatsViewModel>(context);
    if (this.viewModel != viewModel) {
      this.viewModel = viewModel;
      Future<void>.microtask(() {
        // _initCurrentLocation();
        viewModel.getStats();
      });
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    // _initCurrentLocation();
    super.initState();
  }

  

   _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = true
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((position) {
        print(position.latitude.toString());
        print(position.latitude.toString());
        print(position.latitude.toString());
        print(position.latitude.toString());
        print(position.latitude.toString());
        if (mounted) {
          setState(() => _currentPosition = position);
          print(position.latitude.toString());
        }
      }).catchError((e) {
        //
        print(e.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: MkColors.rectangleColor,
                    height: config.sh(300),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          top: 50.0,
                          left: 30.0,
                          right: 30.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  const Hero(
                                    tag: 'iconHero',
                                    child: Icon(
                                      Icons.my_location,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: config.sh(30.0),
                              ),
                              Builder(
                                builder: (BuildContext context) {
                                  if(viewModel?.stat?.lastUpdated == null) {
                                    return const Text('');
                                  } else {
                                    final String lastUpdated = formatUpdatedTime(viewModel?.stat?.lastUpdated ?? '0000:00:00 00:00:00', months);
                                    return Text(
                                      lastUpdated,
                                      style: TextStyle(
                                        fontSize: config.sp(14),
                                        color: Colors.white),
                                    );
                                  } 
                              },
                                
                              ),
                              SizedBox(height: config.sh(2.0)),
                              Text(
                                'Corona Virus Cases',
                                style: TextStyle(
                                    fontSize: config.sp(23),
                                    color: Colors.white),
                              ),

                              TweenAnimationBuilder<int>(
                                tween: IntTween(begin: 0, end: viewModel.stat?.confirmed?.value ?? 0), 
                                duration: const Duration(seconds: 2), 
                                builder: (BuildContext context, int i, Widget child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '$i'.toString().replaceAllMapped(reg, mathFunc),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: config.sp(50),
                                            color: Colors.white),
                                      ),

                                      Selector<StatsViewModel, OperationStatus>(
                                        selector: (BuildContext context, StatsViewModel model) 
                                            => model.statStatus,
                                        builder: (BuildContext context, OperationStatus opStatus, _) {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            if(opStatus == OperationStatus.SUCCESSFUL) {
                                              viewModel.resetStats();
                                            } else if(opStatus == OperationStatus.FAILED) {
                                              print('Error occured');
                                              viewModel.resetStats();
                                            }

                                          });
                                           return Visibility(
                                              visible: opStatus == OperationStatus.LOADING,
                                              child: const SpinKitThreeBounce(
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            );
                                          },
                                        ),        
                                    ],
                                  );
                                }
                              ),
                              
                            ],
                          ),
                        ),

                        
                        Positioned(
                            bottom: -100,
                            right: 20.0,
                            left: 20.0,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: DetailBox(
                                    label: 'Deaths',
                                    value: viewModel.stat?.deaths?.value ?? 0,
                                    isDeath: true,
                                  ),
                                ),
                                SizedBox(width: config.sw(5.0)),
                                Expanded(
                                  child: DetailBox(
                                    label: 'Recovered',
                                    value: viewModel.stat?.recovered?.value ?? 0,
                                    isDeath: false,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: config.sh(100)),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: InkWell(
                            onTap: () => push(context, const TipsScreen()),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              width: double.infinity,
                              child: ListTile(
                                dense: false,
                                leading: Image.asset('assets/images/mask.png'),
                                title: Text('Useful Tips', style: TextStyle(fontSize: config.sp(21)),),
                                subtitle: const Text('Find out what you need to know about covid19'),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: config.sh(10.0)),

                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: InkWell(
                            onTap: () {
                              push(context, FaqScreen());
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: double.infinity,
                              child: ListTile(
                                leading: Image.asset('assets/images/voice_scan.png'),
                                title: Text('FAQS', style: TextStyle(fontSize: config.sp(21)),),
                                subtitle: const Text('See the frequently asked questions on covid19'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                 
                ],
              ),
            )
          ],
        ),
       
      );
  }
}
