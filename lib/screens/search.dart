import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19/widgets/detail.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> 
            with SingleTickerProviderStateMixin<SearchScreen>{
  bool _hasSpeech = false;
  bool _stressTest = false;
  double level = 0.0;
  int _stressLoops = 0;
  String lastWords = "";
  String resultString = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  StatsViewModel statsViewModel;
  final SizeConfig config = SizeConfig();
  List<charts.Series<Task, String>> _seriesPieData;
  
  bool _loaded = false;

  int _total;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  List<String> months = <String>[
    'January', 'February', 'March' , 'April',
    'May', 'June', 'July', 'August', 'September', 'October',
    'November', 'December'
  ];

  ValueNotifier<String> speechWord = ValueNotifier<String>('');

  @override
  void didChangeDependencies() {
    final statsViewModel = Provider.of<StatsViewModel>(context, listen: false);
    if (this.statsViewModel != statsViewModel) {
      this.statsViewModel = statsViewModel;
      initSpeechState();
    }
    super.didChangeDependencies();
  }

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        statsViewModel.resetSearchStatus();
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.grey
          ),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: speech.isListening,
                      child: SpinKitDoubleBounce(
                        color: MkColors.greenColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20.0), 
                    Text(
                      speech.isListening
                       ? 'I\'m listening'
                       : lastWords.isNotEmpty
                       ? lastWords
                       : 'Tap the mic and say a country name',
                      style: TextStyle(
                        fontSize: config.sp(30),
                        color: Colors.black45
                      ), 
                    ),  
                    // Text(
                    //   speech.isListening
                    //     ? 'I\'m listening..'
                    //     : lastWords,
                    //   style: TextStyle(
                    //     fontSize: config.sp(30),
                    //     color: MkColors.iconColor
                    //   ), 
                    // ),          
                    // const SizedBox(height: 5.0),
                    Consumer<StatsViewModel>(
                      builder: (BuildContext context, StatsViewModel model, _) {
                        if(model.searchStatus == OperationStatus.SUCCESSFUL) {
                          _generateData(model);
                          return Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Corona Virus Cases',
                                  style: TextStyle(
                                      fontSize: config.sp(23),
                                      color: Colors.grey),
                                ),

                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: statsViewModel.searchStat?.confirmed?.value ?? 0), 
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
                                              color: Colors.black),
                                        ),                    
                                      ],
                                    );
                                  }
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: DetailBox(
                                        label: 'Deaths', 
                                        value: statsViewModel.searchStat?.deaths?.value ?? 0, 
                                        isDeath: true
                                      ),
                                    ),

                                    Expanded(
                                      child: DetailBox(
                                        label: 'Recovered', 
                                        value: statsViewModel.searchStat?.recovered?.value ?? 0, 
                                        isDeath: false
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  height: 220.0,
                                  width: double.infinity,
                                  child: charts.PieChart(
                                    _seriesPieData,
                                    animate: true,
                                    animationDuration: const Duration(seconds: 1),
                                    defaultRenderer: charts.ArcRendererConfig(
                                        arcWidth: 30, startAngle: 4 / 5 * 3.142, arcLength: 7 / 5 * 3.142,
                                        arcRendererDecorators:  <charts.ArcLabelDecorator>[
                                          charts.ArcLabelDecorator(
                                              outsideLabelStyleSpec: const charts.TextStyleSpec(
                                                  fontSize: 16, fontFamily: 'MuseoSans'),
                                              insideLabelStyleSpec: const charts.TextStyleSpec(
                                                  fontSize: 16, fontFamily: 'MuseoSans'),
                                              labelPosition: charts.ArcLabelPosition.auto)
                                        ]),
                                  ),
                                ),
                                
                              ],
                            ),
                          );
                        } else if(model.searchStatus == OperationStatus.FAILED) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: const Text('Country not found'),
                            ),
                          );
                        
                        } else {
                          return Visibility(
                            visible: model.searchStatus == OperationStatus.LOADING,
                            child: Align(
                              alignment: Alignment.center,
                              child: SpinKitChasingDots(
                                color: MkColors.rectangleColor,
                                size: 50.0,
                              ),
                            ),
                          ); 
                        }
                      } ,
                    ),     
                  ],
                ),
              ),
            ),

               
          ]
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              statsViewModel.resetSearchStatus();
              startListening();
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              child: const Icon(Icons.mic),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                boxShadow: <BoxShadow>[
                  BoxShadow(
                   color: speech.isListening ? Colors.green[400] : Colors.grey[400],
                   offset: const Offset(4.0, 4.0),
                   blurRadius: 8.0,
                   spreadRadius: 1.0 
                  ),
                  BoxShadow(
                   color: speech.isListening ? Colors.green[400] : Colors.grey[400],
                   offset: const Offset(-4.0, -4.0),
                   blurRadius: 8.0,
                   spreadRadius: 1.0 
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.grey[200],
                    Colors.grey[300],
                    Colors.grey[400],
                    Colors.grey[500],
                  ],
                  stops: const <double>[
                    0.1,
                    0.3,
                    0.8,
                    0.9
                  ]
                )
              ),
            ),
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<void> initSpeechState() async {
    final bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) 
      return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void stressTest() {
    if (_stressTest) {
      return;
    }
    _stressLoops = 0;
    _stressTest = true;
    print('Starting stress test...');
    startListening();
  }

  void changeStatusForStress(String status) {
    if (!_stressTest) {
      return;
    }
    if (speech.isListening) {
      stopListening();
    } else {
      if (_stressLoops >= 100) {
        _stressTest = false;
        print("Stress test complete.");
        return;
      }
      print("Stress loop: $_stressLoops");
      ++_stressLoops;
      startListening();
    }
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
      speechWord.value = lastWords;
      
    });
    statsViewModel.searchCases(lastWords);
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    changeStatusForStress(status);
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  void _generateData(StatsViewModel model) {
    _seriesPieData = List<charts.Series<Task, String>>();
    final List<Task> pieData = <Task>[
      Task('Confirmed', model.searchStat.confirmed.value, Colors.blue),
      Task('Recovered', model.searchStat.recovered.value, Colors.green),
      Task('Deaths', model.searchStat.deaths.value, Colors.red)
    ];

    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        id: 'Total cases',
        labelAccessorFn: (Task row, _) => '${row.task}'
      ));
  }
}

class Task {
  String task;
  int taskValue;
  Color colorValue;

  Task(this.task, this.taskValue, this.colorValue);
}
