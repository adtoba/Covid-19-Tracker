import 'package:flutter/material.dart';


class DetailBar extends StatelessWidget {
  const DetailBar({
    @required this.title,
    @required this.data,
    @required this.dataColor
  });

  final String title;
  final int data;
  final Color dataColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title, style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Text(
            data.toString(), style: TextStyle(fontSize: 20, color: dataColor),
          )
        ],
      ),
    );
  }
}