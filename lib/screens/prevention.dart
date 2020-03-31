import 'package:covid19/screens/aid.dart';
import 'package:covid19/screens/prevent.dart';
import 'package:covid19/screens/spread.dart';
import 'package:covid19/screens/symptoms.dart';
import 'package:covid19/widgets/info_card.dart';
import 'package:flutter/material.dart';

class PreventionScreen extends StatefulWidget {
  @override
  _PreventionScreenState createState() => _PreventionScreenState();
}

class _PreventionScreenState extends State<PreventionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // color: Colors.grey[200],
          child: Container(
            // color: Colors.grey[200],
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                InfoCard(
                  iconData: "assets/images/how.png",
                  title: "How it spreads",
                  subtitle: "Learn how Covid-19 spread",
                  iconColor: Colors.purple,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Spread();
                    }));
                  },
                ),
                InfoCard(
                    iconData: "assets/images/symptoms.png",
                    title: "Symptoms",
                    subtitle: "Learn Covid-19 symptoms",
                    iconColor: Colors.orange,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SymptomScreen();
                      }));
                    }),
                InfoCard(
                  iconData: "assets/images/prevention.png",
                  title: "Prevention & treatment",
                  subtitle: "Tips on how to prevent Covid-19",
                  iconColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Prevention();
                    }));
                  },
                ),
                InfoCard(
                  iconData: "assets/images/what.png",
                  title: "What to do",
                  subtitle: "Tips on what to do",
                  iconColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Aid();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
