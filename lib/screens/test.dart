import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfTest extends StatefulWidget {
  @override
  _SelfTestState createState() => _SelfTestState();
}

class _SelfTestState extends State<SelfTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            ExpansionTile(
              subtitle: Text(
                'Self-test website'
              ),
              title: Text('covid19.kpolom.com',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              leading: Icon(Icons.link),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          _launchInBrowser('https://covid19.kpolom.com');
                        },
                        child: Text(
                          'VISIT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ])),
    );
  }
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