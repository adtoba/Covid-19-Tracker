import 'package:covid19/widgets/contact_card.dart';
import 'package:covid19/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String subject = 'From Covid-19 ';
  String body = 'New';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ListTile(
                  //   leading: Image.asset('assets/images/coronavirus.png'),
                  //   title: Text(
                  //     'Covid-19 Tracker',
                  //     style: TextStyle(fontSize: 25.0),
                  //   ),
                  // ),
                  Center(
                      child: ImageIcon(
                    AssetImage('assets/images/infoo.png'),
                    size: 100.0,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'This app was created for users all over the world to keep track of the Covid-19 virus. ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Note: This app was NOT created to create or instill fear in the minds of the users ',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Developer\'s contact',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                      icon: Image.asset(
                                          'assets/images/twitter.png'),
                                      onPressed: () {
                                        _launchInBrowser(
                                            'https://twitter.com/adetoba54');
                                      }),
                                  IconButton(
                                      icon: Image.asset(
                                          'assets/images/whatsapp.png'),
                                      onPressed: () {
                                        _launchInBrowser(
                                            'https://api.whatsapp.com/send?phone=+23408179477272');
                                      }),
                                  IconButton(
                                      icon: Image.asset(
                                          'assets/images/github.png'),
                                      onPressed: () {
                                        _launchInBrowser(
                                            'https://github.com/adtoba');
                                      }),
                                  IconButton(
                                      icon: Image.asset(
                                          'assets/images/gmail.png'),
                                      onPressed: () {
                                        _launchInBrowser(
                                            'https://mailto:adetoba53@gmail.com?subject=$subject&body=$body');
                                      })
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Data sources',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              SizedBox(height: 10.0),
                             
                             IconButton(
                                      icon: Image.asset(
                                          'assets/images/github.png'),
                                      onPressed: () {
                                        _launchInBrowser(
                                            'https://github.com/mathdroid/covid-19-api');
                                      }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        forceSafariVC: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
