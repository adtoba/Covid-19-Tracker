import 'package:covid19/bloc/models/confirmed.dart';
import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/viewmodels/stats.dart';
import 'package:flutter/material.dart';

class RegionScreen extends StatefulWidget {
  RegionScreen({@required this.data, @required this.model});

  final List<ConfirmedCases> data;
  final StatsViewModel model;
  @override
  _RegionScreenState createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Province stats',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${widget.data[index].provinceState ?? widget.data[index].countryRegion}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${widget.data[index].confirmed}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${widget.data[index].recovered}',
                      style: TextStyle(fontSize: 18.0, color: Colors.green),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${widget.data[index].deaths}',
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
