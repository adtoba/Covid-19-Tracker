import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19/bloc/models/confirmed.dart';
import 'package:covid19/bloc/models/stats.dart';
import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:covid19/screens/home.dart';
import 'package:covid19/screens/search.dart';
import 'package:covid19/utils/charts.dart';
import 'package:covid19/widgets/data_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({@required this.statsViewModel});
  final StatsViewModel statsViewModel;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Task {
  String task;
  int taskValue;
  Color colorValue;

  Task(this.task, this.taskValue, this.colorValue);
}

class _HomeScreenState extends State<HomeScreen> {
  StatsViewModel statsViewModel;
  List<ConfirmedCases> confirmedCases;
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData(StatsViewModel model) {
    _seriesPieData = List<charts.Series<Task, String>>();
    var pieData = [
      new Task('Confirmed', model.stat.confirmed.value, Colors.blue),
      new Task('Recovered', model.stat.recovered.value, Colors.green),
      new Task('Deaths', model.stat.deaths.value, Colors.red)
    ];

    _seriesPieData.add(charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        id: 'Total cases',
        labelAccessorFn: (Task row, _) => '${row.task}'));
  }

  @override
  void initState() {
    _generateData(widget.statsViewModel);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _generateData(widget.statsViewModel);
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
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return Scaffold(
      body: Consumer<StatsViewModel>(builder: (context, model, child) {
        Stats stats = model.stat;
        confirmedCases = model.confirmedCases;

        if (model.viewStatus == ViewStatus.Loading) {
          return LoadingView();
        }

        return SingleChildScrollView(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 220.0,
                  width: deviceWidth,
                  child: charts.PieChart(
                    _seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 1),
                    defaultRenderer:
                        new charts.ArcRendererConfig(
                          arcLength: 3 / 2 * 3.142,
                          arcRendererDecorators: [
                      new charts.ArcLabelDecorator(
                          outsideLabelStyleSpec: new charts.TextStyleSpec(
                              fontSize: 16, fontFamily: 'MuseoSans'),
                          insideLabelStyleSpec: new charts.TextStyleSpec(
                              fontSize: 16, fontFamily: 'MuseoSans'),
                          labelPosition: charts.ArcLabelPosition.auto)
                    ]),
                  ),
                ),
                SizedBox(height: 20.0),
                DataCard(
                  title: 'Affected locations',
                  textColor: Colors.black,
                  icon: ImageIcon(
                    AssetImage('assets/images/region.png'),
                  ),
                  value: confirmedCases.length.toString(),
                  onPressed: () {
                    widget.statsViewModel.setCurrentIndex(1);
                  },
                ),
                SizedBox(height: 20.0),
                DataCard(
                  title: 'Confirmed cases',
                  textColor: Colors.black,
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/confirmed.png',
                    ),
                    color: Colors.blue,
                  ),
                  value: stats.confirmed.value.toString(),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SearchScreen();
                    }));
                  },
                ),
                SizedBox(height: 20.0),
                DataCard(
                  title: 'Recovered cases',
                  textColor: Colors.green,
                  icon: ImageIcon(
                    AssetImage('assets/images/confirmed.png'),
                    color: Colors.green,
                  ),
                  value: stats.recovered.value.toString(),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SearchScreen();
                    }));
                  },
                ),
                SizedBox(height: 20.0),
                DataCard(
                  title: 'Death cases',
                  textColor: Colors.red,
                  icon: ImageIcon(
                    AssetImage('assets/images/deaths.png'),
                    color: Colors.redAccent,
                  ),
                  value: stats.deaths.value.toString(),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SearchScreen();
                    }));
                  },
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}

class LoadingView extends StatelessWidget {
  LoadingView({this.isTextVisible = false});

  bool isTextVisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 20),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFF3C4858)),
          ),
        ),
        isTextVisible ? Text('Fetching stats ') : SizedBox(height: 0.0),
      ],
    );
  }
}
