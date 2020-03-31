import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  String title;
  String subtitle;
  ContactCard({
    @required this.title,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          width: width,
          height: 100.0,
          child: ListTile(
            title: Text(
              '$title',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              "$subtitle",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Container(
                height: 40.0,
                width: 40.0,
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: Center(
                    child: Icon(
                  Icons.message,
                  color: Colors.white,
                ))),
          )),
    );
  }
}
