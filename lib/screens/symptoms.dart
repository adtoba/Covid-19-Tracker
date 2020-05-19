import 'package:flutter/material.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/colors.dart';


class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({Key key}) : super(key: key);

  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {

  List<String> symptomLabels = <String>[
    'Don\'t touch',
    'Spray',
    'Wear Masks',
    'Antiseptic'
  ];

  List<String> symptomAssets = <String>[
    'assets/images/dont-touch.png',
    'assets/images/spray.png',
    'assets/images/mask.png',
    'assets/images/antiseptic.png'
  ];

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Prevention'.toUpperCase(), 
              style: TextStyle(fontSize: config.sp(20.0), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: config.sh(20)),
            Text(
              'Keep your body healthy to avoid the spread of COVID-19', 
              style: TextStyle(fontSize: config.sp(20.0)),
            ),
            SizedBox(height: config.sh(20)),
            GridView.builder(
              itemCount: symptomLabels.length,
              semanticChildCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Image.asset(
                      symptomAssets[index], 
                      height: 100, 
                      width: 100
                    ),
                    const SizedBox(height: 10),
                    Text(
                      symptomLabels[index]
                    ),

                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}