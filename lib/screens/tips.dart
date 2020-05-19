import 'package:flutter/material.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/colors.dart';
import 'package:covid19/widgets/info.dart';
import 'package:covid19/utils/navigation.dart';
import 'package:covid19/screens/symptoms.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({Key key}) : super(key: key);

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
            height: config.sh(300),
            width: config.sw(300),
            child: Image.asset('assets/images/virus.png')
          ),
          const Text('COVID 19'),
          const Text('Find what you\nneed to survive', style: TextStyle(fontSize: 20),),
          InfoBar( 
            label: 'Symptoms',
            color: MkColors.rectangleColor,
            onPressed: () => push(context, const SymptomsScreen()),
          ),

          InfoBar( 
            label: 'Prevention',
            color: MkColors.greenColor,
            onPressed: () => push(context, const SymptomsScreen()),
          )
        ],),
      )
    );
  }
}