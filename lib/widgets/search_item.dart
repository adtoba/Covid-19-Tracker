import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  SearchItem(
      {@required this.country,
      @required this.confirmed,
      @required this.recovered,
      @required this.deaths,
      @required this.url,
      @required this.lastUpdated});

  final String country;
  final String confirmed;
  final String recovered;
  final String deaths;
  final String url;
  final String lastUpdated;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          '${country.toUpperCase()}',
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${lastUpdated.substring(0, 10)} (${lastUpdated.substring(12, 19)})',
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '${confirmed.toString()}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('Confirmed'),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${recovered.toString()}',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('Recovered'),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${deaths.toString()}',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('Deaths'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage('$url')),
              ))
        ],
      )),
    );
  }
}
