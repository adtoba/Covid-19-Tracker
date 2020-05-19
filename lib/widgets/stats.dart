import 'package:covid19/widgets/bar.dart';
import 'package:flutter/material.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({
    @required this.confirmedCases,
    @required this.recoveredCases,
    @required this.activeCases,
    @required this.deathCases
  });

  final int confirmedCases;
  final int recoveredCases;
  final int activeCases;
  final int deathCases;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white,
      child: Container(
        width: deviceWidth,
        child: Column(
          children: <Widget>[
            Container(
              width: deviceWidth,
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: <Widget>[
                  const Text(
                    'World cases', style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    confirmedCases.toString(),
                    style: TextStyle(
                      fontSize: 30, 
                      fontWeight: 
                      FontWeight.w900, 
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DetailBar(
                    title: 'Recovered', 
                    data: recoveredCases, 
                    dataColor: Colors.green
                  ),
                  const Divider(),
                  DetailBar(
                    title: 'Deaths', 
                    data: deathCases, 
                    dataColor: Colors.red
                  ),
                  const Divider(),
                  DetailBar(
                    title: 'Active cases', 
                    data: deathCases, 
                    dataColor: Colors.black
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
