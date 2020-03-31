import 'package:flutter/material.dart';


class SingleItem extends StatelessWidget {
  SingleItem({
    @required this.text,
    @required this.color
  });

  String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: color,
      child: Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$text'
              ),
            )
          ],
        ),
      ),
    );
  }
}